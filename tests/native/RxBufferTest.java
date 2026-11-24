import java.util.Arrays;

/**
 * Reference-model test for PhevRxBuffer.smali (persistent TCP receive buffer).
 *
 * IMPORTANT: this tests the framing ALGORITHM. checksum/xorWith/tryDecodeOne are Java
 * ports of PhevMiniProtocol.smali and RxBuf mirrors PhevRxBuffer.smali line by line.
 * The smali itself is only assembled (apktool), never executed here; it has not run on
 * a device or a car.
 */
public class RxBufferTest {
    static int checksum(int[] a, int n) { int s = 0; for (int i = 0; i < n - 1; i++) s += a[i]; return s & 0xff; }
    static int[] xorWith(int[] a, int k) { int[] r = new int[a.length]; for (int i = 0; i < a.length; i++) r[i] = (a[i] ^ k) & 0xff; return r; }

    static class Frame { int type, ack, register, xor; int[] data; }

    static Frame tryDecodeOne(int[] p) {
        if (p.length < 4) return null;
        for (int x : new int[]{p[2], p[2] ^ 1}) {
            int len = (p[1] ^ x) + 2;
            if (len < 3 || len > 0xfd) continue;
            if (p.length < len) continue;
            int[] d = xorWith(Arrays.copyOf(p, len), x);
            if (checksum(d, len) != d[len - 1]) continue;
            Frame f = new Frame();
            f.type = d[0]; f.ack = d[2]; f.register = d[3];
            f.data = Arrays.copyOfRange(d, 4, len - 1); f.xor = x;
            return f;
        }
        return null;
    }

    static class RxBuf {
        int[] buf = new int[0]; int[] lastRaw = new int[0];
        void feed(byte[] b, int n) {
            int[] r = Arrays.copyOf(buf, buf.length + n);
            for (int i = 0; i < n; i++) r[buf.length + i] = b[i] & 0xff;
            buf = r;
        }
        Frame next() {
            while (true) {
                int n = buf.length;
                if (n < 4) return null;
                Frame f = tryDecodeOne(buf);
                if (f != null) {
                    int len = (buf[1] ^ f.xor) + 2;
                    lastRaw = Arrays.copyOf(buf, len);
                    buf = Arrays.copyOfRange(buf, len, n);
                    return f;
                }
                int t = buf[1] ^ buf[2];
                int l0 = t + 2, l1 = (t ^ 1) + 2;
                if (l0 >= 3 && l0 <= 0xfd && l0 > n) return null;
                if (l1 >= 3 && l1 <= 0xfd && l1 > n) return null;
                buf = Arrays.copyOfRange(buf, 1, n);
            }
        }
    }

    /** Wire frame: [type, dataLen+3 ^ xor, ack ^ xor, reg ^ xor, data ^ xor..., chk ^ xor] (ack 0 or 1). */
    static byte[] wire(int type, int ack, int reg, int[] data, int xor) {
        int[] f = new int[data.length + 5];
        f[0] = type; f[1] = data.length + 3; f[2] = ack; f[3] = reg;
        System.arraycopy(data, 0, f, 4, data.length);
        f[f.length - 1] = checksum(f, f.length);
        int[] x = xorWith(f, xor);
        byte[] b = new byte[x.length];
        for (int i = 0; i < b.length; i++) b[i] = (byte) x[i];
        return b;
    }

    static byte[] cat(byte[]... p) { int n = 0; for (byte[] a : p) n += a.length; byte[] r = new byte[n]; int o = 0; for (byte[] a : p) { System.arraycopy(a, 0, r, o, a.length); o += a.length; } return r; }
    static int fails = 0;
    static void check(boolean c, String m) { if (!c) { fails++; System.out.println("FAIL: " + m); } else System.out.println("ok:   " + m); }

    public static void main(String[] a) {
        int[] key = new int[9]; key[0] = 0x0c - 0; // arbitrary payload (9 bytes -> 14-byte frame)
        for (int i = 0; i < 9; i++) key[i] = 0x10 + i;
        byte[] start = wire(0x4e, 0, 0x00, key, 0x5a);
        byte[] resp = wire(0x6f, 1, 0x10, new int[]{0}, 0x33);
        byte[] ping = wire(0xf3, 0, 0x00, new int[]{0}, 0x21);
        check(start.length == 14, "start frame is 14 bytes");

        RxBuf r = new RxBuf(); r.feed(start, 14);
        Frame f = r.next();
        check(f != null && f.type == 0x4e && r.lastRaw.length == 14 && r.buf.length == 0, "whole frame in one read");

        r = new RxBuf(); r.feed(Arrays.copyOf(start, 5), 5);
        check(r.next() == null, "partial frame (5 bytes) yields nothing");
        r.feed(Arrays.copyOfRange(start, 5, 14), 9);
        f = r.next();
        check(f != null && f.type == 0x4e && r.lastRaw.length == 14, "frame completed by second read");

        byte[] two = cat(start, resp);
        r = new RxBuf(); r.feed(two, two.length);
        f = r.next();
        check(f != null && f.type == 0x4e && r.lastRaw.length == 14, "two frames in one read: first is the 14-byte start frame");
        Frame g = r.next();
        check(g != null && g.type == 0x6f && g.ack == 1 && g.register == 0x10, "second frame preserved (leftover bytes kept)");
        check(r.next() == null && r.buf.length == 0, "buffer empty afterwards");

        byte[] three = cat(ping, start, resp);
        r = new RxBuf(); r.feed(three, 7);
        int cnt = 0; Frame x; int[] types = new int[4];
        while ((x = r.next()) != null && cnt < 4) types[cnt++] = x.type;
        r.feed(Arrays.copyOfRange(three, 7, three.length), three.length - 7);
        while ((x = r.next()) != null && cnt < 4) types[cnt++] = x.type;
        check(cnt == 3 && types[0] == 0xf3 && types[1] == 0x4e && types[2] == 0x6f, "three frames across two reads (split inside a frame), in order");

        // Known limitation (documented): a corrupt/garbage head that happens to look like a
        // longer, still incomplete frame makes next() wait for more bytes instead of resyncing.
        // No bytes are lost and nothing crashes; the 10 s handshake deadline then ends the attempt.
        byte[] bad = start.clone(); bad[6] ^= 0x40;
        r = new RxBuf(); r.feed(bad, bad.length);
        int before = r.buf.length;
        Frame none = r.next();
        check(none == null, "corrupt frame is never returned as valid");
        check(r.buf.length <= before, "corrupt data never grows the buffer");

        byte[] noisy = cat(new byte[]{(byte) 0xff}, start);
        r = new RxBuf(); r.feed(noisy, noisy.length);
        Frame nf = r.next();
        check(nf == null || nf.type == 0x4e, "garbage prefix: either waits or recovers the real frame, never a wrong frame");

        r = new RxBuf(); r.feed(new byte[]{1, 2}, 2);
        check(r.next() == null && r.buf.length == 2, "fewer than 4 bytes are kept, not discarded");

        System.out.println(fails == 0 ? "ALL PASSED" : fails + " FAILED");
        System.exit(fails == 0 ? 0 : 1);
    }
}

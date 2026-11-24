.class public final Lro/outyds/remote/PhevRxBuffer;
.super Ljava/lang/Object;
.source "PhevRxBuffer.java"

# Persistent TCP receive buffer: keeps partial frames and leftover bytes between reads
# and hands out one complete, checksum-valid frame at a time (see tests/native/).

# instance fields
.field private buf:[I

.field public lastRaw:[I

.field private final tmp:[B

# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    new-array v0, v0, [I

    iput-object v0, p0, Lro/outyds/remote/PhevRxBuffer;->buf:[I

    const/4 v0, 0x0

    new-array v0, v0, [I

    iput-object v0, p0, Lro/outyds/remote/PhevRxBuffer;->lastRaw:[I

    const/16 v0, 0x200

    new-array v0, v0, [B

    iput-object v0, p0, Lro/outyds/remote/PhevRxBuffer;->tmp:[B

    return-void
.end method

# virtual methods
.method public feed([BI)V
    .locals 5

    iget-object v0, p0, Lro/outyds/remote/PhevRxBuffer;->buf:[I

    array-length v1, v0

    add-int v2, v1, p2

    new-array v2, v2, [I

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    const/4 v3, 0x0

    :goto_loop
    if-ge v3, p2, :cond_done

    aget-byte v4, p1, v3

    and-int/lit16 v4, v4, 0xff

    add-int v0, v1, v3

    aput v4, v2, v0

    add-int/lit8 v3, v3, 0x1

    goto :goto_loop

    :cond_done
    iput-object v2, p0, Lro/outyds/remote/PhevRxBuffer;->buf:[I

    return-void
.end method

.method public next()Lro/outyds/remote/PhevMiniProtocol$Frame;
    .locals 7

    :goto_loop
    iget-object v0, p0, Lro/outyds/remote/PhevRxBuffer;->buf:[I

    array-length v1, v0

    const/4 v2, 0x4

    if-ge v1, v2, :cond_have

    const/4 v0, 0x0

    return-object v0

    :cond_have
    invoke-static {v0}, Lro/outyds/remote/PhevMiniProtocol;->tryDecodeOne([I)Lro/outyds/remote/PhevMiniProtocol$Frame;

    move-result-object v2

    if-eqz v2, :cond_nodecode

    const/4 v3, 0x1

    aget v3, v0, v3

    iget v4, v2, Lro/outyds/remote/PhevMiniProtocol$Frame;->xor:I

    xor-int/2addr v3, v4

    add-int/lit8 v3, v3, 0x2

    invoke-static {v0, v3}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v4

    iput-object v4, p0, Lro/outyds/remote/PhevRxBuffer;->lastRaw:[I

    invoke-static {v0, v3, v1}, Ljava/util/Arrays;->copyOfRange([III)[I

    move-result-object v4

    iput-object v4, p0, Lro/outyds/remote/PhevRxBuffer;->buf:[I

    return-object v2

    :cond_nodecode
    const/4 v2, 0x2

    aget v2, v0, v2

    const/4 v3, 0x1

    aget v3, v0, v3

    xor-int/2addr v3, v2

    add-int/lit8 v4, v3, 0x2

    xor-int/lit8 v5, v3, 0x1

    add-int/lit8 v5, v5, 0x2

    const/4 v6, 0x3

    if-lt v4, v6, :cond_chk1

    const/16 v6, 0xfd

    if-gt v4, v6, :cond_chk1

    if-gt v4, v1, :cond_wait

    :cond_chk1
    const/4 v6, 0x3

    if-lt v5, v6, :cond_drop

    const/16 v6, 0xfd

    if-gt v5, v6, :cond_drop

    if-gt v5, v1, :cond_wait

    :cond_drop
    const/4 v2, 0x1

    invoke-static {v0, v2, v1}, Ljava/util/Arrays;->copyOfRange([III)[I

    move-result-object v0

    iput-object v0, p0, Lro/outyds/remote/PhevRxBuffer;->buf:[I

    goto :goto_loop

    :cond_wait
    const/4 v0, 0x0

    return-object v0
.end method

.method public readMore(Ljava/io/InputStream;)I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    iget-object v0, p0, Lro/outyds/remote/PhevRxBuffer;->tmp:[B

    invoke-virtual {p1, v0}, Ljava/io/InputStream;->read([B)I

    move-result v1

    if-lez v1, :cond_done

    invoke-virtual {p0, v0, v1}, Lro/outyds/remote/PhevRxBuffer;->feed([BI)V

    :cond_done
    return v1
.end method

.class public final Lro/outy/app/WifiLink;
.super Ljava/lang/Object;
.source "WifiLink.java"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field private final act:Lro/outy/app/MainActivity;

.field private final gen:I

.field private final host:Ljava/lang/String;

.field private final port:I


# direct methods
.method public constructor <init>(Lro/outy/app/MainActivity;Ljava/lang/String;II)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lro/outy/app/WifiLink;->act:Lro/outy/app/MainActivity;

    iput-object p2, p0, Lro/outy/app/WifiLink;->host:Ljava/lang/String;

    iput p3, p0, Lro/outy/app/WifiLink;->port:I

    iput p4, p0, Lro/outy/app/WifiLink;->gen:I

    return-void
.end method


# virtual methods
.method public run()V
    .locals 10

    const/4 v0, 0x0

    :try_start_0
    new-instance v0, Ljava/net/Socket;

    invoke-direct {v0}, Ljava/net/Socket;-><init>()V

    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_fail

    :try_start_bind
    iget-object v1, p0, Lro/outy/app/WifiLink;->act:Lro/outy/app/MainActivity;

    const-string v2, "connectivity"

    invoke-virtual {v1, v2}, Lro/outy/app/MainActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/ConnectivityManager;

    invoke-virtual {v1}, Landroid/net/ConnectivityManager;->getAllNetworks()[Landroid/net/Network;

    move-result-object v2

    array-length v3, v2

    const/4 v4, 0x0

    :loop_nets
    if-ge v4, v3, :end_bind

    aget-object v5, v2, v4

    invoke-virtual {v1, v5}, Landroid/net/ConnectivityManager;->getNetworkCapabilities(Landroid/net/Network;)Landroid/net/NetworkCapabilities;

    move-result-object v6

    if-eqz v6, :next_net

    const/4 v7, 0x1

    invoke-virtual {v6, v7}, Landroid/net/NetworkCapabilities;->hasTransport(I)Z

    move-result v6

    if-eqz v6, :next_net

    invoke-virtual {v5, v0}, Landroid/net/Network;->bindSocket(Ljava/net/Socket;)V

    goto :end_bind

    :next_net
    add-int/lit8 v4, v4, 0x1

    goto :loop_nets

    :end_bind
    :try_end_bind
    .catch Ljava/lang/Exception; {:try_start_bind .. :try_end_bind} :catch_bind

    :catch_bind
    :try_start_1
    new-instance v1, Ljava/net/InetSocketAddress;

    iget-object v2, p0, Lro/outy/app/WifiLink;->host:Ljava/lang/String;

    iget v3, p0, Lro/outy/app/WifiLink;->port:I

    invoke-direct {v1, v2, v3}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V

    const/16 v2, 0x1388

    invoke-virtual {v0, v1, v2}, Ljava/net/Socket;->connect(Ljava/net/SocketAddress;I)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/net/Socket;->setTcpNoDelay(Z)V

    invoke-virtual {v0, v1}, Ljava/net/Socket;->setKeepAlive(Z)V

    invoke-virtual {v0}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v8

    invoke-virtual {v0}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v9

    iget-object v1, p0, Lro/outy/app/WifiLink;->act:Lro/outy/app/MainActivity;

    iget v2, p0, Lro/outy/app/WifiLink;->gen:I

    invoke-virtual {v1, v0, v9, v2}, Lro/outy/app/MainActivity;->wifiAttach(Ljava/net/Socket;Ljava/io/OutputStream;I)Z

    move-result v1

    if-nez v1, :cond_attached

    invoke-virtual {v0}, Ljava/net/Socket;->close()V

    return-void

    :cond_attached
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_fail

    const/16 v1, 0x400

    new-array v1, v1, [B

    :try_start_2
    :loop_read
    invoke-virtual {v8, v1}, Ljava/io/InputStream;->read([B)I

    move-result v2

    if-ltz v2, :done

    if-lez v2, :loop_read

    iget-object v3, p0, Lro/outy/app/WifiLink;->act:Lro/outy/app/MainActivity;

    invoke-virtual {v3, v0, v1, v2}, Lro/outy/app/MainActivity;->wifiData(Ljava/net/Socket;[BI)V

    goto :loop_read

    :done
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_end

    :catch_end
    iget-object v1, p0, Lro/outy/app/WifiLink;->act:Lro/outy/app/MainActivity;

    invoke-virtual {v1, v0}, Lro/outy/app/MainActivity;->wifiEnded(Ljava/net/Socket;)V

    return-void

    :catch_fail
    move-exception v1

    if-eqz v0, :cond_noclose

    :try_start_3
    invoke-virtual {v0}, Ljava/net/Socket;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_noclose

    :catch_noclose
    :cond_noclose
    iget-object v2, p0, Lro/outy/app/WifiLink;->act:Lro/outy/app/MainActivity;

    iget v3, p0, Lro/outy/app/WifiLink;->gen:I

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v3, v1}, Lro/outy/app/MainActivity;->wifiFail(ILjava/lang/String;)V

    return-void
.end method

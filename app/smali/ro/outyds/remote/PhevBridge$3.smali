.class Lro/outyds/remote/PhevBridge$3;
.super Ljava/lang/Object;
.source "PhevBridge.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lro/outyds/remote/PhevBridge;->connect(Ljava/lang/String;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lro/outyds/remote/PhevBridge;

.field final synthetic val$host:Ljava/lang/String;

.field final synthetic val$my:I

.field final synthetic val$port:I


# direct methods
.method constructor <init>(Lro/outyds/remote/PhevBridge;Ljava/lang/String;II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 221
    iput-object p1, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    iput-object p2, p0, Lro/outyds/remote/PhevBridge$3;->val$host:Ljava/lang/String;

    iput p3, p0, Lro/outyds/remote/PhevBridge$3;->val$port:I

    iput p4, p0, Lro/outyds/remote/PhevBridge$3;->val$my:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    .line 222
    const/4 v1, 0x0

    .line 224
    :try_start_0
    iget-object v0, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    invoke-static {v0}, Lro/outyds/remote/PhevBridge;->access$300(Lro/outyds/remote/PhevBridge;)Landroid/net/Network;

    move-result-object v0

    .line 225
    if-nez v0, :cond_1

    iget-object v0, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    const-string v2, "closed"

    const-string v3, "no Wi-Fi connection: join the car hotspot first"

    invoke-static {v0, v2, v3}, Lro/outyds/remote/PhevBridge;->access$200(Lro/outyds/remote/PhevBridge;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 245
    if-eqz v1, :cond_0

    :try_start_1
    invoke-virtual {v1}, Ljava/net/Socket;->close()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_4

    .line 247
    :cond_0
    :goto_0
    return-void

    .line 226
    :cond_1
    :try_start_2
    invoke-virtual {v0}, Landroid/net/Network;->getSocketFactory()Ljavax/net/SocketFactory;

    move-result-object v0

    invoke-virtual {v0}, Ljavax/net/SocketFactory;->createSocket()Ljava/net/Socket;

    move-result-object v1

    .line 227
    new-instance v0, Ljava/net/InetSocketAddress;

    iget-object v2, p0, Lro/outyds/remote/PhevBridge$3;->val$host:Ljava/lang/String;

    iget v3, p0, Lro/outyds/remote/PhevBridge$3;->val$port:I

    invoke-direct {v0, v2, v3}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V

    const/16 v2, 0x1770

    invoke-virtual {v1, v0, v2}, Ljava/net/Socket;->connect(Ljava/net/SocketAddress;I)V

    .line 228
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Ljava/net/Socket;->setTcpNoDelay(Z)V

    .line 229
    const/16 v0, 0x7530

    invoke-virtual {v1, v0}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 230
    iget v0, p0, Lro/outyds/remote/PhevBridge$3;->val$my:I

    iget-object v2, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    invoke-static {v2}, Lro/outyds/remote/PhevBridge;->access$400(Lro/outyds/remote/PhevBridge;)I

    move-result v2

    if-eq v0, v2, :cond_2

    invoke-virtual {v1}, Ljava/net/Socket;->close()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 245
    if-eqz v1, :cond_0

    :try_start_3
    invoke-virtual {v1}, Ljava/net/Socket;->close()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_0

    .line 231
    :cond_2
    :try_start_4
    iget-object v0, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    invoke-static {v0, v1}, Lro/outyds/remote/PhevBridge;->access$502(Lro/outyds/remote/PhevBridge;Ljava/net/Socket;)Ljava/net/Socket;

    .line 232
    iget-object v0, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "TCP connected to "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lro/outyds/remote/PhevBridge$3;->val$host:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ":"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lro/outyds/remote/PhevBridge$3;->val$port:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lro/outyds/remote/PhevBridge;->access$600(Lro/outyds/remote/PhevBridge;Ljava/lang/String;)V

    .line 233
    iget-object v0, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    invoke-virtual {v1}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    invoke-static {v0, v2}, Lro/outyds/remote/PhevBridge;->access$702(Lro/outyds/remote/PhevBridge;Ljava/io/OutputStream;)Ljava/io/OutputStream;

    .line 234
    iget-object v0, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    const-string v2, "open"

    const-string v3, ""

    invoke-static {v0, v2, v3}, Lro/outyds/remote/PhevBridge;->access$200(Lro/outyds/remote/PhevBridge;Ljava/lang/String;Ljava/lang/String;)V

    .line 235
    invoke-virtual {v1}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    .line 236
    const/16 v2, 0x1000

    new-array v2, v2, [B

    .line 238
    :cond_3
    :goto_1
    iget v3, p0, Lro/outyds/remote/PhevBridge$3;->val$my:I

    iget-object v4, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    invoke-static {v4}, Lro/outyds/remote/PhevBridge;->access$400(Lro/outyds/remote/PhevBridge;)I

    move-result v4

    if-ne v3, v4, :cond_5

    invoke-virtual {v0, v2}, Ljava/io/InputStream;->read([B)I

    move-result v3

    if-ltz v3, :cond_5

    .line 239
    if-lez v3, :cond_3

    iget-object v4, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    const-string v5, "RX"

    invoke-static {v4, v5, v2, v3}, Lro/outyds/remote/PhevBridge;->access$800(Lro/outyds/remote/PhevBridge;Ljava/lang/String;[BI)V

    iget-object v4, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "window.__phevRx&&window.__phevRx(\""

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {v2, v3}, Lro/outyds/remote/PhevBridge;->hex([BI)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, "\")"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v4, v3}, Lro/outyds/remote/PhevBridge;->js(Ljava/lang/String;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_1

    .line 242
    :catch_1
    move-exception v0

    .line 243
    :try_start_5
    iget v2, p0, Lro/outyds/remote/PhevBridge$3;->val$my:I

    iget-object v3, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    invoke-static {v3}, Lro/outyds/remote/PhevBridge;->access$400(Lro/outyds/remote/PhevBridge;)I

    move-result v3

    if-ne v2, v3, :cond_4

    iget-object v2, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    const-string v3, "closed"

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v3, v0}, Lro/outyds/remote/PhevBridge;->access$200(Lro/outyds/remote/PhevBridge;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 245
    :cond_4
    if-eqz v1, :cond_0

    :try_start_6
    invoke-virtual {v1}, Ljava/net/Socket;->close()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_2

    goto/16 :goto_0

    :catch_2
    move-exception v0

    goto/16 :goto_0

    .line 241
    :cond_5
    :try_start_7
    iget v0, p0, Lro/outyds/remote/PhevBridge$3;->val$my:I

    iget-object v2, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    invoke-static {v2}, Lro/outyds/remote/PhevBridge;->access$400(Lro/outyds/remote/PhevBridge;)I

    move-result v2

    if-ne v0, v2, :cond_6

    iget-object v0, p0, Lro/outyds/remote/PhevBridge$3;->this$0:Lro/outyds/remote/PhevBridge;

    const-string v2, "closed"

    const-string v3, "car closed the connection"

    invoke-static {v0, v2, v3}, Lro/outyds/remote/PhevBridge;->access$200(Lro/outyds/remote/PhevBridge;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_1
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 245
    :cond_6
    if-eqz v1, :cond_0

    :try_start_8
    invoke-virtual {v1}, Ljava/net/Socket;->close()V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_3

    goto/16 :goto_0

    :catch_3
    move-exception v0

    goto/16 :goto_0

    :catchall_0
    move-exception v0

    if-eqz v1, :cond_7

    :try_start_9
    invoke-virtual {v1}, Ljava/net/Socket;->close()V
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_5

    .line 246
    :cond_7
    :goto_2
    throw v0

    .line 245
    :catch_4
    move-exception v0

    goto/16 :goto_0

    :catch_5
    move-exception v1

    goto :goto_2
.end method

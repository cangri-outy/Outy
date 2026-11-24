.class Lro/outyds/remote/PhevBridge$4;
.super Ljava/lang/Object;
.source "PhevBridge.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lro/outyds/remote/PhevBridge;->send(Ljava/lang/String;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lro/outyds/remote/PhevBridge;

.field final synthetic val$b:[B

.field final synthetic val$o:Ljava/io/OutputStream;


# direct methods
.method constructor <init>(Lro/outyds/remote/PhevBridge;Ljava/io/OutputStream;[B)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 257
    iput-object p1, p0, Lro/outyds/remote/PhevBridge$4;->this$0:Lro/outyds/remote/PhevBridge;

    iput-object p2, p0, Lro/outyds/remote/PhevBridge$4;->val$o:Ljava/io/OutputStream;

    iput-object p3, p0, Lro/outyds/remote/PhevBridge$4;->val$b:[B

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    .line 258
    :try_start_0
    iget-object v1, p0, Lro/outyds/remote/PhevBridge$4;->this$0:Lro/outyds/remote/PhevBridge;

    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    iget-object v0, p0, Lro/outyds/remote/PhevBridge$4;->val$o:Ljava/io/OutputStream;

    iget-object v2, p0, Lro/outyds/remote/PhevBridge$4;->val$b:[B

    invoke-virtual {v0, v2}, Ljava/io/OutputStream;->write([B)V

    iget-object v0, p0, Lro/outyds/remote/PhevBridge$4;->val$o:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V

    monitor-exit v1

    .line 260
    :goto_0
    return-void

    .line 258
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    .line 259
    :catch_0
    move-exception v0

    iget-object v1, p0, Lro/outyds/remote/PhevBridge$4;->this$0:Lro/outyds/remote/PhevBridge;

    const-string v2, "closed"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "write failed: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v2, v0}, Lro/outyds/remote/PhevBridge;->access$200(Lro/outyds/remote/PhevBridge;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

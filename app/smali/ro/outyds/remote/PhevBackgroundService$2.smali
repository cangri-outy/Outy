.class Lro/outyds/remote/PhevBackgroundService$2;
.super Landroid/net/ConnectivityManager$NetworkCallback;
.source "PhevBackgroundService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lro/outyds/remote/PhevBackgroundService;->findOrJoinWifi(Ljava/lang/String;Ljava/lang/String;J)Landroid/net/Network;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lro/outyds/remote/PhevBackgroundService;

.field final synthetic val$lock:Ljava/lang/Object;

.field final synthetic val$result:[Landroid/net/Network;


# direct methods
.method constructor <init>(Lro/outyds/remote/PhevBackgroundService;Ljava/lang/Object;[Landroid/net/Network;)V
    .locals 0

    .prologue
    .line 181
    iput-object p1, p0, Lro/outyds/remote/PhevBackgroundService$2;->this$0:Lro/outyds/remote/PhevBackgroundService;

    iput-object p2, p0, Lro/outyds/remote/PhevBackgroundService$2;->val$lock:Ljava/lang/Object;

    iput-object p3, p0, Lro/outyds/remote/PhevBackgroundService$2;->val$result:[Landroid/net/Network;

    invoke-direct {p0}, Landroid/net/ConnectivityManager$NetworkCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onAvailable(Landroid/net/Network;)V
    .locals 3

    .prologue
    .line 182
    iget-object v1, p0, Lro/outyds/remote/PhevBackgroundService$2;->val$lock:Ljava/lang/Object;

    monitor-enter v1

    :try_start_0
    iget-object v0, p0, Lro/outyds/remote/PhevBackgroundService$2;->val$result:[Landroid/net/Network;

    const/4 v2, 0x0

    aput-object p1, v0, v2

    iget-object v0, p0, Lro/outyds/remote/PhevBackgroundService$2;->val$lock:Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public onUnavailable()V
    .locals 2

    .prologue
    .line 183
    iget-object v1, p0, Lro/outyds/remote/PhevBackgroundService$2;->val$lock:Ljava/lang/Object;

    monitor-enter v1

    :try_start_0
    iget-object v0, p0, Lro/outyds/remote/PhevBackgroundService$2;->val$lock:Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.class Lro/outyds/remote/PhevBridge$2;
.super Landroid/net/ConnectivityManager$NetworkCallback;
.source "PhevBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lro/outyds/remote/PhevBridge;->joinCar(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lro/outyds/remote/PhevBridge;

.field final synthetic val$ssid:Ljava/lang/String;


# direct methods
.method constructor <init>(Lro/outyds/remote/PhevBridge;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 129
    iput-object p1, p0, Lro/outyds/remote/PhevBridge$2;->this$0:Lro/outyds/remote/PhevBridge;

    iput-object p2, p0, Lro/outyds/remote/PhevBridge$2;->val$ssid:Ljava/lang/String;

    invoke-direct {p0}, Landroid/net/ConnectivityManager$NetworkCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onAvailable(Landroid/net/Network;)V
    .locals 3

    .prologue
    .line 130
    iget-object v0, p0, Lro/outyds/remote/PhevBridge$2;->this$0:Lro/outyds/remote/PhevBridge;

    invoke-static {v0, p1}, Lro/outyds/remote/PhevBridge;->access$102(Lro/outyds/remote/PhevBridge;Landroid/net/Network;)Landroid/net/Network;

    iget-object v0, p0, Lro/outyds/remote/PhevBridge$2;->this$0:Lro/outyds/remote/PhevBridge;

    const-string v1, "join"

    const-string v2, "ok"

    invoke-static {v0, v1, v2}, Lro/outyds/remote/PhevBridge;->access$200(Lro/outyds/remote/PhevBridge;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public onLost(Landroid/net/Network;)V
    .locals 3

    .prologue
    .line 132
    iget-object v0, p0, Lro/outyds/remote/PhevBridge$2;->this$0:Lro/outyds/remote/PhevBridge;

    invoke-static {v0}, Lro/outyds/remote/PhevBridge;->access$100(Lro/outyds/remote/PhevBridge;)Landroid/net/Network;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/net/Network;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lro/outyds/remote/PhevBridge$2;->this$0:Lro/outyds/remote/PhevBridge;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lro/outyds/remote/PhevBridge;->access$102(Lro/outyds/remote/PhevBridge;Landroid/net/Network;)Landroid/net/Network;

    :cond_0
    iget-object v0, p0, Lro/outyds/remote/PhevBridge$2;->this$0:Lro/outyds/remote/PhevBridge;

    const-string v1, "join"

    const-string v2, "lost"

    invoke-static {v0, v1, v2}, Lro/outyds/remote/PhevBridge;->access$200(Lro/outyds/remote/PhevBridge;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public onUnavailable()V
    .locals 4

    .prologue
    .line 131
    iget-object v0, p0, Lro/outyds/remote/PhevBridge$2;->this$0:Lro/outyds/remote/PhevBridge;

    const-string v1, "join"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Android could not join \""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lro/outyds/remote/PhevBridge$2;->val$ssid:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\": prompt dismissed, wrong password, or hotspot asleep. You can also join the car in Wi-Fi settings, then press Connect"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lro/outyds/remote/PhevBridge;->access$200(Lro/outyds/remote/PhevBridge;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

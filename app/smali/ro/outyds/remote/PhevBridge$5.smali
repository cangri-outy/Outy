.class Lro/outyds/remote/PhevBridge$5;
.super Ljava/lang/Object;
.source "PhevBridge.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lro/outyds/remote/PhevBridge;->askPerm(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lro/outyds/remote/PhevBridge;

.field final synthetic val$ps:[Ljava/lang/String;


# direct methods
.method constructor <init>(Lro/outyds/remote/PhevBridge;[Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 293
    iput-object p1, p0, Lro/outyds/remote/PhevBridge$5;->this$0:Lro/outyds/remote/PhevBridge;

    iput-object p2, p0, Lro/outyds/remote/PhevBridge$5;->val$ps:[Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 293
    iget-object v0, p0, Lro/outyds/remote/PhevBridge$5;->this$0:Lro/outyds/remote/PhevBridge;

    invoke-static {v0}, Lro/outyds/remote/PhevBridge;->access$900(Lro/outyds/remote/PhevBridge;)Landroid/app/Activity;

    move-result-object v0

    iget-object v1, p0, Lro/outyds/remote/PhevBridge$5;->val$ps:[Ljava/lang/String;

    const/16 v2, 0x1c85

    invoke-virtual {v0, v1, v2}, Landroid/app/Activity;->requestPermissions([Ljava/lang/String;I)V

    return-void
.end method

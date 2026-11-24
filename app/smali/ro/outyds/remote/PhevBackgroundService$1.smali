.class Lro/outyds/remote/PhevBackgroundService$1;
.super Ljava/lang/Object;
.source "PhevBackgroundService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lro/outyds/remote/PhevBackgroundService;->onStartCommand(Landroid/content/Intent;II)I
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lro/outyds/remote/PhevBackgroundService;

.field final synthetic val$label:Ljava/lang/String;

.field final synthetic val$minutes:I


# direct methods
.method constructor <init>(Lro/outyds/remote/PhevBackgroundService;ILjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 44
    iput-object p1, p0, Lro/outyds/remote/PhevBackgroundService$1;->this$0:Lro/outyds/remote/PhevBackgroundService;

    iput p2, p0, Lro/outyds/remote/PhevBackgroundService$1;->val$minutes:I

    iput-object p3, p0, Lro/outyds/remote/PhevBackgroundService$1;->val$label:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 44
    iget-object v0, p0, Lro/outyds/remote/PhevBackgroundService$1;->this$0:Lro/outyds/remote/PhevBackgroundService;

    iget v1, p0, Lro/outyds/remote/PhevBackgroundService$1;->val$minutes:I

    iget-object v2, p0, Lro/outyds/remote/PhevBackgroundService$1;->val$label:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lro/outyds/remote/PhevBackgroundService;->access$000(Lro/outyds/remote/PhevBackgroundService;ILjava/lang/String;)V

    return-void
.end method

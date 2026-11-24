.class Lro/outyds/remote/PhevBridge$1;
.super Ljava/lang/Object;
.source "PhevBridge.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lro/outyds/remote/PhevBridge;->js(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lro/outyds/remote/PhevBridge;

.field final synthetic val$code:Ljava/lang/String;


# direct methods
.method constructor <init>(Lro/outyds/remote/PhevBridge;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 77
    iput-object p1, p0, Lro/outyds/remote/PhevBridge$1;->this$0:Lro/outyds/remote/PhevBridge;

    iput-object p2, p0, Lro/outyds/remote/PhevBridge$1;->val$code:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 77
    :try_start_0
    iget-object v0, p0, Lro/outyds/remote/PhevBridge$1;->this$0:Lro/outyds/remote/PhevBridge;

    invoke-static {v0}, Lro/outyds/remote/PhevBridge;->access$000(Lro/outyds/remote/PhevBridge;)Landroid/webkit/WebView;

    move-result-object v0

    iget-object v1, p0, Lro/outyds/remote/PhevBridge$1;->val$code:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

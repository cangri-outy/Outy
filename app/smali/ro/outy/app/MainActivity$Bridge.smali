.class Lro/outy/app/MainActivity$Bridge;
.super Ljava/lang/Object;
.source "MainActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lro/outy/app/MainActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "Bridge"
.end annotation


# instance fields
.field final synthetic this$0:Lro/outy/app/MainActivity;


# direct methods
.method private constructor <init>(Lro/outy/app/MainActivity;)V
    .locals 0

    iput-object p1, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lro/outy/app/MainActivity;Lro/outy/app/MainActivity$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lro/outy/app/MainActivity$Bridge;-><init>(Lro/outy/app/MainActivity;)V

    return-void
.end method

.method static synthetic lambda$connect$1(Lro/outy/app/MainActivity;)V
    .locals 0

    invoke-static {p0}, Lro/outy/app/MainActivity;->access$900(Lro/outy/app/MainActivity;)V

    return-void
.end method

.method static synthetic lambda$pickDevice$0(Lro/outy/app/MainActivity;)V
    .locals 0

    invoke-static {p0}, Lro/outy/app/MainActivity;->access$1000(Lro/outy/app/MainActivity;)V

    return-void
.end method

.method private reportsDir()Ljava/io/File;
    .locals 3

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    const-string v1, "reports"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    if-nez v1, :cond_0

    new-instance v1, Ljava/io/File;

    invoke-virtual {v0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v2

    const-string v0, "reports"

    invoke-direct {v1, v2, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    :cond_0
    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    return-object v1
.end method


# virtual methods
.method public connect()V
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-static {v0}, Lro/outy/app/MainActivity;->access$100(Lro/outy/app/MainActivity;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    new-instance v2, Lro/outy/app/MainActivity$Bridge$$ExternalSyntheticLambda2;

    invoke-direct {v2, v1}, Lro/outy/app/MainActivity$Bridge$$ExternalSyntheticLambda2;-><init>(Lro/outy/app/MainActivity;)V

    invoke-virtual {v0, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public deviceInfo()Ljava/lang/String;
    .locals 2
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    sget-object v0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    const-string v1, "|"

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public disconnect()V
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-virtual {v0}, Lro/outy/app/MainActivity;->cancelConnect()V

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    const-string v1, "disconnected"

    const-string v2, ""

    invoke-static {v0, v1, v2}, Lro/outy/app/MainActivity;->access$300(Lro/outy/app/MainActivity;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public hasLocation()Z
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    sget-boolean v0, Lro/outy/app/MainActivity;->locOk:Z

    return v0
.end method

.method public isConnected()Z
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-virtual {v0}, Lro/outy/app/MainActivity;->isLinked()Z

    move-result v0

    return v0
.end method

.method public keepAlive(ZLjava/lang/String;)V
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    new-instance v1, Lro/outy/app/KeepAliveService$Req;

    invoke-direct {v1, v0, p1, p2}, Lro/outy/app/KeepAliveService$Req;-><init>(Landroid/app/Activity;ZLjava/lang/String;)V

    invoke-virtual {v0, v1}, Lro/outy/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method synthetic lambda$write$2$ro-outy-app-MainActivity$Bridge(Ljava/io/OutputStream;Ljava/lang/String;)V
    .locals 4

    move-object v3, p1

    :try_start_0
    sget-object v0, Ljava/nio/charset/StandardCharsets;->ISO_8859_1:Ljava/nio/charset/Charset;

    invoke-virtual {p2, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {p1}, Ljava/io/OutputStream;->flush()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    iget-object p2, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-virtual {p2, v3}, Lro/outy/app/MainActivity;->closeIf(Ljava/io/OutputStream;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object p2, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    const-string v2, "Eroare la trimitere: "

    const-string v3, "Send error: "

    invoke-static {v1, v2, v3}, Lro/outy/app/MainActivity;->access$800(Lro/outy/app/MainActivity;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "disconnected"

    invoke-static {p2, v0, p1}, Lro/outy/app/MainActivity;->access$300(Lro/outy/app/MainActivity;Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method public updStart(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-static {v0, p1, p2}, Lro/outy/app/Updater;->start(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public updStatus(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start_0
    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-static {v0, v1, v2}, Lro/outy/app/Updater;->status(Landroid/content/Context;J)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    const-string v0, "-1|0|0"

    return-object v0
.end method

.method public updInstall(Ljava/lang/String;)I
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start_0
    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-static {v0, v1, v2}, Lro/outy/app/Updater;->install(Landroid/content/Context;J)I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception v0

    const/4 v0, 0x0

    return v0
.end method

.method public wifiConnect(Ljava/lang/String;I)V
    .locals 2
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-virtual {v0, p1, p2}, Lro/outy/app/MainActivity;->wifiSave(Ljava/lang/String;I)V

    invoke-virtual {v0, p1, p2}, Lro/outy/app/MainActivity;->wifiStart(Ljava/lang/String;I)V

    return-void
.end method

.method public openUrl(Ljava/lang/String;)Z
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    const/high16 v2, 0x10000000

    invoke-virtual {v0, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object v0

    new-instance v2, Landroid/content/Intent;

    invoke-direct {v2, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v1, "android.intent.category.BROWSABLE"

    invoke-virtual {v2, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v2

    const-string v1, "http:"

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v2, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/content/Intent;->setSelector(Landroid/content/Intent;)V

    iget-object v1, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-virtual {v1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x1

    return v0

    :catch_0
    move-exception v0

    const/4 v0, 0x0

    return v0
.end method

.method public pickDevice()V
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-static {v0}, Lro/outy/app/MainActivity;->access$100(Lro/outy/app/MainActivity;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    new-instance v2, Lro/outy/app/MainActivity$Bridge$$ExternalSyntheticLambda0;

    invoke-direct {v2, v1}, Lro/outy/app/MainActivity$Bridge$$ExternalSyntheticLambda0;-><init>(Lro/outy/app/MainActivity;)V

    invoke-virtual {v0, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public reportsPath()Ljava/lang/String;
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start_0
    const-string v0, "Download"

    invoke-static {v0}, Landroid/os/Environment;->getExternalStoragePublicDirectory(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    return-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const-string v0, ""

    return-object v0
.end method

.method public saveReport(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-static {v1, v0, p2}, Lro/outy/app/MainActivity;->saveDownload(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public savedDevice()Ljava/lang/String;
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-virtual {v0}, Lro/outy/app/MainActivity;->wifiSaved()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_bt

    return-object v1

    :cond_bt
    const-string v1, "outy"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lro/outy/app/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "device_name"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public setLanguage(Ljava/lang/String;)V
    .locals 2
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    const-string v1, "en"

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    const-string v1, "ro"

    :goto_0
    invoke-static {v0, v1}, Lro/outy/app/MainActivity;->access$602(Lro/outy/app/MainActivity;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method public write(Ljava/lang/String;)Z
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-static {v0}, Lro/outy/app/MainActivity;->access$500(Lro/outy/app/MainActivity;)Ljava/io/OutputStream;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    iget-object v1, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    invoke-static {v1}, Lro/outy/app/MainActivity;->access$700(Lro/outy/app/MainActivity;)Ljava/util/concurrent/ExecutorService;

    move-result-object v1

    new-instance v2, Lro/outy/app/MainActivity$Bridge$$ExternalSyntheticLambda1;

    invoke-direct {v2, p0, v0, p1}, Lro/outy/app/MainActivity$Bridge$$ExternalSyntheticLambda1;-><init>(Lro/outy/app/MainActivity$Bridge;Ljava/io/OutputStream;Ljava/lang/String;)V

    :try_start_0
    invoke-interface {v1, v2}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/util/concurrent/RejectedExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    move-exception v1

    const/4 p1, 0x0

    return p1
.end method

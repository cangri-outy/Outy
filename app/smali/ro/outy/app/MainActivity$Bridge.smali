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

.field private volatile armUntil:J


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

.method public screenMode(I)V
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lro/outy/app/MainActivity$Bridge;->this$0:Lro/outy/app/MainActivity;

    new-instance v1, Lro/outy/app/ScreenMode;

    invoke-direct {v1, v0, p1}, Lro/outy/app/ScreenMode;-><init>(Landroid/app/Activity;I)V

    invoke-virtual {v0, v1}, Lro/outy/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
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

    if-eqz p1, :url_bad

    const-string v0, "https://"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :url_ok

    :url_bad
    const/4 v0, 0x0

    return v0

    :url_ok

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

.method public armClear()V
    .locals 4
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    const-wide/16 v2, 0x4e20

    add-long/2addr v0, v2

    iput-wide v0, p0, Lro/outy/app/MainActivity$Bridge;->armUntil:J

    return-void
.end method

.method private guard(Ljava/lang/String;)Z
    .locals 5

    const/4 v0, 0x0

    if-nez p1, :cond_g0

    return v0

    :cond_g0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_gbad

    const/16 v2, 0xc8

    if-gt v1, v2, :cond_gbad

    const-string v2, "\r"

    invoke-virtual {p1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    array-length v3, v2

    const/4 v1, 0x0

    :goto_g
    if-ge v1, v3, :cond_gok

    aget-object v4, v2, v1

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_gline

    const/4 v0, 0x0

    add-int/lit8 v1, v1, 0x1

    goto :goto_g

    :cond_gline
    const/4 v0, 0x0

    invoke-direct {p0, v4}, Lro/outy/app/MainActivity$Bridge;->guardLine(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_gbad

    add-int/lit8 v1, v1, 0x1

    goto :goto_g

    :cond_gok
    const/4 v0, 0x1

    :cond_gbad
    return v0
.end method

.method private guardLine(Ljava/lang/String;)Z
    .locals 9

    const/4 v0, 0x0

    if-nez p1, :cond_start

    return v0

    :cond_start
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_bad

    const/16 v2, 0x50

    if-gt v1, v2, :cond_bad

    sget-object v2, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {p1, v2}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p1

    const/4 v2, 0x0

    const/4 v8, 0x1

    :loop
    if-ge v2, v1, :loop_end

    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    add-int/lit8 v2, v2, 0x1

    const/16 v4, 0x20

    if-eq v3, v4, :loop

    const/16 v4, 0xd

    if-eq v3, v4, :loop

    const/16 v4, 0xa

    if-eq v3, v4, :loop

    const/16 v4, 0x30

    if-lt v3, v4, :cond_bad

    const/16 v4, 0x39

    if-le v3, v4, :loop

    const/16 v4, 0x40

    if-eq v3, v4, :nonhex

    const/16 v4, 0x41

    if-lt v3, v4, :cond_bad

    const/16 v4, 0x46

    if-le v3, v4, :loop

    const/16 v4, 0x5a

    if-gt v3, v4, :cond_bad

    :nonhex
    const/4 v8, 0x0

    goto :loop

    :loop_end
    const-string v2, " "

    const-string v3, ""

    invoke-virtual {p1, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-nez v3, :cond_nonempty

    const/4 v0, 0x1

    return v0

    :cond_nonempty
    if-eqz v8, :cond_at

    const/4 v4, 0x2

    if-lt v3, v4, :cond_ok

    const/4 v5, 0x0

    invoke-virtual {v2, v5, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    const-string v6, "14"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_clear

    const-string v6, "04"

    invoke-virtual {v2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_clear

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v7, ","

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    const-string v7, "10,11,27,28,2E,2F,31,34,35,36,37,3B,85,"

    invoke-virtual {v7, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_bad

    goto :cond_ok

    :cond_clear
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iget-wide v6, p0, Lro/outy/app/MainActivity$Bridge;->armUntil:J

    cmp-long v4, v4, v6

    if-gtz v4, :cond_bad

    goto :cond_ok

    :cond_at
    const-string v4, "ATPP"

    invoke-virtual {v2, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_bad

    const-string v4, "ATBR"

    invoke-virtual {v2, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_bad

    const-string v4, "ATM"

    invoke-virtual {v2, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_bad

    :cond_ok
    const/4 v0, 0x1

    :cond_bad
    return v0
.end method

.method public write(Ljava/lang/String;)Z
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    invoke-direct {p0, p1}, Lro/outy/app/MainActivity$Bridge;->guard(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_guard

    const/4 p1, 0x0

    return p1

    :cond_guard
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

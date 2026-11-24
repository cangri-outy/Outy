.class public Lro/outy/app/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lro/outy/app/MainActivity$Bridge;
    }
.end annotation


# static fields
.field private static final KEY_ADDR:Ljava/lang/String; = "device_address"

.field private static final KEY_NAME:Ljava/lang/String; = "device_name"

.field private static final PREFS:Ljava/lang/String; = "outy"

.field private static final REQ_ENABLE_BT:I = 0x2a

.field private static final REQ_PERMISSION:I = 0x29

.field private static final SPP_UUID:Ljava/util/UUID;

.field public static volatile locOk:Z


# instance fields
.field private volatile connecting:Z

.field private volatile gen:I

.field private final io:Ljava/util/concurrent/ExecutorService;

.field private lang:Ljava/lang/String;

.field private final lock:Ljava/lang/Object;

.field private volatile wsock:Ljava/net/Socket;

.field private final main:Landroid/os/Handler;

.field private volatile out:Ljava/io/OutputStream;

.field private pendingAfterEnable:Ljava/lang/Runnable;

.field private pendingAfterPermission:Ljava/lang/Runnable;

.field private volatile socket:Landroid/bluetooth/BluetoothSocket;

.field private volatile want:Z

.field private web:Landroid/webkit/WebView;

.field private phev:Lro/outyds/remote/PhevBridge;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "00001101-0000-1000-8000-00805F9B34FB"

    invoke-static {v0}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    sput-object v0, Lro/outy/app/MainActivity;->SPP_UUID:Ljava/util/UUID;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lro/outy/app/MainActivity;->main:Landroid/os/Handler;

    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lro/outy/app/MainActivity;->io:Ljava/util/concurrent/ExecutorService;

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lro/outy/app/MainActivity;->lock:Ljava/lang/Object;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lro/outy/app/MainActivity;->connecting:Z

    const-string v0, "ro"

    iput-object v0, p0, Lro/outy/app/MainActivity;->lang:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$100(Lro/outy/app/MainActivity;)Landroid/os/Handler;
    .locals 0

    iget-object p0, p0, Lro/outy/app/MainActivity;->main:Landroid/os/Handler;

    return-object p0
.end method

.method static synthetic access$1000(Lro/outy/app/MainActivity;)V
    .locals 0

    invoke-direct {p0}, Lro/outy/app/MainActivity;->showPicker()V

    return-void
.end method

.method static synthetic access$200(Lro/outy/app/MainActivity;)V
    .locals 0

    invoke-direct {p0}, Lro/outy/app/MainActivity;->closeSocket()V

    return-void
.end method

.method static synthetic access$300(Lro/outy/app/MainActivity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lro/outy/app/MainActivity;->status(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$400(Lro/outy/app/MainActivity;)Landroid/bluetooth/BluetoothSocket;
    .locals 0

    iget-object p0, p0, Lro/outy/app/MainActivity;->socket:Landroid/bluetooth/BluetoothSocket;

    return-object p0
.end method

.method static synthetic access$500(Lro/outy/app/MainActivity;)Ljava/io/OutputStream;
    .locals 0

    iget-object p0, p0, Lro/outy/app/MainActivity;->out:Ljava/io/OutputStream;

    return-object p0
.end method

.method static synthetic access$602(Lro/outy/app/MainActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lro/outy/app/MainActivity;->lang:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$700(Lro/outy/app/MainActivity;)Ljava/util/concurrent/ExecutorService;
    .locals 0

    iget-object p0, p0, Lro/outy/app/MainActivity;->io:Ljava/util/concurrent/ExecutorService;

    return-object p0
.end method

.method static synthetic access$800(Lro/outy/app/MainActivity;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    invoke-direct {p0, p1, p2}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$900(Lro/outy/app/MainActivity;)V
    .locals 0

    invoke-direct {p0}, Lro/outy/app/MainActivity;->connectSaved()V

    return-void
.end method

.method private adapter()Landroid/bluetooth/BluetoothAdapter;
    .locals 1

    const-string v0, "bluetooth"

    invoke-virtual {p0, v0}, Lro/outy/app/MainActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothManager;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothManager;->getAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method private askLocation()V
    .locals 3

    const-string v0, "android.permission.ACCESS_FINE_LOCATION"

    invoke-virtual {p0, v0}, Lro/outy/app/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    sput-boolean v1, Lro/outy/app/MainActivity;->locOk:Z

    return-void

    :cond_0
    filled-new-array {v0}, [Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x2b

    invoke-virtual {p0, v0, v1}, Lro/outy/app/MainActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void
.end method

.method static closeQuiet(Landroid/bluetooth/BluetoothSocket;)V
    .locals 0

    if-eqz p0, :cond_0

    :try_start_0
    invoke-virtual {p0}, Landroid/bluetooth/BluetoothSocket;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private closeSocket()V
    .locals 2

    iget-object v0, p0, Lro/outy/app/MainActivity;->wsock:Ljava/net/Socket;

    if-eqz v0, :nows

    :try_start_ws
    invoke-virtual {v0}, Ljava/net/Socket;->close()V
    :try_end_ws
    .catch Ljava/lang/Exception; {:try_start_ws .. :try_end_ws} :catch_ws

    :catch_ws
    const/4 v0, 0x0

    iput-object v0, p0, Lro/outy/app/MainActivity;->wsock:Ljava/net/Socket;

    :nows
    iget-object v0, p0, Lro/outy/app/MainActivity;->lock:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lro/outy/app/MainActivity;->socket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lro/outy/app/MainActivity;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothSocket;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    goto :goto_1

    :catch_0
    :cond_0
    :goto_0
    const/4 v1, 0x0

    :try_start_1
    iput-object v1, p0, Lro/outy/app/MainActivity;->socket:Landroid/bluetooth/BluetoothSocket;

    iput-object v1, p0, Lro/outy/app/MainActivity;->out:Ljava/io/OutputStream;

    monitor-exit v0

    return-void

    :goto_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method private connect(Landroid/bluetooth/BluetoothDevice;)V
    .locals 2

    iget-boolean v0, p0, Lro/outy/app/MainActivity;->connecting:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lro/outy/app/MainActivity;->want:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lro/outy/app/MainActivity;->wifiForget()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lro/outy/app/MainActivity;->want:Z

    iput-boolean v0, p0, Lro/outy/app/MainActivity;->connecting:Z

    iget v1, p0, Lro/outy/app/MainActivity;->gen:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lro/outy/app/MainActivity;->gen:I

    invoke-direct {p0}, Lro/outy/app/MainActivity;->closeSocket()V

    const-string v0, "connecting"

    invoke-direct {p0, p1}, Lro/outy/app/MainActivity;->safeName(Landroid/bluetooth/BluetoothDevice;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lro/outy/app/MainActivity;->status(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lro/outy/app/MainActivity;->io:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lro/outy/app/MainActivity$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0, p1}, Lro/outy/app/MainActivity$$ExternalSyntheticLambda3;-><init>(Lro/outy/app/MainActivity;Landroid/bluetooth/BluetoothDevice;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method private connectSaved()V
    .locals 4

    const-string v0, "outy"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lro/outy/app/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "wifi_host"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_nowifi

    const-string v2, "wifi_port"

    const/16 v3, 0x88b8

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v2

    invoke-virtual {p0, v1, v2}, Lro/outy/app/MainActivity;->wifiStart(Ljava/lang/String;I)V

    return-void

    :cond_nowifi

    const-string v1, "device_address"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-direct {p0}, Lro/outy/app/MainActivity;->showPicker()V

    return-void

    :cond_0
    new-instance v1, Lro/outy/app/MainActivity$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, v0}, Lro/outy/app/MainActivity$$ExternalSyntheticLambda0;-><init>(Lro/outy/app/MainActivity;Ljava/lang/String;)V

    invoke-direct {p0, v1}, Lro/outy/app/MainActivity;->withPermission(Ljava/lang/Runnable;)V

    return-void
.end method

.method private hasPermission()Z
    .locals 3

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1f

    const/4 v2, 0x1

    if-ge v0, v1, :cond_0

    return v2

    :cond_0
    const-string v0, "android.permission.BLUETOOTH_CONNECT"

    invoke-virtual {p0, v0}, Lro/outy/app/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    :goto_0
    return v2
.end method

.method private js(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lro/outy/app/MainActivity;->main:Landroid/os/Handler;

    new-instance v1, Lro/outy/app/MainActivity$$ExternalSyntheticLambda8;

    invoke-direct {v1, p0, p1, p2}, Lro/outy/app/MainActivity$$ExternalSyntheticLambda8;-><init>(Lro/outy/app/MainActivity;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private onLocationResult(Z)V
    .locals 2

    sput-boolean p1, Lro/outy/app/MainActivity;->locOk:Z

    if-eqz p1, :cond_0

    const-string v0, "granted"

    goto :goto_0

    :cond_0
    const-string v0, "denied"

    :goto_0
    const-string v1, "onLocation"

    invoke-direct {p0, v1, v0}, Lro/outy/app/MainActivity;->js(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private safeName(Landroid/bluetooth/BluetoothDevice;)Ljava/lang/String;
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const-string p1, "Dispozitiv f\u0103r\u0103 nume"

    const-string v0, "Unnamed device"

    invoke-direct {p0, p1, v0}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    return-object p1

    :catch_0
    const-string p1, "Dispozitiv"

    const-string v0, "Device"

    invoke-direct {p0, p1, v0}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public static saveDownload(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 9

    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_5

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/provider/MediaStore$Downloads;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    const/4 v5, 0x1

    new-array v2, v5, [Ljava/lang/String;

    const/4 v8, 0x0

    const-string v3, "_id"

    aput-object v3, v2, v8

    const-string v3, "_display_name=? AND relative_path=?"

    const/4 v5, 0x2

    new-array v4, v5, [Ljava/lang/String;

    aput-object p1, v4, v8

    const/4 v5, 0x1

    const-string v6, "Download/"

    aput-object v6, v4, v5

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    const/4 v7, 0x0

    if-eqz v6, :cond_1

    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v5

    if-eqz v5, :cond_0

    const/4 v5, 0x0

    invoke-interface {v6, v5}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v2

    invoke-static {v1, v2, v3}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;

    move-result-object v7

    :cond_0
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    :cond_1
    if-nez v7, :cond_3

    new-instance v2, Landroid/content/ContentValues;

    invoke-direct {v2}, Landroid/content/ContentValues;-><init>()V

    const-string v3, "_display_name"

    invoke-virtual {v2, v3, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "mime_type"

    const-string v4, "text/csv"

    const-string v5, ".json"

    invoke-virtual {p1, v5}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    const-string v4, "application/json"

    :cond_2
    invoke-virtual {v2, v3, v4}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "relative_path"

    const-string v4, "Download/"

    invoke-virtual {v2, v3, v4}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1, v2}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v7

    if-nez v7, :cond_3

    const/4 v0, 0x0

    return v0

    :cond_3
    const-string v2, "wt"

    invoke-virtual {v0, v7, v2}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;Ljava/lang/String;)Ljava/io/OutputStream;

    move-result-object v3

    if-nez v3, :cond_4

    const/4 v0, 0x0

    return v0

    :cond_4
    const-string v4, "UTF-8"

    invoke-virtual {p2, v4}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {v3}, Ljava/io/OutputStream;->close()V

    const/4 v0, 0x1

    return v0

    :cond_5
    const-string v0, "Download"

    invoke-static {v0}, Landroid/os/Environment;->getExternalStoragePublicDirectory(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    const-string v3, "UTF-8"

    invoke-virtual {p2, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V

    const/4 v0, 0x1

    return v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method private score(Landroid/bluetooth/BluetoothDevice;)I
    .locals 1

    invoke-direct {p0, p1}, Lro/outy/app/MainActivity;->safeName(Landroid/bluetooth/BluetoothDevice;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p1

    const-string v0, "vlink"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "v-link"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "vgate"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "icar"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    :cond_0
    const-string v0, "obd"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "elm"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-eqz p1, :cond_1

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    return p1

    :cond_2
    :goto_0
    const/4 p1, 0x2

    return p1

    :cond_3
    :goto_1
    const/4 p1, 0x3

    return p1
.end method

.method private showPicker()V
    .locals 1

    new-instance v0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda6;

    invoke-direct {v0, p0}, Lro/outy/app/MainActivity$$ExternalSyntheticLambda6;-><init>(Lro/outy/app/MainActivity;)V

    invoke-direct {p0, v0}, Lro/outy/app/MainActivity;->withPermission(Ljava/lang/Runnable;)V

    return-void
.end method

.method private startReader(Landroid/bluetooth/BluetoothSocket;Ljava/io/InputStream;)V
    .locals 2

    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lro/outy/app/MainActivity$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0, p2, p1}, Lro/outy/app/MainActivity$$ExternalSyntheticLambda2;-><init>(Lro/outy/app/MainActivity;Ljava/io/InputStream;Landroid/bluetooth/BluetoothSocket;)V

    const-string p1, "outy-reader"

    invoke-direct {v0, v1, p1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    const/4 p1, 0x1

    invoke-virtual {v0, p1}, Ljava/lang/Thread;->setDaemon(Z)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method private status(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "state"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string p1, "message"

    if-nez p2, :cond_0

    const-string p2, ""

    :cond_0
    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string p1, "onStatus"

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p0, p1, p2}, Lro/outy/app/MainActivity;->js(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    const-string v0, "en"

    iget-object v1, p0, Lro/outy/app/MainActivity;->lang:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    move-object p1, p2

    :cond_0
    return-object p1
.end method

.method private withBluetoothOn(Ljava/lang/Runnable;)V
    .locals 2

    invoke-direct {p0}, Lro/outy/app/MainActivity;->adapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    const-string v1, "error"

    if-nez v0, :cond_0

    const-string p1, "Telefonul nu are Bluetooth."

    const-string v0, "This phone has no Bluetooth."

    invoke-direct {p0, p1, v0}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, v1, p1}, Lro/outy/app/MainActivity;->status(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    return-void

    :cond_1
    iput-object p1, p0, Lro/outy/app/MainActivity;->pendingAfterEnable:Ljava/lang/Runnable;

    :try_start_0
    new-instance p1, Landroid/content/Intent;

    const-string v0, "android.bluetooth.adapter.action.REQUEST_ENABLE"

    invoke-direct {p1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const/16 v0, 0x2a

    invoke-virtual {p0, p1, v0}, Lro/outy/app/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const-string p1, "Porne\u0219te Bluetooth din set\u0103ri."

    const-string v0, "Turn Bluetooth on in settings."

    invoke-direct {p0, p1, v0}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, v1, p1}, Lro/outy/app/MainActivity;->status(Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method private withPermission(Ljava/lang/Runnable;)V
    .locals 1

    invoke-direct {p0}, Lro/outy/app/MainActivity;->hasPermission()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    return-void

    :cond_0
    iput-object p1, p0, Lro/outy/app/MainActivity;->pendingAfterPermission:Ljava/lang/Runnable;

    const-string p1, "android.permission.BLUETOOTH_CONNECT"

    filled-new-array {p1}, [Ljava/lang/String;

    move-result-object p1

    const/16 v0, 0x29

    invoke-virtual {p0, p1, v0}, Lro/outy/app/MainActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void
.end method


# virtual methods
# ---- WiFi (TCP / ELM327 WiFi dongle) transport ----
.method public wifiForget()V
    .locals 3

    const-string v0, "outy"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lro/outy/app/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "wifi_host"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method public wifiSave(Ljava/lang/String;I)V
    .locals 3

    const-string v0, "outy"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lro/outy/app/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "wifi_host"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "wifi_port"

    invoke-interface {v0, v1, p2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method public wifiSaved()Ljava/lang/String;
    .locals 4

    const-string v0, "outy"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lro/outy/app/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "wifi_host"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_has

    const-string v0, ""

    return-object v0

    :cond_has
    const-string v2, "wifi_port"

    const/16 v3, 0x88b8

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "WiFi "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ":"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public wifiStart(Ljava/lang/String;I)V
    .locals 5

    const/4 v0, 0x1

    iput-boolean v0, p0, Lro/outy/app/MainActivity;->want:Z

    iput-boolean v0, p0, Lro/outy/app/MainActivity;->connecting:Z

    iget v1, p0, Lro/outy/app/MainActivity;->gen:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lro/outy/app/MainActivity;->gen:I

    invoke-direct {p0}, Lro/outy/app/MainActivity;->closeSocket()V

    const-string v0, "connecting"

    const-string v2, "WiFi"

    invoke-direct {p0, v0, v2}, Lro/outy/app/MainActivity;->status(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lro/outy/app/MainActivity;->io:Ljava/util/concurrent/ExecutorService;

    new-instance v2, Lro/outy/app/WifiLink;

    invoke-direct {v2, p0, p1, p2, v1}, Lro/outy/app/WifiLink;-><init>(Lro/outy/app/MainActivity;Ljava/lang/String;II)V

    invoke-interface {v0, v2}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method public wifiAttach(Ljava/net/Socket;Ljava/io/OutputStream;I)Z
    .locals 3

    iget-object v0, p0, Lro/outy/app/MainActivity;->lock:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget v1, p0, Lro/outy/app/MainActivity;->gen:I

    if-eq v1, p3, :cond_ok

    monitor-exit v0

    const/4 v1, 0x0

    return v1

    :cond_ok
    iput-object p1, p0, Lro/outy/app/MainActivity;->wsock:Ljava/net/Socket;

    iput-object p2, p0, Lro/outy/app/MainActivity;->out:Ljava/io/OutputStream;

    const/4 v1, 0x0

    iput-boolean v1, p0, Lro/outy/app/MainActivity;->connecting:Z

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const-string v0, "connected"

    const-string v1, "WiFi"

    invoke-direct {p0, v0, v1}, Lro/outy/app/MainActivity;->status(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x1

    return v0

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public wifiData(Ljava/net/Socket;[BI)V
    .locals 5

    iget-object v0, p0, Lro/outy/app/MainActivity;->wsock:Ljava/net/Socket;

    if-eq v0, p1, :cond_ok

    return-void

    :cond_ok
    const-string v0, "onData"

    new-instance v1, Ljava/lang/String;

    const/4 v2, 0x0

    sget-object v3, Ljava/nio/charset/StandardCharsets;->ISO_8859_1:Ljava/nio/charset/Charset;

    invoke-direct {v1, p2, v2, p3, v3}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    invoke-direct {p0, v0, v1}, Lro/outy/app/MainActivity;->js(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public wifiEnded(Ljava/net/Socket;)V
    .locals 3

    iget-object v0, p0, Lro/outy/app/MainActivity;->wsock:Ljava/net/Socket;

    if-eq v0, p1, :cond_ok

    return-void

    :cond_ok
    invoke-direct {p0}, Lro/outy/app/MainActivity;->closeSocket()V

    const-string v0, "disconnected"

    const-string v1, "Conexiunea s-a \u00eenchis."

    const-string v2, "The connection was closed."

    invoke-direct {p0, v1, v2}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lro/outy/app/MainActivity;->status(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public wifiFail(ILjava/lang/String;)V
    .locals 3

    iget v0, p0, Lro/outy/app/MainActivity;->gen:I

    if-eq v0, p1, :cond_ok

    return-void

    :cond_ok
    const/4 v0, 0x0

    iput-boolean v0, p0, Lro/outy/app/MainActivity;->connecting:Z

    const-string v0, "disconnected"

    if-nez p2, :cond_msg

    const-string p2, "WiFi"

    :cond_msg
    invoke-direct {p0, v0, p2}, Lro/outy/app/MainActivity;->status(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public isLinked()Z
    .locals 2

    iget-object v0, p0, Lro/outy/app/MainActivity;->out:Ljava/io/OutputStream;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-object v0, p0, Lro/outy/app/MainActivity;->wsock:Ljava/net/Socket;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    return v0

    :cond_1
    iget-object v0, p0, Lro/outy/app/MainActivity;->socket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v0, :cond_2

    const/4 v0, 0x1

    return v0

    :cond_2
    const/4 v0, 0x0

    return v0
.end method

.method public cancelConnect()V
    .locals 2

    const/4 v0, 0x0

    iput-boolean v0, p0, Lro/outy/app/MainActivity;->want:Z

    iget v1, p0, Lro/outy/app/MainActivity;->gen:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lro/outy/app/MainActivity;->gen:I

    invoke-direct {p0}, Lro/outy/app/MainActivity;->closeSocket()V

    return-void
.end method

.method public closeIf(Ljava/io/OutputStream;)Z
    .locals 1

    iget-object v0, p0, Lro/outy/app/MainActivity;->out:Ljava/io/OutputStream;

    if-eq v0, p1, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    invoke-direct {p0}, Lro/outy/app/MainActivity;->closeSocket()V

    const/4 v0, 0x1

    return v0
.end method

.method synthetic lambda$connect$7$ro-outy-app-MainActivity(Landroid/bluetooth/BluetoothDevice;)V
    .locals 12

    iget v11, p0, Lro/outy/app/MainActivity;->gen:I

    invoke-direct {p0}, Lro/outy/app/MainActivity;->closeSocket()V

    :try_start_0
    invoke-direct {p0}, Lro/outy/app/MainActivity;->adapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->cancelDiscovery()Z
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    const/4 v0, 0x0

    const/4 v1, 0x0

    move v2, v0

    move-object v3, v1

    move-object v4, v3

    :goto_0
    const/4 v5, 0x6

    if-ge v2, v5, :cond_4

    if-nez v3, :cond_4

    iget-boolean v5, p0, Lro/outy/app/MainActivity;->want:Z

    if-eqz v5, :cond_4

    iget v5, p0, Lro/outy/app/MainActivity;->gen:I

    if-ne v5, v11, :cond_4

    rem-int/lit8 v10, v2, 0x3

    if-nez v10, :cond_1

    :try_start_1
    sget-object v5, Lro/outy/app/MainActivity;->SPP_UUID:Ljava/util/UUID;

    invoke-virtual {p1, v5}, Landroid/bluetooth/BluetoothDevice;->createRfcommSocketToServiceRecord(Ljava/util/UUID;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v5

    goto :goto_1

    :catch_1
    move-exception v4

    move-object v5, v1

    goto :goto_2

    :cond_1
    const/4 v5, 0x1

    if-ne v10, v5, :cond_2

    sget-object v5, Lro/outy/app/MainActivity;->SPP_UUID:Ljava/util/UUID;

    invoke-virtual {p1, v5}, Landroid/bluetooth/BluetoothDevice;->createInsecureRfcommSocketToServiceRecord(Ljava/util/UUID;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v5

    goto :goto_1

    :cond_2
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "createRfcommSocket"

    new-array v8, v5, [Ljava/lang/Class;

    sget-object v9, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v9, v8, v0

    invoke-virtual {v6, v7, v8}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v6

    new-array v7, v5, [Ljava/lang/Object;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v7, v0

    invoke-virtual {v6, p1, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/bluetooth/BluetoothSocket;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    :goto_1
    iput-object v5, p0, Lro/outy/app/MainActivity;->socket:Landroid/bluetooth/BluetoothSocket;

    :try_start_2
    invoke-virtual {v5}, Landroid/bluetooth/BluetoothSocket;->connect()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    move-object v3, v5

    goto :goto_3

    :catch_2
    move-exception v4

    :goto_2
    if-eqz v5, :cond_3

    :try_start_3
    invoke-virtual {v5}, Landroid/bluetooth/BluetoothSocket;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    iget-object v6, p0, Lro/outy/app/MainActivity;->socket:Landroid/bluetooth/BluetoothSocket;

    if-ne v6, v5, :cond_3

    const/4 v6, 0x0

    iput-object v6, p0, Lro/outy/app/MainActivity;->socket:Landroid/bluetooth/BluetoothSocket;

    :cond_3
    :try_start_4
    const-wide/16 v6, 0x1f4

    invoke-static {v6, v7}, Ljava/lang/Thread;->sleep(J)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_4

    :catch_4
    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_4
    iget v6, p0, Lro/outy/app/MainActivity;->gen:I

    if-eq v6, v11, :cond_5

    invoke-static {v3}, Lro/outy/app/MainActivity;->closeQuiet(Landroid/bluetooth/BluetoothSocket;)V

    return-void

    :cond_5
    iput-boolean v0, p0, Lro/outy/app/MainActivity;->connecting:Z

    iget-boolean v1, p0, Lro/outy/app/MainActivity;->want:Z

    if-nez v1, :cond_6

    invoke-static {v3}, Lro/outy/app/MainActivity;->closeQuiet(Landroid/bluetooth/BluetoothSocket;)V

    return-void

    :cond_6
    if-nez v3, :cond_8

    const-string p1, "error"

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Conectarea a e\u0219uat: "

    const-string v2, "Connection failed: "

    invoke-direct {p0, v1, v2}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    if-nez v4, :cond_7

    const-string v1, ""

    goto :goto_4

    :cond_7
    invoke-virtual {v4}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    :goto_4
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lro/outy/app/MainActivity;->status(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_8
    :try_start_5
    iget-object v0, p0, Lro/outy/app/MainActivity;->lock:Ljava/lang/Object;

    monitor-enter v0
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_5

    :try_start_6
    iput-object v3, p0, Lro/outy/app/MainActivity;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v3}, Landroid/bluetooth/BluetoothSocket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v1

    iput-object v1, p0, Lro/outy/app/MainActivity;->out:Ljava/io/OutputStream;

    monitor-exit v0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    :try_start_7
    invoke-virtual {v3}, Landroid/bluetooth/BluetoothSocket;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    invoke-direct {p0, v3, v0}, Lro/outy/app/MainActivity;->startReader(Landroid/bluetooth/BluetoothSocket;Ljava/io/InputStream;)V

    const-string v0, "connected"

    invoke-direct {p0, p1}, Lro/outy/app/MainActivity;->safeName(Landroid/bluetooth/BluetoothDevice;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, v0, p1}, Lro/outy/app/MainActivity;->status(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_5

    goto :goto_5

    :catchall_0
    move-exception p1

    :try_start_8
    monitor-exit v0
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    :try_start_9
    throw p1
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_5

    :catch_5
    move-exception p1

    invoke-direct {p0}, Lro/outy/app/MainActivity;->closeSocket()V

    const-string v0, "error"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Conectarea a e\u0219uat: "

    const-string v3, "Connection failed: "

    invoke-direct {p0, v2, v3}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, v0, p1}, Lro/outy/app/MainActivity;->status(Ljava/lang/String;Ljava/lang/String;)V

    :goto_5
    return-void
.end method

.method synthetic lambda$connectSaved$5$ro-outy-app-MainActivity(Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Lro/outy/app/MainActivity;->adapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    invoke-virtual {v0, p1}, Landroid/bluetooth/BluetoothAdapter;->getRemoteDevice(Ljava/lang/String;)Landroid/bluetooth/BluetoothDevice;

    move-result-object p1

    invoke-direct {p0, p1}, Lro/outy/app/MainActivity;->connect(Landroid/bluetooth/BluetoothDevice;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    invoke-direct {p0}, Lro/outy/app/MainActivity;->showPicker()V

    :goto_0
    return-void
.end method

.method synthetic lambda$connectSaved$6$ro-outy-app-MainActivity(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0, p1}, Lro/outy/app/MainActivity$$ExternalSyntheticLambda1;-><init>(Lro/outy/app/MainActivity;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lro/outy/app/MainActivity;->withBluetoothOn(Ljava/lang/Runnable;)V

    return-void
.end method

.method synthetic lambda$js$0$ro-outy-app-MainActivity(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    iget-object v0, p0, Lro/outy/app/MainActivity;->web:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "window.outyBridge&&window.outyBridge."

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "("

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {p2}, Lorg/json/JSONObject;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ")"

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    invoke-virtual {v0, p1, p2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    :cond_0
    return-void
.end method

.method synthetic lambda$showPicker$1$ro-outy-app-MainActivity(Landroid/bluetooth/BluetoothDevice;Landroid/bluetooth/BluetoothDevice;)I
    .locals 0

    invoke-direct {p0, p2}, Lro/outy/app/MainActivity;->score(Landroid/bluetooth/BluetoothDevice;)I

    move-result p2

    invoke-direct {p0, p1}, Lro/outy/app/MainActivity;->score(Landroid/bluetooth/BluetoothDevice;)I

    move-result p1

    invoke-static {p2, p1}, Ljava/lang/Integer;->compare(II)I

    move-result p1

    return p1
.end method

.method synthetic lambda$showPicker$2$ro-outy-app-MainActivity(Ljava/util/List;Landroid/content/DialogInterface;I)V
    .locals 1

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/bluetooth/BluetoothDevice;

    const-string p2, "outy"

    const/4 p3, 0x0

    invoke-virtual {p0, p2, p3}, Lro/outy/app/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p2

    invoke-interface {p2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p2

    const-string p3, "device_address"

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, p3, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p2

    const-string p3, "device_name"

    invoke-direct {p0, p1}, Lro/outy/app/MainActivity;->safeName(Landroid/bluetooth/BluetoothDevice;)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, p3, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p2

    invoke-interface {p2}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-direct {p0, p1}, Lro/outy/app/MainActivity;->connect(Landroid/bluetooth/BluetoothDevice;)V

    return-void
.end method

.method synthetic lambda$showPicker$3$ro-outy-app-MainActivity()V
    .locals 6

    invoke-direct {p0}, Lro/outy/app/MainActivity;->adapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->getBondedDevices()Ljava/util/Set;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-object v0, v1

    :goto_0
    if-eqz v0, :cond_3

    invoke-interface {v0}, Ljava/util/Set;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_1

    goto :goto_2

    :cond_1
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    new-instance v0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda4;

    invoke-direct {v0, p0}, Lro/outy/app/MainActivity$$ExternalSyntheticLambda4;-><init>(Lro/outy/app/MainActivity;)V

    invoke-interface {v2, v0}, Ljava/util/List;->sort(Ljava/util/Comparator;)V

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    const/4 v3, 0x0

    :goto_1
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v4

    if-ge v3, v4, :cond_2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/bluetooth/BluetoothDevice;

    invoke-direct {p0, v5}, Lro/outy/app/MainActivity;->safeName(Landroid/bluetooth/BluetoothDevice;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, "\n"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/bluetooth/BluetoothDevice;

    invoke-virtual {v5}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v0, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_2
    new-instance v3, Landroid/app/AlertDialog$Builder;

    invoke-direct {v3, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v4, "Alege adaptorul OBD"

    const-string v5, "Choose the OBD adapter"

    invoke-direct {p0, v4, v5}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    new-instance v4, Lro/outy/app/MainActivity$$ExternalSyntheticLambda5;

    invoke-direct {v4, p0, v2}, Lro/outy/app/MainActivity$$ExternalSyntheticLambda5;-><init>(Lro/outy/app/MainActivity;Ljava/util/List;)V

    invoke-virtual {v3, v0, v4}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v2, "Anuleaz\u0103"

    const-string v3, "Cancel"

    invoke-direct {p0, v2, v3}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    return-void

    :cond_3
    :goto_2
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v2, "Niciun adaptor asociat"

    const-string v3, "No paired adapter"

    invoke-direct {p0, v2, v3}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v2, "Asociaz\u0103 mai \u00eent\u00e2i adaptorul OBD \u00een Set\u0103ri > Bluetooth (PIN de obicei 1234 sau 0000), apoi revino."

    const-string v3, "Pair the OBD adapter first in Settings > Bluetooth (PIN is usually 1234 or 0000), then come back."

    invoke-direct {p0, v2, v3}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v2, "OK"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    return-void
.end method

.method synthetic lambda$showPicker$4$ro-outy-app-MainActivity()V
    .locals 1

    new-instance v0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda7;

    invoke-direct {v0, p0}, Lro/outy/app/MainActivity$$ExternalSyntheticLambda7;-><init>(Lro/outy/app/MainActivity;)V

    invoke-direct {p0, v0}, Lro/outy/app/MainActivity;->withBluetoothOn(Ljava/lang/Runnable;)V

    return-void
.end method

.method synthetic lambda$startReader$8$ro-outy-app-MainActivity(Ljava/io/InputStream;Landroid/bluetooth/BluetoothSocket;)V
    .locals 6

    const/16 v0, 0x400

    new-array v0, v0, [B

    :cond_0
    :goto_0
    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p1, v0}, Ljava/io/InputStream;->read([B)I

    move-result v2

    if-gez v2, :cond_1

    goto :goto_1

    :cond_1
    if-lez v2, :cond_0

    iget-object v3, p0, Lro/outy/app/MainActivity;->socket:Landroid/bluetooth/BluetoothSocket;

    if-ne v3, p2, :cond_2

    const-string v3, "onData"

    new-instance v4, Ljava/lang/String;

    sget-object v5, Ljava/nio/charset/StandardCharsets;->ISO_8859_1:Ljava/nio/charset/Charset;

    invoke-direct {v4, v0, v1, v2, v5}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    invoke-direct {p0, v3, v4}, Lro/outy/app/MainActivity;->js(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_2
    :goto_1
    iget-object p1, p0, Lro/outy/app/MainActivity;->lock:Ljava/lang/Object;

    monitor-enter p1

    :try_start_1
    iget-object v0, p0, Lro/outy/app/MainActivity;->socket:Landroid/bluetooth/BluetoothSocket;

    if-ne v0, p2, :cond_3

    const/4 v1, 0x1

    :cond_3
    monitor-exit p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz v1, :cond_4

    invoke-direct {p0}, Lro/outy/app/MainActivity;->closeSocket()V

    const-string p1, "disconnected"

    const-string p2, "Conexiunea s-a \u00eenchis."

    const-string v0, "The connection was closed."

    invoke-direct {p0, p2, v0}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-direct {p0, p1, p2}, Lro/outy/app/MainActivity;->status(Ljava/lang/String;Ljava/lang/String;)V

    :cond_4
    return-void

    :catchall_0
    move-exception p2

    :try_start_2
    monitor-exit p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p2
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    const/16 p3, 0x2a

    if-eq p1, p3, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lro/outy/app/MainActivity;->pendingAfterEnable:Ljava/lang/Runnable;

    const/4 p3, 0x0

    iput-object p3, p0, Lro/outy/app/MainActivity;->pendingAfterEnable:Ljava/lang/Runnable;

    const/4 p3, -0x1

    if-ne p2, p3, :cond_1

    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    goto :goto_0

    :cond_1
    const-string p1, "Bluetooth este oprit."

    const-string p2, "Bluetooth is off."

    invoke-direct {p0, p1, p2}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "error"

    invoke-direct {p0, p2, p1}, Lro/outy/app/MainActivity;->status(Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lro/outy/app/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    const/16 v0, 0x80

    invoke-virtual {p1, v0}, Landroid/view/Window;->addFlags(I)V

    invoke-virtual {p0}, Lro/outy/app/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    const v0, -0xf4e9da

    invoke-virtual {p1, v0}, Landroid/view/Window;->setStatusBarColor(I)V

    invoke-virtual {p0}, Lro/outy/app/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/view/Window;->setNavigationBarColor(I)V

    new-instance p1, Landroid/webkit/WebView;

    invoke-direct {p1, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lro/outy/app/MainActivity;->web:Landroid/webkit/WebView;

    invoke-virtual {p1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object p1

    const/16 v1, 0x64

    invoke-virtual {p1, v1}, Landroid/webkit/WebSettings;->setTextZoom(I)V

    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    invoke-virtual {p1, v1}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V

    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Landroid/webkit/WebSettings;->setGeolocationEnabled(Z)V

    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V

    iget-object p1, p0, Lro/outy/app/MainActivity;->web:Landroid/webkit/WebView;

    invoke-virtual {p1, v0}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    iget-object p1, p0, Lro/outy/app/MainActivity;->web:Landroid/webkit/WebView;

    new-instance v0, Lro/outy/app/OutyClient;

    invoke-direct {v0}, Lro/outy/app/OutyClient;-><init>()V

    invoke-virtual {p1, v0}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    iget-object p1, p0, Lro/outy/app/MainActivity;->web:Landroid/webkit/WebView;

    new-instance v0, Lro/outy/app/OutyChrome;

    invoke-direct {v0}, Lro/outy/app/OutyChrome;-><init>()V

    invoke-virtual {p1, v0}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    iget-object p1, p0, Lro/outy/app/MainActivity;->web:Landroid/webkit/WebView;

    new-instance v0, Lro/outy/app/MainActivity$Bridge;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lro/outy/app/MainActivity$Bridge;-><init>(Lro/outy/app/MainActivity;Lro/outy/app/MainActivity$1;)V

    const-string v1, "OutyNative"

    invoke-virtual {p1, v0, v1}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object p1, p0, Lro/outy/app/MainActivity;->web:Landroid/webkit/WebView;

    new-instance v0, Lro/outyds/remote/PhevBridge;

    invoke-direct {v0, p0, p1}, Lro/outyds/remote/PhevBridge;-><init>(Landroid/app/Activity;Landroid/webkit/WebView;)V

    iput-object v0, p0, Lro/outy/app/MainActivity;->phev:Lro/outyds/remote/PhevBridge;

    const-string v1, "PhevNative"

    invoke-virtual {p1, v0, v1}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object p1, p0, Lro/outy/app/MainActivity;->web:Landroid/webkit/WebView;

    invoke-virtual {p0, p1}, Lro/outy/app/MainActivity;->setContentView(Landroid/view/View;)V

    iget-object p1, p0, Lro/outy/app/MainActivity;->web:Landroid/webkit/WebView;

    const-string v0, "file:///android_asset/index.html"

    invoke-virtual {p1, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    invoke-direct {p0}, Lro/outy/app/MainActivity;->askLocation()V

    return-void
.end method

.method protected onDestroy()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lro/outy/app/MainActivity;->want:Z

    invoke-direct {p0}, Lro/outy/app/MainActivity;->closeSocket()V

    iget-object v0, p0, Lro/outy/app/MainActivity;->io:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;

    iget-object v0, p0, Lro/outy/app/MainActivity;->phev:Lro/outyds/remote/PhevBridge;

    if-eqz v0, :cond_phev

    invoke-virtual {v0}, Lro/outyds/remote/PhevBridge;->close()V

    :cond_phev
    iget-object v0, p0, Lro/outy/app/MainActivity;->web:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V

    :cond_0
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 0

    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    const/16 p2, 0x2b

    if-ne p1, p2, :cond_1

    array-length p1, p3

    const/4 p2, 0x0

    if-lez p1, :cond_0

    aget p1, p3, p2

    if-nez p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    invoke-direct {p0, p1}, Lro/outy/app/MainActivity;->onLocationResult(Z)V

    return-void

    :cond_1
    const/16 p2, 0x29

    if-eq p1, p2, :cond_2

    return-void

    :cond_2
    iget-object p1, p0, Lro/outy/app/MainActivity;->pendingAfterPermission:Ljava/lang/Runnable;

    const/4 p2, 0x0

    iput-object p2, p0, Lro/outy/app/MainActivity;->pendingAfterPermission:Ljava/lang/Runnable;

    array-length p2, p3

    if-lez p2, :cond_3

    const/4 p2, 0x0

    aget p2, p3, p2

    if-nez p2, :cond_3

    if-eqz p1, :cond_4

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    goto :goto_1

    :cond_3
    const-string p1, "F\u0103r\u0103 permisiunea Bluetooth aplica\u021bia nu se poate conecta."

    const-string p2, "Without the Bluetooth permission the app cannot connect."

    invoke-direct {p0, p1, p2}, Lro/outy/app/MainActivity;->tr(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "error"

    invoke-direct {p0, p2, p1}, Lro/outy/app/MainActivity;->status(Ljava/lang/String;Ljava/lang/String;)V

    :cond_4
    :goto_1
    return-void
.end method

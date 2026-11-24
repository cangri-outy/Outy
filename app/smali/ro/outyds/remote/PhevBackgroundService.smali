.class public Lro/outyds/remote/PhevBackgroundService;
.super Landroid/app/Service;
.source "PhevBackgroundService.java"


# static fields
.field private static final CHANNEL:Ljava/lang/String; = "phev_bg"

.field private static final NOTIF_ID:I = 0x1c8e


# instance fields
.field private volatile stopped:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 32
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 35
    const/4 v0, 0x0

    iput-boolean v0, p0, Lro/outyds/remote/PhevBackgroundService;->stopped:Z

    return-void
.end method

.method static synthetic access$000(Lro/outyds/remote/PhevBackgroundService;ILjava/lang/String;)V
    .locals 0

    .prologue
    .line 32
    invoke-direct {p0, p1, p2}, Lro/outyds/remote/PhevBackgroundService;->runJob(ILjava/lang/String;)V

    return-void
.end method

.method private attemptOnce(I)Z
    .locals 18
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 81
    invoke-virtual/range {p0 .. p0}, Lro/outyds/remote/PhevBackgroundService;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "phev"

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 82
    const-string v3, "ssid"

    const-string v4, ""

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 83
    const-string v3, "psk"

    const-string v5, ""

    invoke-interface {v2, v3, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 84
    const-string v3, "host"

    const-string v6, "192.168.8.46"

    invoke-interface {v2, v3, v6}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 85
    const-string v3, "port"

    const/16 v7, 0x1f90

    invoke-interface {v2, v3, v7}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v7

    .line 86
    const-string v3, "mode"

    const-string v8, "heat"

    invoke-interface {v2, v3, v8}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 87
    const-string v3, "cool"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v2, 0x1

    move v10, v2

    .line 88
    :goto_0
    const/16 v2, 0x1e

    move/from16 v0, p1

    if-lt v0, v2, :cond_2

    const/4 v2, 0x2

    .line 90
    :goto_1
    invoke-direct/range {p0 .. p0}, Lro/outyds/remote/PhevBackgroundService;->ro()Z

    move-result v3

    if-eqz v3, :cond_4

    const-string v3, "M\u0103 conectez la Wi-Fi\u2026"

    :goto_2
    const/4 v8, 0x0

    move-object/from16 v0, p0

    invoke-direct {v0, v3, v8}, Lro/outyds/remote/PhevBackgroundService;->updateNotification(Ljava/lang/String;Z)V

    .line 91
    const-wide/16 v8, 0x61a8

    move-object/from16 v0, p0

    invoke-direct {v0, v4, v5, v8, v9}, Lro/outyds/remote/PhevBackgroundService;->findOrJoinWifi(Ljava/lang/String;Ljava/lang/String;J)Landroid/net/Network;

    move-result-object v4

    .line 92
    if-nez v4, :cond_5

    const/4 v2, 0x0

    .line 138
    :goto_3
    return v2

    .line 87
    :cond_0
    const-string v3, "windscreen"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    const/4 v2, 0x3

    move v10, v2

    goto :goto_0

    :cond_1
    const/4 v2, 0x2

    move v10, v2

    goto :goto_0

    .line 88
    :cond_2
    const/16 v2, 0x14

    move/from16 v0, p1

    if-lt v0, v2, :cond_3

    const/4 v2, 0x1

    goto :goto_1

    :cond_3
    const/4 v2, 0x0

    goto :goto_1

    .line 90
    :cond_4
    const-string v3, "Connecting to Wi-Fi\u2026"

    goto :goto_2

    .line 94
    :cond_5
    invoke-direct/range {p0 .. p0}, Lro/outyds/remote/PhevBackgroundService;->ro()Z

    move-result v3

    if-eqz v3, :cond_8

    const-string v3, "Conectat, a\u0219tept ma\u0219ina\u2026"

    :goto_4
    const/4 v5, 0x0

    move-object/from16 v0, p0

    invoke-direct {v0, v3, v5}, Lro/outyds/remote/PhevBackgroundService;->updateNotification(Ljava/lang/String;Z)V

    .line 95
    invoke-virtual {v4}, Landroid/net/Network;->getSocketFactory()Ljavax/net/SocketFactory;

    move-result-object v3

    invoke-virtual {v3}, Ljavax/net/SocketFactory;->createSocket()Ljava/net/Socket;

    move-result-object v11

    .line 97
    :try_start_0
    new-instance v3, Ljava/net/InetSocketAddress;

    invoke-direct {v3, v6, v7}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V

    const/16 v4, 0x1f40

    invoke-virtual {v11, v3, v4}, Ljava/net/Socket;->connect(Ljava/net/SocketAddress;I)V

    .line 98
    const/16 v3, 0x2ee0

    invoke-virtual {v11, v3}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 99
    invoke-virtual {v11}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v4

    .line 100
    invoke-virtual {v11}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v12

    .line 103
    new-instance v6, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;

    invoke-direct {v6}, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;-><init>()V

    .line 104
    const/4 v3, 0x0

    .line 105
    const/16 v5, 0x200

    new-array v5, v5, [B

    .line 106
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    const-wide/16 v14, 0x2710

    add-long/2addr v8, v14

    .line 107
    :cond_6
    :goto_5
    if-nez v3, :cond_d

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v14

    cmp-long v7, v14, v8

    if-gez v7, :cond_d

    .line 108
    invoke-virtual {v4, v5}, Ljava/io/InputStream;->read([B)I

    move-result v7

    .line 109
    if-lez v7, :cond_6

    .line 110
    invoke-static {v5, v7}, Lro/outyds/remote/PhevBackgroundService;->toIntArray([BI)[I

    move-result-object v7

    .line 111
    invoke-static {v7}, Lro/outyds/remote/PhevMiniProtocol;->tryDecodeOne([I)Lro/outyds/remote/PhevMiniProtocol$Frame;

    move-result-object v13

    .line 112
    if-eqz v13, :cond_6

    .line 113
    iget v14, v13, Lro/outyds/remote/PhevMiniProtocol$Frame;->type:I

    const/16 v15, 0x4e

    if-eq v14, v15, :cond_7

    iget v14, v13, Lro/outyds/remote/PhevMiniProtocol$Frame;->type:I

    const/16 v15, 0x5e

    if-eq v14, v15, :cond_7

    iget v14, v13, Lro/outyds/remote/PhevMiniProtocol$Frame;->type:I

    const/16 v15, 0x6e

    if-ne v14, v15, :cond_6

    .line 114
    :cond_7
    iget v3, v13, Lro/outyds/remote/PhevMiniProtocol$Frame;->ack:I

    invoke-virtual {v6, v7, v3}, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->update([II)V

    .line 115
    iget v3, v13, Lro/outyds/remote/PhevMiniProtocol$Frame;->type:I

    const/16 v7, 0x6e

    if-ne v3, v7, :cond_9

    const/16 v3, 0x18

    .line 116
    :goto_6
    iget v7, v13, Lro/outyds/remote/PhevMiniProtocol$Frame;->type:I

    const/16 v14, 0x4e

    if-ne v7, v14, :cond_b

    const/16 v7, 0xe4

    .line 118
    :goto_7
    const/4 v13, 0x1

    const/4 v14, 0x1

    const/4 v15, 0x1

    new-array v15, v15, [I

    const/16 v16, 0x0

    const/16 v17, 0x0

    aput v17, v15, v16

    invoke-static {v7, v13, v14, v15, v6}, Lro/outyds/remote/PhevMiniProtocol;->encode(III[ILro/outyds/remote/PhevMiniProtocol$SecurityKey;)[I

    move-result-object v7

    .line 119
    invoke-static {v7}, Lro/outyds/remote/PhevBackgroundService;->toByteArray([I)[B

    move-result-object v7

    invoke-virtual {v12, v7}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {v12}, Ljava/io/OutputStream;->flush()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_5

    .line 140
    :catchall_0
    move-exception v2

    :try_start_1
    invoke-virtual {v11}, Ljava/net/Socket;->close()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_3

    .line 141
    :goto_8
    throw v2

    .line 94
    :cond_8
    const-string v3, "Connected, talking to the car\u2026"

    goto/16 :goto_4

    .line 115
    :cond_9
    :try_start_2
    iget v3, v13, Lro/outyds/remote/PhevMiniProtocol$Frame;->type:I

    const/16 v7, 0x5e

    if-ne v3, v7, :cond_a

    const/16 v3, 0x12

    goto :goto_6

    :cond_a
    const/16 v3, 0xe

    goto :goto_6

    .line 117
    :cond_b
    iget v7, v13, Lro/outyds/remote/PhevMiniProtocol$Frame;->type:I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    const/16 v13, 0x5e

    if-ne v7, v13, :cond_c

    const/16 v7, 0xe5

    goto :goto_7

    :cond_c
    const/16 v7, 0xe6

    goto :goto_7

    .line 122
    :cond_d
    if-nez v3, :cond_e

    const/4 v2, 0x0

    .line 140
    :try_start_3
    invoke-virtual {v11}, Ljava/net/Socket;->close()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto/16 :goto_3

    :catch_0
    move-exception v3

    goto/16 :goto_3

    .line 124
    :cond_e
    :try_start_4
    invoke-direct/range {p0 .. p0}, Lro/outyds/remote/PhevBackgroundService;->ro()Z

    move-result v7

    if-eqz v7, :cond_f

    const-string v7, "Trimit comanda de climatizare\u2026"

    :goto_9
    const/4 v8, 0x0

    move-object/from16 v0, p0

    invoke-direct {v0, v7, v8}, Lro/outyds/remote/PhevBackgroundService;->updateNotification(Ljava/lang/String;Z)V

    .line 126
    const/16 v7, 0xe

    if-ne v3, v7, :cond_11

    .line 127
    const/16 v3, 0xf6

    const/4 v7, 0x0

    const/4 v8, 0x2

    invoke-static {v10, v2}, Lro/outyds/remote/PhevMiniProtocol;->climateMy14Step1(II)[I

    move-result-object v2

    invoke-static {v3, v7, v8, v2, v6}, Lro/outyds/remote/PhevMiniProtocol;->encode(III[ILro/outyds/remote/PhevMiniProtocol$SecurityKey;)[I

    move-result-object v2

    .line 128
    invoke-static {v2}, Lro/outyds/remote/PhevBackgroundService;->toByteArray([I)[B

    move-result-object v2

    invoke-virtual {v12, v2}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {v12}, Ljava/io/OutputStream;->flush()V

    .line 129
    const/4 v7, 0x2

    const-wide/16 v8, 0x1f40

    move-object/from16 v3, p0

    invoke-direct/range {v3 .. v9}, Lro/outyds/remote/PhevBackgroundService;->waitAck(Ljava/io/InputStream;[BLro/outyds/remote/PhevMiniProtocol$SecurityKey;IJ)Z
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move-result v2

    if-nez v2, :cond_10

    const/4 v2, 0x0

    .line 140
    :try_start_5
    invoke-virtual {v11}, Ljava/net/Socket;->close()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_1

    goto/16 :goto_3

    :catch_1
    move-exception v3

    goto/16 :goto_3

    .line 124
    :cond_f
    :try_start_6
    const-string v7, "Sending the climate command\u2026"

    goto :goto_9

    .line 130
    :cond_10
    const/16 v2, 0xf6

    const/4 v3, 0x0

    const/4 v7, 0x4

    invoke-static {v10}, Lro/outyds/remote/PhevMiniProtocol;->climateMy14Step2(I)[I

    move-result-object v8

    invoke-static {v2, v3, v7, v8, v6}, Lro/outyds/remote/PhevMiniProtocol;->encode(III[ILro/outyds/remote/PhevMiniProtocol$SecurityKey;)[I

    move-result-object v2

    .line 131
    invoke-static {v2}, Lro/outyds/remote/PhevBackgroundService;->toByteArray([I)[B

    move-result-object v2

    invoke-virtual {v12, v2}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {v12}, Ljava/io/OutputStream;->flush()V

    .line 132
    const/4 v7, 0x4

    const-wide/16 v8, 0x1f40

    move-object/from16 v3, p0

    invoke-direct/range {v3 .. v9}, Lro/outyds/remote/PhevBackgroundService;->waitAck(Ljava/io/InputStream;[BLro/outyds/remote/PhevMiniProtocol$SecurityKey;IJ)Z
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    move-result v2

    .line 140
    :goto_a
    :try_start_7
    invoke-virtual {v11}, Ljava/net/Socket;->close()V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_2

    goto/16 :goto_3

    :catch_2
    move-exception v3

    goto/16 :goto_3

    .line 134
    :cond_11
    const/16 v3, 0xf6

    const/4 v7, 0x0

    const/16 v8, 0x1b

    :try_start_8
    invoke-static {v10, v2}, Lro/outyds/remote/PhevMiniProtocol;->climateMy18(II)[I

    move-result-object v2

    invoke-static {v3, v7, v8, v2, v6}, Lro/outyds/remote/PhevMiniProtocol;->encode(III[ILro/outyds/remote/PhevMiniProtocol$SecurityKey;)[I

    move-result-object v2

    .line 135
    invoke-static {v2}, Lro/outyds/remote/PhevBackgroundService;->toByteArray([I)[B

    move-result-object v2

    invoke-virtual {v12, v2}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {v12}, Ljava/io/OutputStream;->flush()V

    .line 136
    const/16 v7, 0x1b

    const-wide/16 v8, 0x1f40

    move-object/from16 v3, p0

    invoke-direct/range {v3 .. v9}, Lro/outyds/remote/PhevBackgroundService;->waitAck(Ljava/io/InputStream;[BLro/outyds/remote/PhevMiniProtocol$SecurityKey;IJ)Z
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    move-result v2

    goto :goto_a

    .line 140
    :catch_3
    move-exception v3

    goto/16 :goto_8
.end method

.method private buildNotification(Ljava/lang/String;Z)Landroid/app/Notification;
    .locals 10

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 192
    new-instance v3, Landroid/app/Notification$Builder;

    invoke-direct {v3, p0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V

    .line 193
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1a

    if-lt v0, v4, :cond_0

    .line 195
    :try_start_0
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Lro/outyds/remote/PhevBackgroundService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    .line 196
    const-string v4, "android.app.NotificationChannel"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    .line 197
    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Ljava/lang/String;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-class v7, Ljava/lang/CharSequence;

    aput-object v7, v5, v6

    const/4 v6, 0x2

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v4, v5}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v5

    const/4 v6, 0x3

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    const-string v8, "phev_bg"

    aput-object v8, v6, v7

    const/4 v7, 0x1

    const-string v8, "Scheduled preheat"

    aput-object v8, v6, v7

    const/4 v7, 0x2

    const/4 v8, 0x2

    .line 198
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    .line 199
    const-class v6, Landroid/app/NotificationManager;

    const-string v7, "createNotificationChannel"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Class;

    const/4 v9, 0x0

    aput-object v4, v8, v9

    invoke-virtual {v6, v7, v8}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object v5, v6, v7

    invoke-virtual {v4, v0, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 200
    const-class v0, Landroid/app/Notification$Builder;

    const-string v4, "setChannelId"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Ljava/lang/String;

    aput-object v7, v5, v6

    invoke-virtual {v0, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "phev_bg"

    aput-object v6, v4, v5

    invoke-virtual {v0, v3, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 203
    :cond_0
    :goto_0
    invoke-virtual {p0}, Lro/outyds/remote/PhevBackgroundService;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Lro/outyds/remote/PhevBackgroundService;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 204
    const/16 v4, 0x1c8f

    const/high16 v5, 0xc000000

    invoke-static {p0, v4, v0, v5}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    .line 205
    invoke-virtual {p0}, Lro/outyds/remote/PhevBackgroundService;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v4

    iget v4, v4, Landroid/content/pm/ApplicationInfo;->icon:I

    invoke-virtual {v3, v4}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v4

    const-string v5, "OutyDS"

    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v4

    invoke-virtual {v4, p1}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v4

    .line 206
    invoke-virtual {v4, v0}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v4

    if-nez p2, :cond_1

    move v0, v1

    :goto_1
    invoke-virtual {v4, v0}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0, p2}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    .line 207
    invoke-virtual {v3}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    return-object v0

    :cond_1
    move v0, v2

    .line 206
    goto :goto_1

    .line 201
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private findOrJoinWifi(Ljava/lang/String;Ljava/lang/String;J)Landroid/net/Network;
    .locals 11

    .prologue
    .line 161
    const-string v0, "connectivity"

    invoke-virtual {p0, v0}, Lro/outyds/remote/PhevBackgroundService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 162
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getAllNetworks()[Landroid/net/Network;

    move-result-object v3

    array-length v4, v3

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v2, v4, :cond_1

    aget-object v1, v3, v2

    .line 163
    invoke-virtual {v0, v1}, Landroid/net/ConnectivityManager;->getNetworkCapabilities(Landroid/net/Network;)Landroid/net/NetworkCapabilities;

    move-result-object v5

    .line 164
    if-eqz v5, :cond_0

    const/4 v6, 0x1

    invoke-virtual {v5, v6}, Landroid/net/NetworkCapabilities;->hasTransport(I)Z

    move-result v5

    if-eqz v5, :cond_0

    move-object v0, v1

    .line 188
    :goto_1
    return-object v0

    .line 162
    :cond_0
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_0

    .line 166
    :cond_1
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_2

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1d

    if-ge v1, v2, :cond_3

    :cond_2
    const/4 v0, 0x0

    goto :goto_1

    .line 167
    :cond_3
    const/4 v1, 0x1

    new-array v2, v1, [Landroid/net/Network;

    .line 168
    new-instance v3, Ljava/lang/Object;

    invoke-direct {v3}, Ljava/lang/Object;-><init>()V

    .line 170
    :try_start_0
    const-string v1, "android.net.wifi.WifiNetworkSpecifier$Builder"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 171
    invoke-virtual {v1}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v4

    .line 172
    const-string v5, "setSsid"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Class;

    const/4 v7, 0x0

    const-class v8, Ljava/lang/String;

    aput-object v8, v6, v7

    invoke-virtual {v1, v5, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v5

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object p1, v6, v7

    invoke-virtual {v5, v4, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 173
    if-eqz p2, :cond_4

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_4

    const-string v5, "setWpa2Passphrase"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Class;

    const/4 v7, 0x0

    const-class v8, Ljava/lang/String;

    aput-object v8, v6, v7

    invoke-virtual {v1, v5, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v5

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object p2, v6, v7

    invoke-virtual {v5, v4, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 174
    :cond_4
    const-string v5, "build"

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Class;

    invoke-virtual {v1, v5, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v1, v4, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 175
    new-instance v5, Landroid/net/NetworkRequest$Builder;

    invoke-direct {v5}, Landroid/net/NetworkRequest$Builder;-><init>()V

    .line 176
    const/4 v1, 0x1

    invoke-virtual {v5, v1}, Landroid/net/NetworkRequest$Builder;->addTransportType(I)Landroid/net/NetworkRequest$Builder;

    .line 177
    const/16 v1, 0xc

    invoke-virtual {v5, v1}, Landroid/net/NetworkRequest$Builder;->removeCapability(I)Landroid/net/NetworkRequest$Builder;

    .line 178
    const-class v1, Landroid/net/NetworkRequest$Builder;

    invoke-virtual {v1}, Ljava/lang/Class;->getMethods()[Ljava/lang/reflect/Method;

    move-result-object v6

    array-length v7, v6

    const/4 v1, 0x0

    :goto_2
    if-ge v1, v7, :cond_6

    aget-object v8, v6, v1

    .line 179
    invoke-virtual {v8}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object v9

    const-string v10, "setNetworkSpecifier"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_5

    invoke-virtual {v8}, Ljava/lang/reflect/Method;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v9

    array-length v9, v9

    const/4 v10, 0x1

    if-ne v9, v10, :cond_5

    invoke-virtual {v8}, Ljava/lang/reflect/Method;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v9

    const/4 v10, 0x0

    aget-object v9, v9, v10

    invoke-virtual {v9, v4}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_5

    .line 180
    const/4 v9, 0x1

    new-array v9, v9, [Ljava/lang/Object;

    const/4 v10, 0x0

    aput-object v4, v9, v10

    invoke-virtual {v8, v5, v9}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 178
    :cond_5
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 181
    :cond_6
    new-instance v1, Lro/outyds/remote/PhevBackgroundService$2;

    invoke-direct {v1, p0, v3, v2}, Lro/outyds/remote/PhevBackgroundService$2;-><init>(Lro/outyds/remote/PhevBackgroundService;Ljava/lang/Object;[Landroid/net/Network;)V

    .line 185
    invoke-virtual {v5}, Landroid/net/NetworkRequest$Builder;->build()Landroid/net/NetworkRequest;

    move-result-object v4

    invoke-virtual {v0, v4, v1}, Landroid/net/ConnectivityManager;->requestNetwork(Landroid/net/NetworkRequest;Landroid/net/ConnectivityManager$NetworkCallback;)V

    .line 186
    monitor-enter v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x0

    :try_start_1
    aget-object v0, v2, v0

    if-nez v0, :cond_7

    invoke-virtual {v3, p3, p4}, Ljava/lang/Object;->wait(J)V

    :cond_7
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 188
    :goto_3
    const/4 v0, 0x0

    aget-object v0, v2, v0

    goto/16 :goto_1

    .line 186
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    throw v0
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    .line 187
    :catch_0
    move-exception v0

    goto :goto_3
.end method

.method private ro()Z
    .locals 2

    .prologue
    .line 49
    invoke-virtual {p0}, Lro/outyds/remote/PhevBackgroundService;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    const-string v1, "ro"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method private runJob(ILjava/lang/String;)V
    .locals 10

    .prologue
    const/4 v1, 0x0

    .line 53
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    move v0, v1

    move v2, v1

    .line 56
    :cond_0
    :goto_0
    iget-boolean v3, p0, Lro/outyds/remote/PhevBackgroundService;->stopped:Z

    if-nez v3, :cond_1

    if-nez v0, :cond_1

    const/4 v3, 0x3

    if-ge v2, v3, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    sub-long/2addr v6, v4

    const-wide/32 v8, 0x124f80

    cmp-long v3, v6, v8

    if-gez v3, :cond_1

    .line 57
    add-int/lit8 v2, v2, 0x1

    .line 59
    :try_start_0
    invoke-direct {p0, p1}, Lro/outyds/remote/PhevBackgroundService;->attemptOnce(I)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result v0

    .line 63
    :goto_1
    if-nez v0, :cond_0

    iget-boolean v3, p0, Lro/outyds/remote/PhevBackgroundService;->stopped:Z

    if-nez v3, :cond_0

    .line 64
    invoke-direct {p0}, Lro/outyds/remote/PhevBackgroundService;->ro()Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "Re\u00eencerc \u00een 30 s\u2026"

    :goto_2
    invoke-direct {p0, v3, v1}, Lro/outyds/remote/PhevBackgroundService;->updateNotification(Ljava/lang/String;Z)V

    .line 65
    const-wide/16 v6, 0x7530

    :try_start_1
    invoke-static {v6, v7}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception v2

    .line 68
    :cond_1
    if-eqz v0, :cond_4

    .line 69
    invoke-direct {p0}, Lro/outyds/remote/PhevBackgroundService;->ro()Z

    move-result v0

    if-eqz v0, :cond_3

    const-string v0, "Pre\u00eenc\u0103lzire confirmat\u0103 de ma\u0219in\u0103"

    .line 71
    :goto_3
    const/4 v2, 0x1

    invoke-direct {p0, v0, v2}, Lro/outyds/remote/PhevBackgroundService;->updateNotification(Ljava/lang/String;Z)V

    .line 72
    invoke-virtual {p0}, Lro/outyds/remote/PhevBackgroundService;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v2, "phev"

    invoke-virtual {v0, v2, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 73
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "firedAt"

    const-wide/16 v4, 0x0

    invoke-interface {v0, v2, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 74
    invoke-virtual {p0, v1}, Lro/outyds/remote/PhevBackgroundService;->stopForeground(Z)V

    .line 75
    invoke-virtual {p0}, Lro/outyds/remote/PhevBackgroundService;->stopSelf()V

    .line 76
    return-void

    .line 64
    :cond_2
    const-string v3, "Retrying in 30s\u2026"

    goto :goto_2

    .line 69
    :cond_3
    const-string v0, "Preheat confirmed by the car"

    goto :goto_3

    .line 70
    :cond_4
    invoke-direct {p0}, Lro/outyds/remote/PhevBackgroundService;->ro()Z

    move-result v0

    if-eqz v0, :cond_5

    const-string v0, "Nu s-a putut confirma - deschide aplica\u021bia l\u00e2ng\u0103 ma\u0219in\u0103"

    goto :goto_3

    :cond_5
    const-string v0, "Could not confirm - open the app near the car"

    goto :goto_3

    .line 60
    :catch_1
    move-exception v3

    goto :goto_1
.end method

.method private static toByteArray([I)[B
    .locals 3

    .prologue
    .line 156
    array-length v0, p0

    new-array v1, v0, [B

    const/4 v0, 0x0

    :goto_0
    array-length v2, p0

    if-ge v0, v2, :cond_0

    aget v2, p0, v0

    int-to-byte v2, v2

    aput-byte v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-object v1
.end method

.method private static toIntArray([BI)[I
    .locals 3

    .prologue
    .line 155
    new-array v1, p1, [I

    const/4 v0, 0x0

    :goto_0
    if-ge v0, p1, :cond_0

    aget-byte v2, p0, v0

    and-int/lit16 v2, v2, 0xff

    aput v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-object v1
.end method

.method private updateNotification(Ljava/lang/String;Z)V
    .locals 3

    .prologue
    .line 210
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Lro/outyds/remote/PhevBackgroundService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    .line 211
    const/16 v1, 0x1c8e

    invoke-direct {p0, p1, p2}, Lro/outyds/remote/PhevBackgroundService;->buildNotification(Ljava/lang/String;Z)Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 212
    return-void
.end method

.method private waitAck(Ljava/io/InputStream;[BLro/outyds/remote/PhevMiniProtocol$SecurityKey;IJ)Z
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    const/4 v0, 0x1

    .line 145
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    add-long/2addr v2, p5

    .line 146
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    cmp-long v1, v4, v2

    if-gez v1, :cond_1

    .line 147
    invoke-virtual {p1, p2}, Ljava/io/InputStream;->read([B)I

    move-result v1

    .line 148
    if-lez v1, :cond_0

    .line 149
    invoke-static {p2, v1}, Lro/outyds/remote/PhevBackgroundService;->toIntArray([BI)[I

    move-result-object v1

    invoke-static {v1}, Lro/outyds/remote/PhevMiniProtocol;->tryDecodeOne([I)Lro/outyds/remote/PhevMiniProtocol$Frame;

    move-result-object v1

    .line 150
    if-eqz v1, :cond_0

    iget v4, v1, Lro/outyds/remote/PhevMiniProtocol$Frame;->type:I

    const/16 v5, 0x6f

    if-ne v4, v5, :cond_0

    iget v4, v1, Lro/outyds/remote/PhevMiniProtocol$Frame;->ack:I

    if-ne v4, v0, :cond_0

    iget v1, v1, Lro/outyds/remote/PhevMiniProtocol$Frame;->register:I

    if-ne v1, p4, :cond_0

    .line 152
    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1

    .prologue
    .line 37
    const/4 v0, 0x0

    return-object v0
.end method

.method public onDestroy()V
    .locals 1

    .prologue
    .line 214
    const/4 v0, 0x1

    iput-boolean v0, p0, Lro/outyds/remote/PhevBackgroundService;->stopped:Z

    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 5

    .prologue
    const/16 v0, 0x14

    .line 41
    if-eqz p1, :cond_0

    const-string v1, "minutes"

    invoke-virtual {p1, v1, v0}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    move v2, v0

    .line 42
    :goto_0
    if-eqz p1, :cond_1

    const-string v0, "label"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 43
    :goto_1
    const/16 v3, 0x1c8e

    invoke-direct {p0}, Lro/outyds/remote/PhevBackgroundService;->ro()Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v1, "Se conecteaz\u0103 la ma\u0219in\u0103\u2026"

    :goto_2
    const/4 v4, 0x0

    invoke-direct {p0, v1, v4}, Lro/outyds/remote/PhevBackgroundService;->buildNotification(Ljava/lang/String;Z)Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {p0, v3, v1}, Lro/outyds/remote/PhevBackgroundService;->startForeground(ILandroid/app/Notification;)V

    .line 44
    new-instance v1, Ljava/lang/Thread;

    new-instance v3, Lro/outyds/remote/PhevBackgroundService$1;

    invoke-direct {v3, p0, v2, v0}, Lro/outyds/remote/PhevBackgroundService$1;-><init>(Lro/outyds/remote/PhevBackgroundService;ILjava/lang/String;)V

    const-string v0, "phev-bg-job"

    invoke-direct {v1, v3, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    .line 45
    const/4 v0, 0x2

    return v0

    :cond_0
    move v2, v0

    .line 41
    goto :goto_0

    .line 42
    :cond_1
    const/4 v0, 0x0

    goto :goto_1

    .line 43
    :cond_2
    const-string v1, "Connecting to the car\u2026"

    goto :goto_2
.end method

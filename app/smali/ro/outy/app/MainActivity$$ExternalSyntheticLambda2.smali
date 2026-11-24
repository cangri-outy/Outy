.class public final synthetic Lro/outy/app/MainActivity$$ExternalSyntheticLambda2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lro/outy/app/MainActivity;

.field public final synthetic f$1:Ljava/io/InputStream;

.field public final synthetic f$2:Landroid/bluetooth/BluetoothSocket;


# direct methods
.method public synthetic constructor <init>(Lro/outy/app/MainActivity;Ljava/io/InputStream;Landroid/bluetooth/BluetoothSocket;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda2;->f$0:Lro/outy/app/MainActivity;

    iput-object p2, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda2;->f$1:Ljava/io/InputStream;

    iput-object p3, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda2;->f$2:Landroid/bluetooth/BluetoothSocket;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    iget-object v0, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda2;->f$0:Lro/outy/app/MainActivity;

    iget-object v1, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda2;->f$1:Ljava/io/InputStream;

    iget-object v2, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda2;->f$2:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v0, v1, v2}, Lro/outy/app/MainActivity;->lambda$startReader$8$ro-outy-app-MainActivity(Ljava/io/InputStream;Landroid/bluetooth/BluetoothSocket;)V

    return-void
.end method

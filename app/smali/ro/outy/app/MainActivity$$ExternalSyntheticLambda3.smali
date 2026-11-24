.class public final synthetic Lro/outy/app/MainActivity$$ExternalSyntheticLambda3;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lro/outy/app/MainActivity;

.field public final synthetic f$1:Landroid/bluetooth/BluetoothDevice;


# direct methods
.method public synthetic constructor <init>(Lro/outy/app/MainActivity;Landroid/bluetooth/BluetoothDevice;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda3;->f$0:Lro/outy/app/MainActivity;

    iput-object p2, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda3;->f$1:Landroid/bluetooth/BluetoothDevice;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda3;->f$0:Lro/outy/app/MainActivity;

    iget-object v1, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda3;->f$1:Landroid/bluetooth/BluetoothDevice;

    invoke-virtual {v0, v1}, Lro/outy/app/MainActivity;->lambda$connect$7$ro-outy-app-MainActivity(Landroid/bluetooth/BluetoothDevice;)V

    return-void
.end method

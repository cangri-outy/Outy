.class public final synthetic Lro/outy/app/MainActivity$$ExternalSyntheticLambda4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/Comparator;


# instance fields
.field public final synthetic f$0:Lro/outy/app/MainActivity;


# direct methods
.method public synthetic constructor <init>(Lro/outy/app/MainActivity;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda4;->f$0:Lro/outy/app/MainActivity;

    return-void
.end method


# virtual methods
.method public final compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 1

    iget-object v0, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda4;->f$0:Lro/outy/app/MainActivity;

    check-cast p1, Landroid/bluetooth/BluetoothDevice;

    check-cast p2, Landroid/bluetooth/BluetoothDevice;

    invoke-virtual {v0, p1, p2}, Lro/outy/app/MainActivity;->lambda$showPicker$1$ro-outy-app-MainActivity(Landroid/bluetooth/BluetoothDevice;Landroid/bluetooth/BluetoothDevice;)I

    move-result p1

    return p1
.end method

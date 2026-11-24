.class public final synthetic Lro/outy/app/MainActivity$$ExternalSyntheticLambda5;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# instance fields
.field public final synthetic f$0:Lro/outy/app/MainActivity;

.field public final synthetic f$1:Ljava/util/List;


# direct methods
.method public synthetic constructor <init>(Lro/outy/app/MainActivity;Ljava/util/List;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda5;->f$0:Lro/outy/app/MainActivity;

    iput-object p2, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda5;->f$1:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    iget-object v0, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda5;->f$0:Lro/outy/app/MainActivity;

    iget-object v1, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda5;->f$1:Ljava/util/List;

    invoke-virtual {v0, v1, p1, p2}, Lro/outy/app/MainActivity;->lambda$showPicker$2$ro-outy-app-MainActivity(Ljava/util/List;Landroid/content/DialogInterface;I)V

    return-void
.end method

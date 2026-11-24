.class public final synthetic Lro/outy/app/MainActivity$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lro/outy/app/MainActivity;

.field public final synthetic f$1:Ljava/lang/String;


# direct methods
.method public synthetic constructor <init>(Lro/outy/app/MainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda1;->f$0:Lro/outy/app/MainActivity;

    iput-object p2, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda1;->f$1:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda1;->f$0:Lro/outy/app/MainActivity;

    iget-object v1, p0, Lro/outy/app/MainActivity$$ExternalSyntheticLambda1;->f$1:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lro/outy/app/MainActivity;->lambda$connectSaved$5$ro-outy-app-MainActivity(Ljava/lang/String;)V

    return-void
.end method

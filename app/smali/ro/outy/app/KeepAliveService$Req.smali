.class final Lro/outy/app/KeepAliveService$Req;
.super Ljava/lang/Object;
.source "KeepAliveService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lro/outy/app/KeepAliveService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Req"
.end annotation


# instance fields
.field private final a:Landroid/app/Activity;

.field private final on:Z

.field private final t:Ljava/lang/String;


# direct methods
.method constructor <init>(Landroid/app/Activity;ZLjava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lro/outy/app/KeepAliveService$Req;->a:Landroid/app/Activity;

    iput-boolean p2, p0, Lro/outy/app/KeepAliveService$Req;->on:Z

    iput-object p3, p0, Lro/outy/app/KeepAliveService$Req;->t:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lro/outy/app/KeepAliveService$Req;->a:Landroid/app/Activity;

    iget-boolean v1, p0, Lro/outy/app/KeepAliveService$Req;->on:Z

    iget-object v2, p0, Lro/outy/app/KeepAliveService$Req;->t:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lro/outy/app/KeepAliveService;->apply(Landroid/app/Activity;ZLjava/lang/String;)V

    return-void
.end method

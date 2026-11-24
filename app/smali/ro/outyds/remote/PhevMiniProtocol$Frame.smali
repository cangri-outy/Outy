.class public final Lro/outyds/remote/PhevMiniProtocol$Frame;
.super Ljava/lang/Object;
.source "PhevMiniProtocol.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lro/outyds/remote/PhevMiniProtocol;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Frame"
.end annotation


# instance fields
.field public ack:I

.field public data:[I

.field public register:I

.field public type:I

.field public xor:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

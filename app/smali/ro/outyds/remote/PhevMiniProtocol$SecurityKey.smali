.class public final Lro/outyds/remote/PhevMiniProtocol$SecurityKey;
.super Ljava/lang/Object;
.source "PhevMiniProtocol.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lro/outyds/remote/PhevMiniProtocol;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "SecurityKey"
.end annotation


# instance fields
.field public keyMap:[I

.field public rNum:I

.field public sNum:I

.field public securityKey:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    const/4 v0, 0x0

    new-array v0, v0, [I

    iput-object v0, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->keyMap:[I

    return-void
.end method


# virtual methods
.method public rKey(Z)I
    .locals 2

    .prologue
    .line 54
    iget-object v0, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->keyMap:[I

    array-length v0, v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    iget v0, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->rNum:I

    if-eqz p1, :cond_1

    iget v1, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->rNum:I

    add-int/lit8 v1, v1, 0x1

    and-int/lit16 v1, v1, 0xff

    iput v1, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->rNum:I

    :cond_1
    iget-object v1, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->keyMap:[I

    aget v0, v1, v0

    goto :goto_0
.end method

.method public sKey(Z)I
    .locals 2

    .prologue
    .line 53
    iget-object v0, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->keyMap:[I

    array-length v0, v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    iget v0, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->sNum:I

    if-eqz p1, :cond_1

    iget v1, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->sNum:I

    add-int/lit8 v1, v1, 0x1

    and-int/lit16 v1, v1, 0xff

    iput v1, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->sNum:I

    :cond_1
    iget-object v1, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->keyMap:[I

    aget v0, v1, v0

    goto :goto_0
.end method

.method public update([II)V
    .locals 7

    .prologue
    const/16 v6, 0x100

    const/4 v1, 0x0

    .line 38
    if-eqz p2, :cond_0

    .line 52
    :goto_0
    return-void

    .line 39
    :cond_0
    array-length v0, p1

    const/16 v2, 0xe

    if-ne v0, v2, :cond_1

    const/4 v0, 0x1

    aget v0, p1, v0

    const/16 v2, 0xc

    if-eq v0, v2, :cond_2

    :cond_1
    new-array v0, v1, [I

    iput-object v0, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->keyMap:[I

    iput v1, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->securityKey:I

    iput v1, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->sNum:I

    iput v1, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->rNum:I

    goto :goto_0

    .line 40
    :cond_2
    const/4 v0, 0x4

    aget v0, p1, v0

    and-int/lit8 v0, v0, 0x8

    shr-int/lit8 v0, v0, 0x3

    .line 41
    const/4 v2, 0x5

    aget v2, p1, v2

    and-int/lit8 v2, v2, 0x8

    shr-int/lit8 v2, v2, 0x2

    or-int/2addr v0, v2

    const/4 v2, 0x6

    aget v2, p1, v2

    and-int/lit8 v2, v2, 0x8

    shr-int/lit8 v2, v2, 0x1

    or-int/2addr v0, v2

    const/4 v2, 0x7

    aget v2, p1, v2

    and-int/lit8 v2, v2, 0x8

    or-int/2addr v0, v2

    .line 42
    const/16 v2, 0x8

    aget v2, p1, v2

    and-int/lit8 v2, v2, 0x8

    shl-int/lit8 v2, v2, 0x1

    or-int/2addr v0, v2

    const/16 v2, 0x9

    aget v2, p1, v2

    and-int/lit8 v2, v2, 0x8

    shl-int/lit8 v2, v2, 0x2

    or-int/2addr v0, v2

    const/16 v2, 0xa

    aget v2, p1, v2

    and-int/lit8 v2, v2, 0x8

    shl-int/lit8 v2, v2, 0x3

    or-int/2addr v0, v2

    const/16 v2, 0xb

    aget v2, p1, v2

    and-int/lit8 v2, v2, 0x8

    shl-int/lit8 v2, v2, 0x4

    or-int/2addr v0, v2

    .line 43
    and-int/lit16 v0, v0, 0xff

    iput v0, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->securityKey:I

    .line 44
    new-array v3, v6, [I

    move v0, v1

    .line 45
    :goto_1
    if-ge v0, v6, :cond_3

    aput v0, v3, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    move v0, v1

    move v2, v1

    .line 47
    :goto_2
    if-ge v0, v6, :cond_4

    .line 48
    aget v4, v3, v0

    add-int/2addr v2, v4

    iget v4, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->securityKey:I

    add-int/2addr v2, v4

    rem-int/lit16 v2, v2, 0x100

    .line 49
    aget v4, v3, v0

    aget v5, v3, v2

    aput v5, v3, v0

    aput v4, v3, v2

    .line 47
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 51
    :cond_4
    iput-object v3, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->keyMap:[I

    iput v1, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->sNum:I

    iput v1, p0, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->rNum:I

    goto/16 :goto_0
.end method

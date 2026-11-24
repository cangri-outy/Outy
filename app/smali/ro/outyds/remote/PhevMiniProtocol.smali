.class final Lro/outyds/remote/PhevMiniProtocol;
.super Ljava/lang/Object;
.source "PhevMiniProtocol.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lro/outyds/remote/PhevMiniProtocol$Frame;,
        Lro/outyds/remote/PhevMiniProtocol$SecurityKey;
    }
.end annotation


# static fields
.field public static final BAD_XOR:I = 0xbb

.field public static final PING_REQ:I = 0xf3

.field public static final RESP:I = 0x6f

.field public static final SEND:I = 0xf6

.field public static final START14:I = 0x4e

.field public static final START14_RESP:I = 0xe4

.field public static final START18:I = 0x5e

.field public static final START18_RESP:I = 0xe5

.field public static final START24:I = 0x6e

.field public static final START24_RESP:I = 0xe6

.field public static final START_RESP:I = 0x2f


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static checksum([II)I
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 18
    move v0, v1

    move v2, v1

    .line 19
    :goto_0
    add-int/lit8 v1, p1, -0x1

    if-ge v0, v1, :cond_0

    aget v1, p0, v0

    add-int/2addr v1, v2

    add-int/lit8 v0, v0, 0x1

    move v2, v1

    goto :goto_0

    .line 20
    :cond_0
    and-int/lit16 v0, v2, 0xff

    return v0
.end method

.method public static climateMy14Step1(II)[I
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 105
    const/16 v0, 0xf

    new-array v0, v0, [I

    .line 106
    const/16 v1, 0xff

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 107
    aput v2, v0, v2

    const/4 v1, 0x1

    aput v2, v0, v1

    const/4 v1, 0x6

    or-int v2, p0, p1

    aput v2, v0, v1

    .line 108
    return-object v0
.end method

.method public static climateMy14Step2(I)[I
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 112
    new-array v1, v0, [I

    const/4 v2, 0x0

    if-nez p0, :cond_0

    :goto_0
    aput v0, v1, v2

    return-object v1

    :cond_0
    const/4 v0, 0x2

    goto :goto_0
.end method

.method public static climateMy18(II)[I
    .locals 5

    .prologue
    const/4 v2, 0x2

    const/4 v1, 0x1

    const/4 v4, 0x0

    .line 101
    const/4 v0, 0x4

    new-array v3, v0, [I

    if-nez p0, :cond_0

    move v0, v1

    :goto_0
    aput v0, v3, v4

    aput p0, v3, v1

    aput p1, v3, v2

    const/4 v0, 0x3

    aput v4, v3, v0

    return-object v3

    :cond_0
    move v0, v2

    goto :goto_0
.end method

.method public static encode(III[ILro/outyds/remote/PhevMiniProtocol$SecurityKey;)[I
    .locals 5

    .prologue
    const/4 v4, 0x1

    const/4 v0, 0x0

    .line 86
    array-length v1, p3

    add-int/lit8 v1, v1, 0x4

    add-int/lit8 v1, v1, 0x1

    new-array v1, v1, [I

    .line 87
    aput p0, v1, v0

    array-length v2, p3

    add-int/lit8 v2, v2, 0x3

    and-int/lit16 v2, v2, 0xff

    aput v2, v1, v4

    const/4 v2, 0x2

    aput p1, v1, v2

    const/4 v2, 0x3

    aput p2, v1, v2

    .line 88
    const/4 v2, 0x4

    array-length v3, p3

    invoke-static {p3, v0, v1, v2, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 89
    array-length v2, v1

    add-int/lit8 v2, v2, -0x1

    array-length v3, v1

    invoke-static {v1, v3}, Lro/outyds/remote/PhevMiniProtocol;->checksum([II)I

    move-result v3

    aput v3, v1, v2

    .line 91
    sparse-switch p0, :sswitch_data_0

    .line 94
    invoke-virtual {p4, v0}, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->sKey(Z)I

    move-result v0

    .line 96
    :goto_0
    :sswitch_0
    invoke-static {v1, v0}, Lro/outyds/remote/PhevMiniProtocol;->xorWith([II)[I

    move-result-object v0

    return-object v0

    .line 93
    :sswitch_1
    invoke-virtual {p4, v4}, Lro/outyds/remote/PhevMiniProtocol$SecurityKey;->sKey(Z)I

    move-result v0

    goto :goto_0

    .line 91
    :sswitch_data_0
    .sparse-switch
        0x4e -> :sswitch_0
        0x5e -> :sswitch_0
        0x6e -> :sswitch_0
        0xe4 -> :sswitch_0
        0xe5 -> :sswitch_0
        0xe6 -> :sswitch_0
        0xf6 -> :sswitch_1
    .end sparse-switch
.end method

.method public static tryDecodeOne([I)Lro/outyds/remote/PhevMiniProtocol$Frame;
    .locals 13

    .prologue
    const/4 v12, 0x4

    const/4 v11, 0x3

    const/4 v10, 0x1

    const/4 v1, 0x0

    const/4 v9, 0x2

    .line 67
    array-length v0, p0

    if-ge v0, v12, :cond_0

    const/4 v0, 0x0

    .line 82
    :goto_0
    return-object v0

    .line 68
    :cond_0
    new-array v2, v9, [I

    aget v0, p0, v9

    aput v0, v2, v1

    aget v0, p0, v9

    xor-int/lit8 v0, v0, 0x1

    aput v0, v2, v10

    .line 69
    array-length v3, v2

    move v0, v1

    :goto_1
    if-ge v0, v3, :cond_3

    aget v4, v2, v0

    .line 70
    aget v5, p0, v10

    xor-int/2addr v5, v4

    add-int/lit8 v5, v5, 0x2

    .line 71
    if-lt v5, v11, :cond_1

    const/16 v6, 0xfd

    if-le v5, v6, :cond_2

    .line 69
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 72
    :cond_2
    array-length v6, p0

    if-lt v6, v5, :cond_1

    .line 73
    invoke-static {p0, v5}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v6

    invoke-static {v6, v4}, Lro/outyds/remote/PhevMiniProtocol;->xorWith([II)[I

    move-result-object v6

    .line 74
    invoke-static {v6, v5}, Lro/outyds/remote/PhevMiniProtocol;->checksum([II)I

    move-result v7

    add-int/lit8 v8, v5, -0x1

    aget v8, v6, v8

    if-ne v7, v8, :cond_1

    .line 75
    new-instance v0, Lro/outyds/remote/PhevMiniProtocol$Frame;

    invoke-direct {v0}, Lro/outyds/remote/PhevMiniProtocol$Frame;-><init>()V

    .line 76
    aget v1, v6, v1

    iput v1, v0, Lro/outyds/remote/PhevMiniProtocol$Frame;->type:I

    aget v1, v6, v9

    iput v1, v0, Lro/outyds/remote/PhevMiniProtocol$Frame;->ack:I

    aget v1, v6, v11

    iput v1, v0, Lro/outyds/remote/PhevMiniProtocol$Frame;->register:I

    .line 77
    add-int/lit8 v1, v5, -0x1

    invoke-static {v6, v12, v1}, Ljava/util/Arrays;->copyOfRange([III)[I

    move-result-object v1

    iput-object v1, v0, Lro/outyds/remote/PhevMiniProtocol$Frame;->data:[I

    .line 78
    iput v4, v0, Lro/outyds/remote/PhevMiniProtocol$Frame;->xor:I

    goto :goto_0

    .line 82
    :cond_3
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static xorWith([II)[I
    .locals 3

    .prologue
    .line 24
    array-length v0, p0

    new-array v1, v0, [I

    .line 25
    const/4 v0, 0x0

    :goto_0
    array-length v2, p0

    if-ge v0, v2, :cond_0

    aget v2, p0, v0

    xor-int/2addr v2, p1

    and-int/lit16 v2, v2, 0xff

    aput v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 26
    :cond_0
    return-object v1
.end method

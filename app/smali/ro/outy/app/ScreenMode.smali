.class public Lro/outy/app/ScreenMode;
.super Ljava/lang/Object;
.source "ScreenMode.java"

# Runs on the UI thread. mode 0 = normal, 1 = keep screen on, 2 = keep screen on and dimmed (window brightness only, no permission).
.implements Ljava/lang/Runnable;


# instance fields
.field private final a:Landroid/app/Activity;

.field private final m:I


# direct methods
.method public constructor <init>(Landroid/app/Activity;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lro/outy/app/ScreenMode;->a:Landroid/app/Activity;

    iput p2, p0, Lro/outy/app/ScreenMode;->m:I

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lro/outy/app/ScreenMode;->a:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    iget v1, p0, Lro/outy/app/ScreenMode;->m:I

    const/16 v2, 0x80

    if-lez v1, :cond_off

    invoke-virtual {v0, v2}, Landroid/view/Window;->addFlags(I)V

    goto :cond_flag

    :cond_off
    invoke-virtual {v0, v2}, Landroid/view/Window;->clearFlags(I)V

    :cond_flag
    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    const/4 v4, 0x2

    if-ne v1, v4, :cond_bright

    const v1, 0x3d4ccccd

    goto :cond_set

    :cond_bright
    const/high16 v1, -0x40800000    # -1.0f (BRIGHTNESS_OVERRIDE_NONE)

    :cond_set
    iput v1, v3, Landroid/view/WindowManager$LayoutParams;->screenBrightness:F

    invoke-virtual {v0, v3}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    return-void
.end method

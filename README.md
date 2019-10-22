# WMMenuViewStyle
增加WMPageController选项卡自定义图片
# WMPageController选项卡自定义图片
#### 项目需求如下图：
* 修改选项卡为自定义图片
* 加粗选中的字体
* ![WMPageControlle](media/15717123341274/WMPageController.gif)

##### 查看WMPageController源代码，**验证**其最后都在```WMProgressView.m```中的```- (void)drawRect:(CGRect)rect```进行重绘。
##### 故仿照其重绘过程，增加自定义绘制在```WMProgressView.h```中
```
...
@property (nonatomic, assign) BOOL hollow;
@property (nonatomic, assign) BOOL hasBorder;
@property (nonatomic, assign) BOOL strokeImage; //增加填充图片Bool值，根据此值来进行绘制

- (void)setProgressWithOutAnimate:(CGFloat)progress;
```
在```WMProgressView.m```中的`drawRect:`方法中增加绘制方式
```
    if (self.strokeImage) {
        UIImage *image = [UIImage imageNamed:@"jy_healthInfo_ic_titleBG"];
        //翻转镜像
        CGContextTranslateCTM(ctx, 0, height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        //画图
        CGContextDrawImage(ctx, CGRectMake(startX+10, lineWidth / 2.0, width-20, height - lineWidth), image.CGImage);
        return;
    }
```
跟踪其hollow、hasBorder查看赋值的地方，发现在```addProgressViewWithFrame:::::```中
所以更新这个方法
```
- (void)addProgressViewWithFrame:(CGRect)frame isTriangle:(BOOL)isTriangle hasBorder:(BOOL)hasBorder hollow:(BOOL)isHollow strokeImage:(BOOL)strokeImage cornerRadius:(CGFloat)cornerRadius {
    WMProgressView *pView = [[WMProgressView alloc] initWithFrame:frame];
    pView.itemFrames = [self convertProgressWidthsToFrames];
    pView.color = self.lineColor.CGColor;
    pView.isTriangle = isTriangle;
    pView.hasBorder = hasBorder;
    pView.hollow = isHollow;
    pView.cornerRadius = cornerRadius;
    pView.naughty = self.progressViewIsNaughty;
    pView.speedFactor = self.speedFactor;
    pView.backgroundColor = [UIColor clearColor];
    pView.strokeImage = strokeImage;
    self.progressView = pView;
    [self.scrollView insertSubview:self.progressView atIndex:0];
}
```
添加stokeImage，并修改报错
```
    [self addProgressViewWithFrame:frame
                        isTriangle:(self.style == WMMenuViewStyleTriangle)
                         hasBorder:(self.style == WMMenuViewStyleSegmented)
                            hollow:(self.style == WMMenuViewStyleFloodHollow)
                       strokeImage:(self.style == WMMenuViewStyleStrokeImage)
                      cornerRadius:self.progressViewCornerRadius];
```

在```WMMenuView.h```中，增加枚举值
```
typedef NS_ENUM(NSUInteger, WMMenuViewStyle) {
    ...
    WMMenuViewStyleSegmented,    // 涌入带边框,即网易新闻选项卡
    WMMenuViewStyleStrokeImage,  // 添加自定义图片
};

```

在初始化WMPageController控制器的时候，将menuViewStyle属性赋值为新增的枚举值```self.pageController.menuViewStyle = WMMenuViewStyleStrokeImage;```

测试已经可以显示图片了。

最后，找到字体赋值的地方，修改粗体
```
        if (self.fontName) {
            item.font = [UIFont fontWithName:self.fontName size:item.selectedSize];
        } else {
            //item.font = [UIFont systemFontOfSize:item.selectedSize];
            item.font = [UIFont fontWithName:@"Helvetica-Bold" size:item.selectedSize]; //选中变成粗体
        }
```

完成，已经达到了设计要求

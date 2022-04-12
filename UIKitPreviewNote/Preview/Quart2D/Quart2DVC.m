//
//  Quart2DVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/7.
//

#import "Quart2DVC.h"
#import "Quart2DTestView.h"

@interface Quart2DVC ()

@end

@implementation Quart2DVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"Quart2D";
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 1;
    [scrollView addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
        make.width.mas_equalTo(scrollView.mas_width);
    }];
    
    /**
     1.获取当前上下文（context）（UIGraphicsGetCurrentContext）
     2.设置颜色：
         CGContextSetFillColorWithColor：设置描边颜色
         CGContextSetFillColorWithColor：设置填充颜色
     3. 画的范围
         CGContextStrokeRect：描边的范围
         CGContextFillRect：填充的范围
     4.CGContextSetLineWidth：线宽
     5.CGContextSetLineCap：线顶端的样式
     6.CGContextSetLineJoin：线拐角的样式
     7. 线的起始点：
         CGContextMoveToPoint：起点
         CGContextAddLineToPoint：终点
     8.CGContextFillPath ：填充的路径
     9.CGContextStrokePath：描边的路径
     */
    {
        /**
         CGContextSetLineDash参数详解
         void CGContextSetLineDash (
         CGContextRef _Nullable c,
         CGFloat phase,
         const CGFloat * _Nullable lengths,
         size_t count
         );
         c 绘制的context，这个不用多说
         phase，第一个虚线段从哪里开始，例如传入3，则从第三个单位开始
         lengths,一个C数组，表示绘制部分和空白部分的分配。例如传入[2,2],则绘制2个单位，然后空白两个单位，以此重复
         count lengths的数量
         */
        UIView *view = [[Quart2DTestView alloc] initWithBlock:^(CGRect rect) {
            //1.获得当前context
           CGContextRef context = UIGraphicsGetCurrentContext();
           
           //设置颜色 (填充色和 描边的颜色)
           CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.8 alpha:1].CGColor);
           CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
           
           //设置描边线宽
           CGContextSetLineWidth(context, 20);
           
           //对矩形进行填色  或  描边
           //（注意：如果先描边再填充，由于矩形大小一致，那么描边的线就会被填充的矩形挡住）
           CGContextFillRect(context, rect);
           CGContextStrokeRect(context, rect);
           
           //-----------------------------------------------------------------
           
           //MARK: ------ 实际line和point的代码
           // 设置描边颜色
           CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);    CGContextSetLineWidth(context, 8.0);//线的宽度
           CGContextSetLineCap(context, kCGLineCapRound);//线的顶端
           CGContextSetLineJoin(context, kCGLineJoinRound);//线相交的模式
           
           //-----------------------------------------------------------------
           //MARK:黄色的  ">" 图形
           //移动画笔到哪个点
           CGContextMoveToPoint(context,20,20);
           //画笔画到哪个点
           CGContextAddLineToPoint(context, rect.size.width - 20, rect.size.height / 2 - 20);
           CGContextAddLineToPoint(context, 20, rect.size.height - 20);
           //根据上下文中的点，成线进行描边
           CGContextStrokePath(context);
           
           //------------------------------------------------------------------
           //MARK: 红色的小的三角的填充
           CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
           CGContextMoveToPoint(context, 0, rect.size.height / 2 - 30);
           CGContextAddLineToPoint(context, 30, rect.size.height / 2);
           CGContextAddLineToPoint(context, 0, rect.size.height / 2 + 30);
           CGContextFillPath(context);
          //虚线效果
         //CGContextSetLineDash(context, 1, lengths, 1);

        //------------------------------------------------------------------
           //MARK: 红色虚线效果
           CGContextSetStrokeColorWithColor(context,[UIColor redColor].CGColor);
           CGContextSetLineWidth(context, 1);
           
           CGContextMoveToPoint(context, rect.size.width - 20, 20);
           CGContextAddLineToPoint(context, rect.size.height - 20, rect.size.width - 20);
           CGFloat lengths[] = {20};
           CGContextSetLineDash(context, 1, lengths, 1);
           CGContextStrokePath(context);
        }];
        [stackView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(200);
        }];
    }
    {
        /**
         曲线— 圆弧的绘制
         Quartz提供了两个方法来绘制圆弧
         
         CGContextAddArc，普通的圆弧一部分（以某圆心，某半径，某弧度的圆弧）

         CGContextAddArcToPoint，用来绘制圆角

         CGContextAddArc
         
         结构：
         void CGContextAddArc (
         CGContextRef _Nullable c,
         CGFloat x, // 圆心X坐标
         CGFloat y, // 圆心Y坐标
         CGFloat radius, // 弧度半径
         CGFloat startAngle, // 开始的弧度
         CGFloat endAngle, // 结束的弧度
         int clockwise //1表示顺时针，0表示逆时针
         );
         */
        UIView *view = [[Quart2DTestView alloc] initWithBlock:^(CGRect rect) {
            //MARK: 画弧
            //1.获取图片上下文
            CGContextRef context = UIGraphicsGetCurrentContext();
            //2.设置弧度及位置
             //根据中心点，半径，起始的弧度，最后的弧度，是否顺时针画一个圆弧
            CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, 20, M_PI_4, M_PI, 1);
            CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
            //3.画
            CGContextDrawPath(context, kCGPathStroke);

            // -----------------------------------------------------

            //MARK:画有线圈的圆饼
            CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);//设置线的颜色
            CGContextSetRGBFillColor(context, 0, 0, 1, 1);//设置填充颜色
            CGContextSetLineWidth(context, 2); //设置线的宽度
            CGContextAddEllipseInRect(context, CGRectMake(10, 30, 60, 60)); //画一个椭圆或者圆
            CGContextDrawPath(context, kCGPathFillStroke);
        }];
        [stackView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(200);
        }];
    }
    {
        /**
         void CGContextAddArcToPoint (
         CGContextRef _Nullable c,
         CGFloat x1,
         CGFloat y1,
         CGFloat x2,
         CGFloat y2,
         CGFloat radius
         );
         c context x1,y1和当前点(x0,y0)决定了第一条切线（x0,y0）->(x1,y1) x2,y2和(x1,y1)决定了第二条切线 radius,想切的半径。
         也就是说，
         绘制一个半径为radius的圆弧，和上述 两条直线都相切
         */
        UIView *view = [[Quart2DTestView alloc] initWithBlock:^(CGRect rect) {
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1);//设置线的颜色
            CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);//设置填充颜色
            CGContextSetLineWidth(ctx, 2); //设置线的宽度

            //CGContextAddArcToPoint 先要确定三个点，
            //1.从哪里开始划线 CGContextMoveToPoint （也就是两条线的交点）
            //2.第二个点与起始点  确定一条直线
            //3.第三个点与第二个点  确定另外一条直线
            
            //画一个圆角矩形
            //确定矩形的位置和大小
            CGRect rrect = CGRectMake(rect.size.width / 2 - 30, rect.size.height / 2 - 30, 60.0, 60.0);
            
            CGFloat radius = 15.0;//半径，半径为正方形一半时，那就可以切成圆形
            
            CGFloat
            minx = CGRectGetMinX(rrect),//矩形中最小的x
            midx = CGRectGetMidX(rrect),//矩形中最大x值的一半
            maxx = CGRectGetMaxX(rrect);//矩形中最大的x值
            
            CGFloat
            miny = CGRectGetMinY(rrect),//矩形中最小的Y值
            midy = CGRectGetMidY(rrect),//矩形中最大Y值的一半
            maxy = CGRectGetMaxY(rrect);//矩形中最大的Y值
            
            
            CGContextMoveToPoint(ctx, minx, midy);//从点A 开始
            //从点A到点B再从点B到点C形成夹角进行切圆
            CGContextAddArcToPoint(ctx, minx, miny, midx, miny, radius);
            CGContextAddArcToPoint(ctx, maxx, miny, maxx, midy, radius);
            CGContextAddArcToPoint(ctx, maxx, maxy, midx, maxy, radius);
            CGContextAddArcToPoint(ctx, minx, maxy, minx, midy, radius);
//            CGContextAddLineToPoint(ctx, minx, maxy);
            CGContextClosePath(ctx);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            //如果想要进行裁切的话去掉CGContextDrawPath(ctx, kCGPathFillStroke);方法 添加以下方法
            //CGContextClip(context);
            //CGContextFillPath(context);
        //添加图片
        //CGContextDrawImage(context, rect, self.image.CGImage)；
        //或者[self.image drawInRect:rect];
        }];
        [stackView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(200);
        }];
    }
    {
        /**
         
         */
        UIView *view = [[Quart2DTestView alloc] initWithBlock:^(CGRect rect) {
            
            NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"hellohellohellohello\nworld" attributes:@{NSBackgroundColorAttributeName:UIColor.redColor, NSForegroundColorAttributeName:UIColor.whiteColor, NSFontAttributeName:[UIFont systemFontOfSize:16]}];
            CGSize size = [attr boundingRectWithSize:rect.size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
            [attr drawInRect:CGRectMake(10, 10, size.width, size.height)];
        }];
        [stackView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(200);
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

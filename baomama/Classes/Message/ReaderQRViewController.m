//
//  ReaderQRViewController.m
//  baomama
//
//  Created by bihongbo on 5/24/15.
//  Copyright (c) 2015 bb-coder. All rights reserved.
//

#import "ReaderQRViewController.h"

#define SCANVIEW_EdgeTop 40.0
#define SCANVIEW_EdgeLeft 50.0
#define TINTCOLOR_ALPHA 0.2 //浅色透明度
#define DARKCOLOR_ALPHA 0.5 //深色透明度
#define VIEW_WIDTH self.view.width
#define VIEW_HEIGHT self.view.height

@interface ReaderQRViewController ()<ZBarReaderViewDelegate>

//@property (nonatomic,strong) ZBarReaderView * readerView;
//
//@property (nonatomic,strong) UIImageView * readLineView;
//
//@property (nonatomic,strong) UIImageView * scanZomeBack;

{
    UIView *_QrCodeline;
    NSTimer *_timer;
    //设置扫描画面
    UIView *_scanView;
    ZBarReaderView *_readerView;
}
@end

@implementation ReaderQRViewController


- ( void )viewDidLoad
{
    [ super viewDidLoad ];
    self . title = @"扫描二维码" ;
    //初始化扫描界面
    [ self setScanView ];
    _readerView = [[ ZBarReaderView alloc ] init ];
    
    _readerView.frame = CGRectMake( 0,0 , VIEW_WIDTH , VIEW_HEIGHT);
    _readerView . tracksSymbols = NO ;
    _readerView . readerDelegate = self ;
    [ _readerView addSubview : _scanView ];
    //关闭闪光灯
    _readerView . torchMode = 0 ;
    [ self . view addSubview : _readerView ];
    //扫描区域
    //readerView.scanCrop =
    [ _readerView start ];
    [ self createTimer ];
}
#pragma mark -- ZBarReaderViewDelegate
-( void )readerView:( ZBarReaderView *)readerView didReadSymbols:( ZBarSymbolSet *)symbols fromImage:( UIImage *)image
{
    ZBarSymbol *symbol;
    for (symbol in symbols) {
        NSLog(@"%@", symbol.data);
        break;
    }
    NSString * symbolStr = symbol.data;
    
    if ([symbolStr canBeConvertedToEncoding:NSShiftJISStringEncoding])
    {
        symbolStr = [NSString stringWithCString:[symbolStr cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
    }

    
    if ([symbolStr hasPrefix:@"baomama"]) {
        
        BBLog(@"%@",symbolStr);
        NSString *userId = [symbolStr stringByReplacingOccurrencesOfString:@"baomama" withString:@""];
        NSRange r1 = [userId rangeOfString:@":"];
        NSRange r2;
        r2.location = r1.location;
        r2.length = userId.length - r1.location;
        NSString * name = [userId stringByReplacingCharactersInRange:r2 withString:@""];
        __block BOOL isAdded;
        
        [[FMDBTool queue] inDatabase:^(FMDatabase *db) {
            
            FMResultSet * rs = [db executeQuery:@"select * from FRIENDS where userId = ?",userId];
            isAdded = rs.next;
            [rs close];
            
        }];
        
        NSString * message;
        
        if(!isAdded){
        [[FMDBTool queue] inDatabase:^(FMDatabase *db) {

            [db executeUpdate:@"insert into FRIENDS(name,userId) values(?,?)",name,userId];
 
        }];
            message = [NSString stringWithFormat:@"添加好友 %@ 成功！",name
                       ];
        }
        else
        {
            message = [NSString stringWithFormat:@"您已经添加过 %@ 了哦！",name
                       ];
        }

        
        UIAlertView *alertView=[[ UIAlertView alloc ] initWithTitle : @"" message :message delegate : nil cancelButtonTitle : @"确定" otherButtonTitles : nil ];
        [alertView show ];
    }
    
}
//二维码的扫描区域
- ( void )setScanView
{
    _scanView =[[ UIView alloc ] initWithFrame : CGRectMake ( 0 , 0 , VIEW_WIDTH , VIEW_HEIGHT )];
    _scanView . backgroundColor =[ UIColor clearColor ];
    //最上部view
    UIView * upView = [[ UIView alloc ] initWithFrame : CGRectMake ( 0 , 0 , VIEW_WIDTH , SCANVIEW_EdgeTop )];
    upView. alpha = TINTCOLOR_ALPHA ;
    upView. backgroundColor = [ UIColor blackColor ];
    [ _scanView addSubview :upView];
    //左侧的view
    UIView *leftView = [[ UIView alloc ] initWithFrame : CGRectMake ( 0 , SCANVIEW_EdgeTop , SCANVIEW_EdgeLeft , VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft )];
    leftView. alpha = TINTCOLOR_ALPHA ;
    leftView. backgroundColor = [ UIColor blackColor ];
    [ _scanView addSubview :leftView];
    /******************中间扫描区域****************************/
    UIImageView *scanCropView=[[ UIImageView alloc ] initWithFrame : CGRectMake ( SCANVIEW_EdgeLeft , SCANVIEW_EdgeTop , VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft , VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft )];
    //scanCropView.image=[UIImage imageNamed:@""];
    scanCropView.layer.borderColor =[UIColor greenColor].CGColor;
    scanCropView. layer . borderWidth = 2.0 ;
    scanCropView. backgroundColor =[ UIColor clearColor ];
    [ _scanView addSubview :scanCropView];
    //右侧的view
    UIView *rightView = [[ UIView alloc ] initWithFrame : CGRectMake ( VIEW_WIDTH - SCANVIEW_EdgeLeft , SCANVIEW_EdgeTop , SCANVIEW_EdgeLeft , VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft )];
    rightView. alpha = TINTCOLOR_ALPHA ;
    rightView. backgroundColor = [ UIColor blackColor ];
    [ _scanView addSubview :rightView];
    //底部view
    UIView *downView = [[ UIView alloc ] initWithFrame : CGRectMake ( 0 , VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft + SCANVIEW_EdgeTop , VIEW_WIDTH , VIEW_HEIGHT -( VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft + SCANVIEW_EdgeTop ) )];
    //downView.alpha = TINTCOLOR_ALPHA;
    downView. backgroundColor = [[ UIColor blackColor ] colorWithAlphaComponent : TINTCOLOR_ALPHA ];
    [ _scanView addSubview :downView];
    //用于说明的label
    UILabel *labIntroudction= [[ UILabel alloc ] init ];
    labIntroudction. backgroundColor = [ UIColor clearColor ];
    labIntroudction. frame = CGRectMake ( 0 , 5 , VIEW_WIDTH , 20 );
    labIntroudction. numberOfLines = 1 ;
    labIntroudction. font =[ UIFont systemFontOfSize : 15.0 ];
    labIntroudction. textAlignment = NSTextAlignmentCenter ;
    labIntroudction. textColor =[ UIColor whiteColor ];
    labIntroudction. text = @"将二维码对准方框，即可自动扫描" ;
    [downView addSubview :labIntroudction];
    UIView *darkView = [[ UIView alloc ] initWithFrame : CGRectMake ( 0 , downView. frame . size . height - 100.0 , VIEW_WIDTH , 100.0 )];
    darkView. backgroundColor = [[ UIColor blackColor ]  colorWithAlphaComponent : DARKCOLOR_ALPHA ];
    [downView addSubview :darkView];
    //用于开关灯操作的button
    UIButton *openButton=[[ UIButton alloc ] initWithFrame : CGRectMake ( 10 , 10 , 300.0 , 30.0 )];
    [openButton setTitle : @"开启闪光灯" forState: UIControlStateNormal ];
    [openButton setTitleColor :[ UIColor whiteColor ] forState : UIControlStateNormal ];
    openButton.titleLabel.textAlignment = NSTextAlignmentCenter ;
    openButton.backgroundColor =[ UIColor greenColor ];
    openButton.titleLabel.font =[ UIFont systemFontOfSize : 22.0 ];
    [openButton addTarget : self action : @selector (openLight) forControlEvents : UIControlEventTouchUpInside ];
    [darkView addSubview :openButton];
    //用于关闭界面的button
    UIButton *closeButton=[[ UIButton alloc ] initWithFrame : CGRectMake ( 10 , 40 + 20 , 300.0 , 30.0 )];
    [closeButton setTitle : @"取消扫描" forState: UIControlStateNormal ];
    [closeButton setTitleColor :[ UIColor whiteColor ] forState : UIControlStateNormal ];
    closeButton.titleLabel.textAlignment = NSTextAlignmentCenter ;
    closeButton.backgroundColor =[ UIColor redColor];
    closeButton.titleLabel.font =[ UIFont systemFontOfSize : 22.0 ];
    [closeButton addTarget : self action : @selector (closeView) forControlEvents : UIControlEventTouchUpInside ];
    [darkView addSubview :closeButton];
    //画中间的基准线
    _QrCodeline = [[ UIView alloc ] initWithFrame : CGRectMake ( SCANVIEW_EdgeLeft , SCANVIEW_EdgeTop , VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft , 2 )];
    _QrCodeline . backgroundColor = [ UIColor greenColor ];
    [ _scanView addSubview : _QrCodeline ];
}
- ( void )openLight
{
    if ( _readerView . torchMode == 0 ) {
        _readerView . torchMode = 1 ;
    } else
    {
        _readerView . torchMode = 0 ;
    }
}

- (void)closeView
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- ( void )viewWillDisappear:( BOOL )animated
{
    [ super viewWillDisappear :animated];
    if ( _readerView . torchMode == 1 ) {
        _readerView . torchMode = 0 ;
    }
    [ self stopTimer ];
    [ _readerView stop ];
}
//二维码的横线移动
- ( void )moveUpAndDownLine
{
    CGFloat Y= _QrCodeline . frame . origin . y ;
    //CGRectMake(SCANVIEW_EdgeLeft, SCANVIEW_EdgeTop, VIEW_WIDTH-2*SCANVIEW_EdgeLeft, 1)]
    if (VIEW_WIDTH- 2 *SCANVIEW_EdgeLeft+SCANVIEW_EdgeTop==Y){
        [UIView beginAnimations: @"asa" context: nil ];
        [UIView setAnimationDuration: 1 ];
        _QrCodeline.frame=CGRectMake(SCANVIEW_EdgeLeft, SCANVIEW_EdgeTop, VIEW_WIDTH- 2 *SCANVIEW_EdgeLeft, 1 );
        [UIView commitAnimations];
    } else if (SCANVIEW_EdgeTop==Y){
        [UIView beginAnimations: @"asa" context: nil ];
        [UIView setAnimationDuration: 1 ];
        _QrCodeline.frame=CGRectMake(SCANVIEW_EdgeLeft, VIEW_WIDTH- 2 *SCANVIEW_EdgeLeft+SCANVIEW_EdgeTop, VIEW_WIDTH- 2 *SCANVIEW_EdgeLeft, 1 );
        [UIView commitAnimations];
    }
}
- ( void )createTimer
{
    //创建一个时间计数
    _timer=[NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector (moveUpAndDownLine) userInfo: nil repeats: YES ];
}
- ( void )stopTimer
{
    if ([_timer isValid] == YES ) {
        [_timer invalidate];
        _timer = nil ;
    }
}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self InitScan];
//    // Do any additional setup after loading the view.
//}
//
//#pragma mark 初始化扫描
//- (void)InitScan
//{
//    self.readerView = [ZBarReaderView new];
//    self.readerView.backgroundColor = [UIColor clearColor];
//    self.readerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    self.readerView.readerDelegate = self;
//    self.readerView.allowsPinchZoom = YES;//使用手势变焦
//    self.readerView.trackingColor = [UIColor redColor];
//    self.readerView.showsFPS = NO;// 显示帧率  YES 显示  NO 不显示
//    //readview.scanCrop = CGRectMake(0, 0, 1, 1);//将被扫描的图像的区域
//    
//    UIImage *hbImage=[UIImage imageNamed:@"pick_bg.png"];
//    _scanZomeBack=[[UIImageView alloc] initWithImage:hbImage];
//    //添加一个背景图片
//    CGRect mImagerect=CGRectMake((self.readerView.frame.size.width-200)/2.0, (self.readerView.frame.size.height-200)/2.0, 200, 200);
////    [scanZomeBack setFrame:mImagerect];
//    self.readerView.scanCrop = [self getScanCrop:mImagerect readerViewBounds:self.readerView.bounds];//将被扫描的图像的区域
//    
//    [self.readerView addSubview:_scanZomeBack];
//    [self.readerView addSubview:_readLineView];
//    [self.view addSubview:self.readerView];
//    [self.readerView start];
//    
//}
//
//#pragma mark 获取扫描区域
//-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
//{
//    CGFloat x,y,width,height;
//    
//    x = rect.origin.x / readerViewBounds.size.width;
//    y = rect.origin.y / readerViewBounds.size.height;
//    width = rect.size.width / readerViewBounds.size.width;
//    height = rect.size.height / readerViewBounds.size.height;
//    
//    return CGRectMake(x, y, width, height);
//}
//
//#pragma mark 扫描动画
//-(void)loopDrawLine
//{
//    CGRect  rect = CGRectMake(_scanZomeBack.frame.origin.x, _scanZomeBack.frame.origin.y, _scanZomeBack.frame.size.width, 2);
//    if (_readLineView) {
//        [_readLineView removeFromSuperview];
//    }
//    _readLineView = [[UIImageView alloc] initWithFrame:rect];
//    [_readLineView setImage:[UIImage imageNamed:@"line.png"]];
//    [UIView animateWithDuration:3.0
//                          delay: 0.0
//                        options: UIViewAnimationOptionCurveEaseIn
//                     animations:^{
//                         //修改fream的代码写在这里
//                         _readLineView.frame =CGRectMake(_scanZomeBack.frame.origin.x, _scanZomeBack.frame.origin.y+_scanZomeBack.frame.size.height, _scanZomeBack.frame.size.width, 2);
//                         [_readLineView setAnimationRepeatCount:0];
//                         
//                     }
//                     completion:^(BOOL finished){
////                         if (!is_Anmotion) {
//                         
//                             [self loopDrawLine];
////                         }
//                         
//                     }];
//    
//    [self.readerView addSubview:_readLineView];
//    
//}
//#pragma mark 获取扫描结果
//- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
//{
//    // 得到扫描的条码内容
//    const zbar_symbol_t *symbol = zbar_symbol_set_first_symbol(symbols.zbarSymbolSet);
//    NSString *symbolStr = [NSString stringWithUTF8String: zbar_symbol_get_data(symbol)];
//    if (zbar_symbol_get_type(symbol) == ZBAR_QRCODE) {
//        // 是否QR二维码
//    }
//    
//    for (ZBarSymbol *symbol in symbols) {
//        NSLog(@"%@",symbol.data);
//        break;
//    }
//    
//    [readerView stop];
//    [readerView removeFromSuperview];
//    
//    
//}



@end

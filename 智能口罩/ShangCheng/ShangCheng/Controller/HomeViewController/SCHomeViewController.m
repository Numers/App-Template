//
//  SCHomeViewController.m
//  ShangCheng
//
//  Created by baolicheng on 16/1/19.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "SCHomeViewController.h"
#import "UINavigationController+PHNavigationController.h"
#import "BluetoothManager.h"
#import "SCLocationHelper.h"
#import "SCHomeContainerView.h"

#import "SCMapViewController.h"
#import "SCNewsViewController.h"

#import "Whether.h"
#import "ZXAppStartManager.h"
#import "SCConfigHelper.h"
#import "SCIndexManager.h"

@interface SCHomeViewController ()<BluetoothManagerProtocol,UIScrollViewDelegate,SCHomeContainerViewProtocol>
{
    SCHomeContainerView *homeContainerView;
    
    float currentPmValue;
    float pmValue;
    float formaldeHyde;
    
    NSTimer *wheatherTimer;
    NSTimer *PMReportTimer;
    NSTimer *PMReadTimer;
}
@property(nonatomic,strong) UIScrollView *homeScrollView;
@end

@implementation SCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationViewColor:[UIColor colorWithRed:0.000 green:0.722 blue:0.933 alpha:1.000]];
    //设置背景效果
    UIImage * backgroundImg = [UIImage imageNamed:@"BackgroudImage"];
    self.view.layer.contents = (id) backgroundImg.CGImage;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Home_Location_Image"] style:UIBarButtonItemStylePlain target:self action:@selector(clickMapBtn)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    [self setNavigationRightItem:YES];
    
    [self.navigationItem setTitle:@"breathing"];
    
    CGFloat scrollViewHeight = UIScreenMainFrame.size.height - 44.0f - 64.0f;
    _homeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIScreenMainFrame.size.width, scrollViewHeight)];
    [_homeScrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_homeScrollView];
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SCHomeContainerView" owner:nil options:nil];
    homeContainerView =  (SCHomeContainerView *)[nibView objectAtIndex:0];
    homeContainerView.delegate = self;
    CGFloat containerViewHeight = MAX(460.0f, scrollViewHeight);
    [homeContainerView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, containerViewHeight + 1)];
    [homeContainerView initlizeView];
    [_homeScrollView addSubview:homeContainerView];
    NSLog(@"%lf",homeContainerView.frame.size.height);
    [_homeScrollView setContentSize:CGSizeMake(homeContainerView.frame.size.width, homeContainerView.frame.size.height)];
    
    pmValue = -1.0f;
    formaldeHyde = -1.0f;
    [self refreshData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWhetherInfo:) name:WhetherInfoUpdateNotify object:nil];
    [[SCLocationHelper defaultHelper] startLocationService];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configInfoCompletely:) name:ConfigReadCompletelyNotify object:nil];
    [[SCConfigHelper defaultHelper] requestConfigInfo];
//    
//    [breathCircleView beginLoading];
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC));
//    dispatch_after(time, dispatch_get_main_queue(), ^(void){
//        [breathCircleView endLoading];
//        [breathCircleView setProgress:80.0f WithAnimate:YES];
//    });
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setTranslucentView];
}

-(void)setNavigationRightItem:(BOOL)isCompelete
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"News_Image"] style:UIBarButtonItemStylePlain target:self action:@selector(clickNewsBtn)];
    [self.navigationItem setRightBarButtonItems:@[rightItem]];
//    if (isCompelete) {
//        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"News_Image"] style:UIBarButtonItemStylePlain target:self action:@selector(clickNewsBtn)];
//        [self.navigationItem setRightBarButtonItems:@[rightItem]];
//    }else{
//        UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:@"连接蓝牙" style:UIBarButtonItemStylePlain target:self action:@selector(clickScanBtn)];
//        [UIDevice adaptUIBarButtonItemTextFont:rightItem1 WithIphone5FontSize:12.0f];
//        UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"News_Image"] style:UIBarButtonItemStylePlain target:self action:@selector(clickNewsBtn)];
//        [self.navigationItem setRightBarButtonItems:@[rightItem2,rightItem1]];
//    }
}

-(void)updateWhetherInfo:(NSNotification *)notify
{
    id obj = [notify object];
    if ([obj isKindOfClass:[Whether class]]) {
        Whether *currentWhether = (Whether *)obj;
        if (homeContainerView) {
            [homeContainerView setWhetherIndex:currentWhether];
        }
    }
}

-(void)configInfoCompletely:(NSNotification *)notify
{
    float pmReportDuration = [[SCConfigHelper defaultHelper] returnPMReportDuration];
    [self performSelectorOnMainThread:@selector(reportWheatherInfoTimer:) withObject:[NSNumber numberWithFloat:pmReportDuration] waitUntilDone:NO];
    float pmReadDuration = [[SCConfigHelper defaultHelper] returnPMReadDuration];
    if (PMReadTimer) {
        if ([PMReadTimer isValid]) {
            [PMReadTimer invalidate];
        }
        PMReadTimer = nil;
    }
    
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:pmReadDuration];
    PMReadTimer = [[NSTimer alloc] initWithFireDate:fireDate interval:pmReadDuration target:self selector:@selector(getWheatherDataFromDevice) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:PMReadTimer forMode:NSDefaultRunLoopMode];
}

-(void)getWheatherDataFromDevice
{
    if ([[BluetoothManager defaultManager] isConnected]) {
        [[BluetoothManager defaultManager] writeCharacteristicWithCommand:RequestWheatherInfo];
    }
}

-(void)reportWheatherInfoTimer:(NSNumber *)duration
{
    if (PMReportTimer) {
        if ([PMReportTimer isValid]) {
            [PMReportTimer invalidate];
        }
        PMReportTimer = nil;
    }
    
    PMReportTimer = [NSTimer scheduledTimerWithTimeInterval:[duration floatValue] target:self selector:@selector(reportWheatherInfo) userInfo:nil repeats:YES];
    [PMReportTimer fire];
}

-(void)reportWheatherInfo
{
    Member *host = [[ZXAppStartManager defaultManager] currentHost];
    if (!host) {
        return;
    }
    
    Location *currentLocation = [[SCLocationHelper defaultHelper] returnCurrentLocation];
    if (!currentLocation) {
        return;
    }
    
    if (pmValue == -1.0f && formaldeHyde == -1.0f) {
        return;
    }
    [[SCIndexManager defaultManager] reportPMAndFormaldehydeWithMember:host WithLocation:currentLocation WithPMValue:pmValue WithFormaldehyde:formaldeHyde Success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } Error:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } Failed:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)refreshData
{
    if (homeContainerView) {
        [homeContainerView startLoadingData];
        [[BluetoothManager defaultManager] startBluetoothDevice:^(BOOL completely) {
            if (completely) {
                [self getWheatherDataFromDevice];
            }else{
                pmValue = -1.0f;
                formaldeHyde = -1.0f;
                if (homeContainerView) {
                    [homeContainerView endLoadingWithFailedType:UnConnected];
                }
            }
        }];
        [[BluetoothManager defaultManager] setBluetoothManagerDelegate:self];
    }
}

-(void)clickMapBtn
{
    NSString *pmValueStr = nil;
    if (pmValue == -1.0f) {
        pmValueStr = nil;
    }else{
        pmValueStr = [NSString stringWithFormat:@"%.0lf",pmValue];
    }
    SCMapViewController *scMapVC = [[SCMapViewController alloc] initWithDevicePMValue:pmValueStr];
    scMapVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scMapVC animated:YES];
}

-(void)clickNewsBtn
{
    SCNewsViewController *scNewsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsViewIdentify"];
    scNewsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scNewsVC animated:YES];
}

//-(void)clickScanBtn
//{
//    [self refreshData];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma -mark BluetoothManagerProtocol
-(void)deliveryData:(NSString *)data
{
    if (!data || data.length == 0) {
        [homeContainerView endLoadingWithFailedType:NoDataDevice];
        return;
    }
    if (homeContainerView) {
        NSArray *dataArr = [data componentsSeparatedByString:@","];
        if (dataArr && dataArr.count >=1) {
            NSString *codeStr = [dataArr objectAtIndex:0];
            if ([AppUtils isPureInt:codeStr]) {
                BluetoothCommand command = (BluetoothCommand)[codeStr intValue];
                switch (command) {
                    case RequestWheatherInfo:
                    {
                        if (dataArr.count >=3) {
                            NSString *valueStr1 = [dataArr objectAtIndex:1];
                            NSString *valueStr2 = [dataArr objectAtIndex:2];
                            if ([AppUtils isPureFloat:valueStr1] && [AppUtils isPureFloat:valueStr2]) {
                                pmValue = [valueStr1 floatValue];
                                [[NSNotificationCenter defaultCenter] postNotificationName:UserLocationPMValueChangeNotify object:[NSString stringWithFormat:@"%.0lf",pmValue]];
                                formaldeHyde = [valueStr2 floatValue];
                                [homeContainerView endLoadingWithData:pmValue WithFormaldeHyde:formaldeHyde];
                            }
                        }
                    }
                        break;
                    case RequestElectricPower:
                    {
                        
                    }
                        break;
                    default:
                        break;
                }
            }
        }
    }
}

#pragma -mark SCHomeContainerViewProtocol
-(void)goBuyView
{
    [[[ZXAppStartManager defaultManager] tabBarController] setSelectedIndex:1];
}

-(void)goBindView
{
    [[[ZXAppStartManager defaultManager] tabBarController] setSelectedIndex:2];
}

-(void)reConnect
{
    [self refreshData];
}

@end

//
//  ViewController.m
//  ShangCheng
//
//  Created by baolicheng on 15/12/24.
//  Copyright © 2015年 RenRenFenQi. All rights reserved.
//

#import "ViewController.h"
#import "SCViewWebJsBridge.h"
#import "LXActivity.h"
#import "ShareManage.h"
#import "AppUtils.h"

@interface ViewController ()<UIWebViewDelegate,SCViewWebJsBridgeDelegate,LXActivityDelegate>
{
    SCViewWebJsBridge *bridge;
}
@property(nonatomic, strong) IBOutlet UIWebView *webView;
@property(nonatomic, strong) IBOutlet UIButton *btnReload;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    bridge = [SCViewWebJsBridge bridgeForWebView:_webView webViewDelegate:self];
    bridge.delegate = self;
    [_btnReload.layer setCornerRadius:5.0f];
    [_btnReload.layer setMasksToBounds:YES];
    [_btnReload setHidden:YES];
    [_webView setHidden:NO];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0f];
    [_webView loadRequest:request];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showShareView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickReloadBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [_webView setHidden:NO];
    [btn setHidden:YES];
    [_webView reload];
}

#pragma -mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [AppUtils showProgressBarForView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [AppUtils hideProgressBarForView:self.view];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [AppUtils hideProgressBarForView:self.view];
    [webView setHidden:YES];
    [_btnReload setHidden:NO];
}

#pragma -mark SCViewWebJsBridgeDelegate
-(void)showShareView
{
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"推荐给好友" delegate:self cancelButtonTitle:nil ShareButtonTitles:@[@"微信",@"QQ空间",@"朋友圈"] withShareButtonImagesName:@[@"RFBody_wechat",@"RFBody_qzone",@"RFBody_friend"]];
    [lxActivity showInView:self.view];
}

#pragma -mark LxActivityDelegate
- (void)didClickOnImageIndex:(NSInteger *)imageIndex
{
    switch ((int)imageIndex) {
        case 0:
        {
            [[ShareManage GetInstance] shareVideoToWeixinPlatform:0 themeUrl:@"" thumbnail:[UIImage imageNamed:@"Icon.png"] title:@"5分钟不到，国众宝就送了我50元现金红包，   你也来试试呗！" descript:@""];
        }
            break;
            
        case 1:
        {
            [[ShareManage GetInstance] shareToQQZoneWithShareURL:@"" WithTitle:@"5分钟不到，国众宝就送了我50元现金红包，   你也来试试呗！" WithDescription:@"" WithPreviewImageUrl:@"Icon.png"];
        }
            break;
        case 2:
        {
            [[ShareManage GetInstance] shareVideoToWeixinPlatform:1 themeUrl:@"" thumbnail:[UIImage imageNamed:@"Icon.png"] title:@"5分钟不到，国众宝就送了我50元现金红包，   你也来试试呗！" descript:@""];
        }
            break;
            
        default:
            break;
    }
}
@end

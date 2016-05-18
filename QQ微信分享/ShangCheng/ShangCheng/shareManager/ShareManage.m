//
//  ShareManage.m
//  renrenfenqi
//
//  Created by DY on 15/1/12.
//  Copyright (c) 2015年 RenRenFenQi. All rights reserved.
//

#import "ShareManage.h"
#import "WXApi.h"
#import "sdkDef.h"
#import <TencentOpenAPI/TencentMessageObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "CommonTools.h"
@interface ShareManage()<WXApiDelegate>
{
    
}
@end
@implementation ShareManage

+ (ShareManage *) GetInstance {
    
    static ShareManage *instance = nil;
    @synchronized(self)
    {
        if (instance == nil) {
            instance = [[ShareManage alloc] init];
        }
    }
    return instance;
}

-(id)init
{
    self = [super init];
    if (self) {
        self.oauth = [[TencentOAuth alloc] initWithAppId:@"222222" andDelegate:self];
    }
    return self;
}

-(void)shareVideoToWeixinPlatform:(int)scene themeUrl:(NSString*)themeUrl thumbnail:(UIImage*)thumbnail title:(NSString*)title descript:(NSString*)descrip {
    
    NSData *thumbData = UIImageJPEGRepresentation(thumbnail,1);
    if ( [thumbData length]>=32*1024) {
        NSLog(@"分享缩略图大于32k");
        thumbnail = [CommonTools scaleToSize:thumbnail size:CGSizeMake(150, 150)];
    }
    
    if (![WXApi isWXAppInstalled]) {
        [AppUtils showInfo:@"你的iPhone 上还没有安装微信，无法使用此功能，使用微信可以方便的把你喜欢的作品分享给好友。"];
        return;
    }
    
    if (![WXApi isWXAppSupportApi]) {
        [AppUtils showInfo:@"你当前的微信版本过低，无法支持此功能，请更新微信至最新版本"];
        return;
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
    if (scene == 0) {
        message.title = [NSString stringWithFormat:@"%@",title];
    }
    
    if (scene == 1) {
        message.title = [NSString stringWithFormat:@"%@\n%@",title,descrip];
    }
    
    [message setThumbImage:thumbnail];
    message.description = descrip;
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = themeUrl;
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if(resp.errCode == 0){
            
        }else{
            [AppUtils showInfo:resp.errStr];
        }
    }
}

-(void)shareToQQZoneWithShareURL:(NSString *)shareUrl WithTitle:(NSString *)title WithDescription:(NSString *)desc WithPreviewImageUrl:(NSString *)preImageUrl
{
    NSURL* url = [NSURL URLWithString:shareUrl];
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:preImageUrl], 1.0f);
    QQApiNewsObject* imgObj = [QQApiNewsObject objectWithURL:url title:title description:desc previewImageData:imageData];
    
    [imgObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
    
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    
    [self handleSendResult:sent];
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPISENDSUCESS:
        {
            break;
        }
            
        case EQQAPIAPPNOTREGISTED:
        {
            [AppUtils showInfo:@"App未注册"];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            [AppUtils showInfo:@"发送参数错误"];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            [AppUtils showInfo:@"未安装手Q"];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            [AppUtils showInfo:@"API接口不支持"];
            break;
        }
        case EQQAPISENDFAILD:
        {
            [AppUtils showInfo:@"发送失败"];
            break;
        }
        default:
        {
            break;
        }
    }
}

- (void)tencentDidLogin
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessed object:self];
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFailed object:self];
}

- (void)tencentDidNotNetWork
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFailed object:self];
}

- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams
{
    return nil;
}

- (void)tencentDidLogout
{
    
}
@end

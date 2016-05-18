//
//  SCBindUncompleteStatusView.h
//  ShangCheng
//
//  Created by baolicheng on 16/1/28.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SCBingUncompleteStatusViewProtocol <NSObject>
-(void)goBind;
-(void)goBuy;
@end
@interface SCBindUncompleteStatusView : UIView
{
    UILabel *lblName;
    UIButton *btnBind;
    UIButton *btnBuy;
}
@property(nonatomic, assign) id<SCBingUncompleteStatusViewProtocol> delegate;
@end

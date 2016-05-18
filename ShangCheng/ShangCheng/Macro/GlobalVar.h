//
//  GlobalVar.h
//  renrenfenqi
//
//  Created by baolicheng on 15/6/29.
//  Copyright (c) 2015年 RenRenFenQi. All rights reserved.
//

#ifndef renrenfenqi_GlobalVar_h
#define renrenfenqi_GlobalVar_h
/**
 *  APP内模块相关宏
 */
#pragma mark - 本地数据存储
/**
 *  推送API
 */
//////////////////////////////////////////////////////////
#define ZX_Push_API @"/v1/push/tag"
/////////////////////////////////////////////////////////

/**
 *  登录模块API
 */
//////////////////////////////////////////////////////////
#define ZX_Login_API @"/v1/user/login"
#define ZX_ValidateCode_API @"/v1/user/getcode"
/////////////////////////////////////////////////////////

/**
 *  首页API
 */
//////////////////////////////////////////////////////////
#define ZX_Index_API @"/v1/user/center"
/////////////////////////////////////////////////////////

/**
 *  我的API
 */
//////////////////////////////////////////////////////////
#define ZX_Mine_API @"/v1/user/mine"
#define ZX_LoginOut_API @"/v1/user/logout"
/////////////////////////////////////////////////////////

/**
 *  提现API
 */
//////////////////////////////////////////////////////////
#define ZX_Withdraw_API @"/v1/user/withdraw"
#define ZX_WithdrawInfo_API @"/v1/user/withdraw_info"
/////////////////////////////////////////////////////////

/**
 *  账单详情API
 */
//////////////////////////////////////////////////////////
#define ZX_AmountDetails_API @"/v1/user/bill"
/////////////////////////////////////////////////////////

/**
 *  工资记录API
 */
//////////////////////////////////////////////////////////
#define ZX_SalaryList_API @"/v1/user/salary"
#define ZX_LatestSalary_API @"/v1/user/last_salary"
/////////////////////////////////////////////////////////
#endif


//
//  SCHomeViewController.m
//  ShangCheng
//
//  Created by baolicheng on 16/1/19.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "SCHomeViewController.h"
#import "BluetoothManager.h"
#import "SCLocationHelper.h"

@interface SCHomeViewController ()<BluetoothManagerProtocol>

@end

@implementation SCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWhetherInfo) name:LocationAndWhetherInfoUpdateNotify object:nil];
    [[SCLocationHelper defaultHelper] startLocationService];
}

-(void)updateWhetherInfo
{
    
}

-(IBAction)clickStartBtn:(id)sender
{
    [[BluetoothManager defaultManager] startBluetoothDevice:^(BOOL completely) {
        if (completely) {
            [[BluetoothManager defaultManager] writeCharacteristicWithCommand:RequestWheatherInfo];
        }
    }];
    [[BluetoothManager defaultManager] setBluetoothManagerDelegate:self];
}

-(IBAction)clickFirstBtn:(id)sender
{
    [[BluetoothManager defaultManager] writeCharacteristicWithCommand:RequestWheatherInfo];
}

-(IBAction)clickSecondBtn:(id)sender
{
    [[BluetoothManager defaultManager] writeCharacteristicWithCommand:RequestBindOperation];
}

-(IBAction)clickThirdBtn:(id)sender
{
    [[BluetoothManager defaultManager] writeCharacteristicWithCommand:RequestUnbindOperation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark BluetoothManagerProtocol
-(void)deliveryData:(NSString *)data
{
    [AppUtils showInfo:data];
}
@end

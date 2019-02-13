//
//  YSViewController.m
//  YSHttpManager
//
//  Created by chuqingr on 02/13/2019.
//  Copyright (c) 2019 chuqingr. All rights reserved.
//

#import "YSViewController.h"
#import <YSHttpManagerHeader.h>

@interface YSViewController ()

@end

@implementation YSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    YSHttpConfigure.shareInstance.generalParameters = @{};
    YSHttpConfigure.shareInstance.isDebug = true;

    [YSHttpManager.shareManager sendRequestWithConfigBlock:^(YSHttpRequest * _Nullable request) {
        request.baseURL = @"";
        request.requestURL = @"";
        request.requestHeader = @{};
        request.baseURL = @"";

    } complete:^(YSHttpResponse * _Nullable response) {

    }];

    YSHttpRequest *request = [YSHttpRequest new];
    [YSHttpManager.shareManager sendRequest:request complete:^(YSHttpResponse * _Nullable response) {

    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

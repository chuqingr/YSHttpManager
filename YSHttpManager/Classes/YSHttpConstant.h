//
//  YSHttpConstant.h
//  YSHttpManager
//
//  Created by Yshao_Mac on 2019/2/13.
//

#ifndef YSHttpConstant_h
#define YSHttpConstant_h

#import "YSHResponseInterceptorProtocol.h"
#import "YSHRequestInterceptorProtocol.h"

@class YSHttpResponse,YSHttpRequest;

typedef NS_ENUM (NSUInteger, YSHttpRequestType){
    YSHttpRequestTypeGet = 0,
    YSHttpRequestTypeDelete,
    YSHttpRequestTypePut,
    YSHttpRequestTypePost,
    YSHttpRequestTypePatch
};

typedef NS_ENUM (NSUInteger, YSHttpResponseStatus){
    YSHttpResponseStatusSuccess = 0,
    YSHttpResponseStatusError
};

/// 响应配置 Block
typedef void (^YSHttpResponseBlock)(YSHttpResponse * _Nullable response);
//typedef void (^HKGroupResponseBlock)(NSArray<HKHttpResponse *> * _Nullable responseObjects, BOOL isSuccess);
//typedef void (^HKNextBlock)(HKHttpRequest * _Nullable request, HKHttpResponse * _Nullable responseObject, BOOL * _Nullable isSent);

/// 请求配置 Block
typedef void (^YSHRequestConfigBlock)(YSHttpRequest * _Nullable request);

//typedef void (^HKGroupRequestConfigBlock)(HKHttpGroupRequest * _Nullable groupRequest);

//typedef void (^HKChainRequestConfigBlock)(HKHttpChainRequest * _Nullable chainRequest);


#endif /* YSHttpConstant_h */

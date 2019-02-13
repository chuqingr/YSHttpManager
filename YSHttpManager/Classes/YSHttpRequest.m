//
//  YSHttpRequest.m
//  Pods-YSHttpManager_Example
//
//  Created by Yshao_Mac on 2019/2/11.
//

#import "YSHttpRequest.h"
#import "YSHttpConfigure.h"

@implementation YSHttpRequest
- (instancetype)init {
    self = [super init];
    if (self) {
        _requestMethod = YSHttpRequestTypePost;
        _reqeustTimeoutInterval = 30.0;
        _encryptParams = @{};
        _normalParams = @{};
        _requestHeader = @{};
        _retryCount = 0;
        _apiVersion = @"1.0";

    }
    return self;
}

/**
 生成请求

 @return NSURLRequest
 */
- (NSURLRequest *)generateRequest{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = self.reqeustTimeoutInterval;
//    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
//    serializer.timeoutInterval = [self reqeustTimeoutInterval];
//    serializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;

    NSString *urlStr = [self.baseURL stringByAppendingString:self.requestURL];

//    /// 是否是测试环境
//    if (YSHttpConfigure.shareInstance.enableTest)
//    {
//        [request setValue:@"crawltest"forHTTPHeaderField:@"PARAMS-PARTNER-CODE"];
//        [request setValue:@"crawltest"forHTTPHeaderField:@"PARAMS-EVENT-ID"];
//    }

    NSDictionary *param = YSHttpConfigure.shareInstance.generalParameters;
    /// GET = 0 | DELETE = 1
    if (self.requestMethod < 2) {
        NSArray *allKeys = param.allKeys;
        for (int i = 0; i < allKeys.count; i ++) {
            NSString *string;
            /// 包含 ？
            if ([urlStr containsString:@"?"]) {
                string = [NSString stringWithFormat:@"&%@=%@",allKeys[i],param[allKeys[i]]];
            }else {
                string = [NSString stringWithFormat:@"?%@=%@",allKeys[i],param[allKeys[i]]];
            }
            urlStr = [urlStr stringByAppendingString:string];
        }

    }
//    else {

//        [request setValue:self.apiVersion forHTTPHeaderField:@"App-Version"];
//        [request setValue:@"iOS"forHTTPHeaderField:@"Device-Type"];
//        [request setValue:@"application/x-www-form-urlencoded"forHTTPHeaderField:@"Content-Type"];
//    }

    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = [self httpMethod];
    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    /// 非GET DELETE
    if (self.requestMethod >= 2) {
        if (param) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
            request.HTTPBody = data;
        }
    }
//    NSMutableURLRequest *request = [serializer requestWithMethod:[self httpMethod] URLString:[self.baseURL stringByAppendingString:self.requestURL] parameters:[self generateRequestBody] error:NULL];
    // 请求头
    request.allHTTPHeaderFields = self.requestHeader;
    NSMutableDictionary *header = request.allHTTPHeaderFields.mutableCopy;
    if (!header)
    {
        header = [[NSMutableDictionary alloc] init];
    }
    [header addEntriesFromDictionary:[YSHttpConfigure shareInstance].generalHeaders];
    request.allHTTPHeaderFields = header;

    return request.copy;
}

/**
 公共请求参数

 @return 请求参数字典
 */
- (NSDictionary *)generateRequestBody{
    NSDictionary *commonDic = [YSHttpConfigure shareInstance].generalParameters;
    //    NSMutableDictionary *encryptDict = @{}.mutableCopy;
    //    NSAssert(self.requestPath.length > 0, @"请求 Path 不能为空");
    //    encryptDict[@"uri"] = self.requestPath;
    //    [encryptDict addEntriesFromDictionary:commonDic];
    //    [encryptDict addEntriesFromDictionary:self.encryptParams];
    //
    //    NSMutableDictionary *rslt = @{}.mutableCopy;
    //    [rslt addEntriesFromDictionary:self.normalParams];
//#warning 这里要看后台怎么设置
    //    rslt[@"params2"] = [[encryptDict toJsonString] base64EncodedString];


    //    NSLog(@"%@", encryptDict);
    return commonDic;
}
- (NSString *)httpMethod{
    YSHttpRequestType type = [self requestMethod];
    switch (type)
    {
        case YSHttpRequestTypePost:
            return @"POST";
        case YSHttpRequestTypeGet:
            return @"GET";
        case YSHttpRequestTypePut:
            return @"PUT";
        case YSHttpRequestTypeDelete:
            return @"DELETE";
        case YSHttpRequestTypePatch:
            return @"PATCH";
        default:
            break;
    }
    return @"GET";
}

- (NSString *)baseURL{
    if (!_baseURL) {
        _baseURL = [YSHttpConfigure shareInstance].generalServer;
    }
    return _baseURL;
}
- (void)dealloc {
    if ([YSHttpConfigure shareInstance].isDebug) {
        NSLog(@"dealloc: %@", ([self class]));
    }
}
@end

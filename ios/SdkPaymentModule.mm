#import "SdkPaymentModule.h"
#import "SdkPaymentModule-Swift.h"

@implementation SdkPaymentModule {
  SdkPaymentModuleImpl *moduleImpl;
}

-(instancetype) init {
  self = [super init];
  if (self) {
    moduleImpl = [SdkPaymentModuleImpl new];
  }
  
  return self;
}

RCT_EXPORT_MODULE()

- (NSNumber *) getFormTokenVersion{
  return [moduleImpl getFormTokenVersion];
}

-(void)initialize:(NSString *)publicKey options:(NSDictionary *)options onError:(RCTResponseSenderBlock)onError{
  [moduleImpl initialize:publicKey options: options onError:^{
    onError(@[@"errorFromInit"]);
  }];
}

-(void)process:(NSString *)formToken options:(NSDictionary *)options onSuccess:(RCTResponseSenderBlock)onSuccess onError:(RCTResponseSenderBlock)onError{
  [moduleImpl processWithFormToken:formToken options:options onSuccess:^{
    onSuccess(@[@"successReturned"]);
  } onError:^{
    onError(@[@"errorReturned"]);
  }];
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeSdkPaymentModuleSpecJSI>(params);
}

@end

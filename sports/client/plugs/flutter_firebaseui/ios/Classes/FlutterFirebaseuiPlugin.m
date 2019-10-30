#import "FlutterFirebaseuiPlugin.h"
#import <flutter_firebaseui/flutter_firebaseui-Swift.h>

@implementation FlutterFirebaseuiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterFirebaseuiPlugin registerWithRegistrar:registrar];
}
@end

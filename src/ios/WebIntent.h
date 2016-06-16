#import <Cordova/CDV.h>

#ifdef DEBUG
#   define WILog(...) NSLog(__VA_ARGS__)
#else
#   define WILog(...)
#endif

@interface WebIntent : CDVPlugin

- (void)startActivity:(CDVInvokedUrlCommand*)command;
- (void)hasExtra:(CDVInvokedUrlCommand*)command;
- (void)getExtra:(CDVInvokedUrlCommand*)command;
- (void)getUri:(CDVInvokedUrlCommand*)command;
- (void)onNewIntent:(CDVInvokedUrlCommand*)command;
- (void)sendBroadcast:(CDVInvokedUrlCommand*)command;

- (BOOL)handleUrl:(NSURL* _Nonnull)url;
- (BOOL)handleContinueUserActivity:(NSUserActivity* _Nonnull)userActivity;

@end

@interface NSURL (Stringify)

- (NSString*)stringify;

@end

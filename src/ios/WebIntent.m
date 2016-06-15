#import "WebIntent.h"

@implementation WebIntent

NSString * const kWebIntentLoggerTag = @"[WebIntent]";
NSString * onOpenUrlCallbackId = nil;

- (void)pluginInitialize
{
    WILog(@"%@[pluginInitialize]", kWebIntentLoggerTag);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPause) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onResume) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)onReset
{
    WILog(@"%@[onReset]", kWebIntentLoggerTag);
    onOpenUrlCallbackId = nil; // Javascript was reloaded, so need to re-register callback
}

- (void)dispose
{
    WILog(@"%@[pluginInitialize]", kWebIntentLoggerTag);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)startActivity:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
        WILog(@"%@[startActivity] sending plugin result for command: %@", kWebIntentLoggerTag, pluginResult.description);
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)hasExtra:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
        WILog(@"%@[hasExtra] sending plugin result for command: %@", kWebIntentLoggerTag, pluginResult.description);
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)getExtra:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
        WILog(@"%@[getExtra] sending plugin result for command: %@", kWebIntentLoggerTag, pluginResult.description);
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)getUri:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
        WILog(@"%@[getUri] sending plugin result for command: %@", kWebIntentLoggerTag, pluginResult.description);
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)onNewIntent:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;

        if ([command.arguments count] != 0) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_INVALID_ACTION];
            WILog(@"%@[onNewIntent] sending INVALID_ACTION plugin result for command: %@", kWebIntentLoggerTag, pluginResult.description);
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            return;
        }

        WILog(@"%@[onNewIntent] storing command", kWebIntentLoggerTag);
        onOpenUrlCallbackId = command.callbackId; // Save reference to callbackId, will be called on "newIntent" events

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
        pluginResult.keepCallback = @YES;

        WILog(@"%@[onNewIntent] sending plugin result for command: %@", kWebIntentLoggerTag, pluginResult.description);
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)sendBroadcast:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
        WILog(@"%@[sendBroadcast] sending plugin result for command: %@", kWebIntentLoggerTag, pluginResult.description);
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)handleOpenURL:(NSNotification *)notification
{
    WILog(@"%@[handleOpenURL] with notification: %@", kWebIntentLoggerTag, notification.description);
    NSURL* url = [notification object];
    CDVPluginResult *pluginResult = nil;

    if ([url isKindOfClass:[NSURL class]]) {
        if (onOpenUrlCallbackId != nil && [onOpenUrlCallbackId length] > 0) {
            // awesome, we have a callback to launch!

            NSString *fullUrl = [NSString stringWithFormat:@"%@:%@", url.scheme, url.resourceSpecifier];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:fullUrl];
            pluginResult.keepCallback = @YES;
            WILog(@"%@[handleOpenURL] sending OK plugin result for event: %@", kWebIntentLoggerTag, pluginResult.description);
            [self.commandDelegate sendPluginResult:pluginResult callbackId:onOpenUrlCallbackId];
        }
        else WILog(@"%@[handleOpenURL] no callback registered", kWebIntentLoggerTag);
    }
    else WILog(@"%@[handleOpenURL] received something else than an URL", kWebIntentLoggerTag);
}

- (void)onResume {
    WILog(@"%@[onResume]", kWebIntentLoggerTag);
}

- (void)onPause {
    WILog(@"%@[onPause]", kWebIntentLoggerTag);
}

@end

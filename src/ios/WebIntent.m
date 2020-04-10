#import "WebIntent.h"

@implementation WebIntent

NSString * const kWebIntentLoggerTag = @"[WebIntent]";
NSString * onOpenUrlCallbackId = nil;
NSURL * pendingUrl = nil;

#pragma mark - Plugin lifecycle

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

    onOpenUrlCallbackId = nil;
    pendingUrl = nil;
}

#pragma mark - Plugin commands

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

        if (pendingUrl != nil) pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[pendingUrl stringify]];
        else pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

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

#pragma mark - Helpers

- (BOOL)handleUrl:(NSURL* _Nonnull)url
{
    pendingUrl = url;

    // In case js didn't register to onNewIntent handler yet, we store url for later use...
    if (onOpenUrlCallbackId == nil || [onOpenUrlCallbackId length] < 1) {

        WILog(@"%@[sendUrlToJs] no callback registered, storing url...", kWebIntentLoggerTag);
        return YES;
    }

    // awesome, we have a callback to launch!

    CDVPluginResult *pluginResult = nil;

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[url stringify]];
    pluginResult.keepCallback = @YES;

    WILog(@"%@[sendUrlToJs] sending OK plugin result for event: %@", kWebIntentLoggerTag, pluginResult.description);
    [self.commandDelegate sendPluginResult:pluginResult callbackId:onOpenUrlCallbackId];
    return YES;
}

- (BOOL)handleContinueUserActivity:(NSUserActivity* _Nonnull)userActivity {
    return YES;
}

#pragma mark - Application lifecycle event handlers

- (void)onResume
{
    WILog(@"%@[onResume]", kWebIntentLoggerTag);
}

- (void)onPause
{
    WILog(@"%@[onPause]", kWebIntentLoggerTag);
    pendingUrl = nil;
}

- (void)handleOpenURL:(NSNotification *)notification{
    NSURL* url = notification.object;
    [self handleUrl:url];
}

@end

@implementation NSURL (Stringify)

- (NSString*)stringify {
    return [NSString stringWithFormat:@"%@:%@", self.scheme, self.resourceSpecifier];
}

@end

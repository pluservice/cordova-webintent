#import "WebIntent.h"

@implementation WebIntent

- (void)startActivity:(CDVInvokedUrlCommand*)command
{
  CDVPluginResult* pluginResult = nil;
  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)hasExtra:(CDVInvokedUrlCommand*)command
{
  CDVPluginResult* pluginResult = nil;
  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getExtra:(CDVInvokedUrlCommand*)command
{
  CDVPluginResult* pluginResult = nil;
  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getUri:(CDVInvokedUrlCommand*)command
{
  CDVPluginResult* pluginResult = nil;
  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)onNewIntent:(CDVInvokedUrlCommand*)command
{
  CDVPluginResult* pluginResult = nil;
  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)sendBroadcast:(CDVInvokedUrlCommand*)command
{
  CDVPluginResult* pluginResult = nil;
  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end

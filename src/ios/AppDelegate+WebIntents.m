//
//  AppDelegate+WebIntents.m
//  TIM Mobility
//
//  Created by MacBookProSviluppo on 16/06/16.
//
//

#import "AppDelegate+WebIntents.h"
#import "WebIntent.h"

static NSString *const PLUGIN_NAME = @"WebIntent";

@implementation AppDelegate (WebIntents)

// - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
// {
//     WebIntent *plugin = [self.viewController getCommandInstance:PLUGIN_NAME];
    
//     if(plugin == nil) {
//         NSLog(@"Unable to get instance of command plugin");
//         return NO;
//     }
    
//     BOOL handled = [plugin handleUrl:url];
    
//     if(!handled) {
//         // Pass event through to Cordova
//         [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:CDVPluginHandleOpenURLNotification object:url]];
//     }
    
//     return YES;
// }

// - (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *restorableObjects))restorationHandler
// {
//     // Pass it off to our plugin
//     WebIntent *plugin = [self.viewController getCommandInstance:PLUGIN_NAME];
    
//     if(plugin == nil) {
//         return NO;
//     }
    
//     BOOL handled = [plugin handleContinueUserActivity:userActivity];
    
//     if(!handled) {
//         // Continue sending the openURL request through
//     }
//     return YES;
// }

@end

//
//  AppDelegate+WebIntents.h
//  TIM Mobility
//
//  Created by MacBookProSviluppo on 16/06/16.
//
//

#import "AppDelegate.h"

/**
 *  Category for the AppDelegate that overrides application:continueUserActivity:restorationHandler method,
 *  so we could handle application launch when user clicks on the link in the browser.
 */

@interface AppDelegate (WebIntents)

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler;

@end

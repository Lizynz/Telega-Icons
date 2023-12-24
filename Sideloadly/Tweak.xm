#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <TelegaIcons-Swift.h>

%hook AppDelegate
- (void)application:(id)arg1 performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(id)arg3 {
    %orig;

    if([shortcutItem.type isEqualToString:@"savedMessages"]) {
        AlertPresenter *alertPresenter = [[AlertPresenter alloc] init];
        [alertPresenter presentAlert];
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return YES;
}

%end

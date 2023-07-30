#import <substrate.h>

static const NSBundle *tweakBundle = [NSBundle bundleWithPath:@"/Library/Application Support/Telega/Localizations.bundle"];
#define LOCALIZED(str) [tweakBundle localizedStringForKey:str value:@"" table:nil]

@interface SBIconView : NSObject
- (NSString*)applicationBundleIdentifier;
- (NSString*)applicationBundleIdentifierForShortcuts;
@end

@interface SBSApplicationShortcutIcon : NSObject
@end

@interface SBSApplicationShortcutItem : NSObject
@property (nonatomic, copy) SBSApplicationShortcutIcon *icon;
- (void)setLocalizedTitle:(id)arg1;
- (void)setType:(id)arg1;
@end

@interface SBSApplicationShortcutSystemIcon : SBSApplicationShortcutIcon //Icon
- (id)initWithSystemImageName:(id)arg1;
@end

@interface SBSApplicationShortcutCustomImageIcon : SBSApplicationShortcutIcon //Icon
@property (nonatomic, readonly, retain) NSData *imagePNGData;
-(instancetype)initWithImagePNGData:(NSData *)imageData;
@end

%hook SBIconView
- (NSArray *)applicationShortcutItems {
    if ([self.applicationBundleIdentifierForShortcuts isEqualToString:@"ph.telegra.Telegraph"]) {
        NSArray *applicationShortcutItems = %orig;
        NSMutableArray *mutableItems = [NSMutableArray arrayWithArray:applicationShortcutItems];
        
        SBSApplicationShortcutItem *groupShortcut = [[SBSApplicationShortcutItem alloc] init];
        [groupShortcut setLocalizedTitle:LOCALIZED(@"icons")];
        [groupShortcut setType:@"iconsChange"];
        groupShortcut.icon = [[%c(SBSApplicationShortcutSystemIcon) alloc] initWithSystemImageName:@"sparkles.rectangle.stack"];
        [mutableItems addObject:groupShortcut];
        
        return mutableItems;
    }
    return %orig;
}

%end

%hook AppDelegate
- (void)application:(id)arg1 performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(id)arg3 {
    %orig;
    if([shortcutItem.type isEqualToString:@"iconsChange"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOCALIZED(@"Change Icons")
                    message:LOCALIZED(@"Choose one of three premium icons for Telegram")
                    delegate:self
                    cancelButtonTitle:LOCALIZED(@"Cancel")
                    otherButtonTitles:@"Premium.png", @"Turbo.png", @"Black.png", nil];
                
            [alert show];
        });
    }
}

%new
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *button = [alertView buttonTitleAtIndex:buttonIndex];
    if ([button isEqualToString:@"Premium.png"]) {
        [[UIApplication sharedApplication] setAlternateIconName:@"Premium" completionHandler:^(NSError * _Nullable error) {
            if (error == nil) {
            }else{
            }
        }];

    } else if ([button isEqualToString:@"Turbo.png"]) {
        [[UIApplication sharedApplication] setAlternateIconName:@"PremiumTurbo" completionHandler:^(NSError * _Nullable error) {
            if (error == nil) {
            }else{
            }
        }];

    } else if ([button isEqualToString:@"Black.png"]) {
        [[UIApplication sharedApplication] setAlternateIconName:@"PremiumBlack" completionHandler:^(NSError * _Nullable error) {
            if (error == nil) {
            }else{
            }
        }];
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return YES;
}

%end

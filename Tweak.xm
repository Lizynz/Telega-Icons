#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TelegaIcons-Swift.h>
#import <substrate.h>

static const NSBundle *tweakBundle = [NSBundle bundleWithPath:@"/var/jb/Library/Application Support/Telega/Localizations.bundle"];
#define LOCALIZED(str) [tweakBundle localizedStringForKey:str value:@"" table:nil]

//static const NSBundle *tweakBundle = [NSBundle bundleWithPath:@"/Library/Application Support/Telega/Localizations.bundle"];
//#define LOCALIZED(str) [tweakBundle localizedStringForKey:str value:@"" table:nil]

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
        AlertPresenter *alertPresenter = [[AlertPresenter alloc] init];
        [alertPresenter presentAlert];
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return YES;
}

%end

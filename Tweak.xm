#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#include <roothide.h>

#import <TelegaIcons-Swift.h>
#import <substrate.h>

//#define LANG_PATH jbroot(@"/Library/Application Support/Telega/Localizations.bundle")
//
//static const NSBundle *tweakBundle = [NSBundle bundleWithPath:LANG_PATH];
//#define LOCALIZED(str) [tweakBundle localizedStringForKey:str value:@"" table:nil]

@interface _TtC10SettingsUIP33_5F93AE0C6B00898257FB43B00D4008CB24ThemeSettingsAppIconNode : UIView
- (void)didLoad;
@end

%hook _TtC10SettingsUIP33_5F93AE0C6B00898257FB43B00D4008CB24ThemeSettingsAppIconNode
- (void)didLoad {
    %orig;
    
    AlertPresenter *alertPresenter = [[AlertPresenter alloc] init];
    [alertPresenter presentAlert];
}

%end

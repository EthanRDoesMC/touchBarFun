//
//  WC.m
//  touchBarFun
//
//  Created by Ethan Chaffin on 10/28/21.
//

#import "AppDelegate.h"
#import "WC.h"
#import "NSPopoverTouchBarItem+NSTouchBarItemMagic.h"
#import "SubmenuTouchBar.h"
#import "NSMenuButton.h"
#import "DFRPrivate/include/DFRPrivate.h"
#import "StatusBarItemManager.h"
#import <ScriptingBridge/ScriptingBridge.h>
#import "System Events.h"
#import <ApplicationServices/ApplicationServices.h>
#import "UIAccess.h"
#import "ExternalMB.h"
#import "ViewController.h"
#import "NSTouchBarExtra.h"

@interface WC ()
-(void)showSubmenuWithIdentifier:(NSTouchBarItemIdentifier)identifier;

@end

@interface NSMenu ()
+(id)_currentTrackingInfo;
@end

@implementation WC

-(void)swapTouchBars:(id)sender {
    NSMenuButton * button = sender;
    NSRunningApplication *menuApp = nil;
    menuApp = [[NSWorkspace sharedWorkspace] menuBarOwningApplication];
    ExternalMB * subMenuBar = [[ExternalMB alloc] initWithMenuItem:button.externalItem];
    [subMenuBar presentAsSystemModalForItemIdentifier:button.externalItem.name placement:false];
}

-(void)dismiss:(id)sender {
    [[NSTouchBar new] minimizeSystemModal];
}

-(void)refreshTouchBar {
    [[NSTouchBar new] minimizeSystemModal];
    [((ViewController *)self.contentViewController).largeLabel setStringValue:@"please wait"];
    NSRunningApplication *menuApp = nil;
    menuApp = [[NSWorkspace sharedWorkspace] menuBarOwningApplication];
    [((ViewController *)self.contentViewController).AppIcon setImage:menuApp.icon];
    [((ViewController *)self.contentViewController).AppIcon setTitle:[NSString stringWithFormat:@" %@",menuApp.localizedName]];

    if (![menuApp.bundleIdentifier isEqualToString:_currentAppBID]) {

        //[_blankTB presentAsSystemModalForItemIdentifier:@"blank" placement:true];
        [NSTouchBar minimizeSystemModalTouchBar:self.touchBar?:[NSTouchBar new]];
        self.touchBar = self.makeTouchBar;
        [self.touchBar minimizeSystemModal];
        [self.makeTouchBar presentAsSystemModalForItemIdentifier:@"com.ethanrdoesmc.touchbarfun" placement:false];
    }
    _currentAppBID = menuApp.bundleIdentifier;
    [AppDelegate buildMenu];
    
    [((ViewController *)self.contentViewController).progress stopAnimation:nil];
    [((ViewController *)self.contentViewController).largeLabel setStringValue:@"loaded the menu bar for"];
}

-(void)presentTouchBar {
    [self.touchBar presentAsSystemModalForItemIdentifier:@"com.ethanrdoesmc.touchbarfun" placement:false];
}
- (void)windowDidLoad {

    [NSTouchBar setSystemModalShowsCloseBoxWhenFrontMost:true];
    _menuBarItem = [[NSCustomTouchBarItem alloc] initWithIdentifier:@"com.ethanrdoesmc.touchbarfun"];
    _menuBarItem.view = [NSButton buttonWithImage:[NSImage imageWithSystemSymbolName:@"filemenu.and.selection" accessibilityDescription:nil] target:self action:@selector(presentTouchBar)];
    [NSTouchBarItem addSystemTrayItem:_menuBarItem];
    [_menuBarItem setControlStripPresence:true];

    [super windowDidLoad];

    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                           selector:@selector(refreshTouchBar)
                                                               name:NSWorkspaceDidActivateApplicationNotification object:nil];
}

- (NSTouchBarItem *)touchBar:(NSTouchBar *)touchBar makeItemForIdentifier:(NSTouchBarItemIdentifier)identifier {
    [NSTouchBar dismissSystemModalTouchBar:touchBar];
    NSRunningApplication *menuApp = nil;
    menuApp = [[NSWorkspace sharedWorkspace] menuBarOwningApplication];
    UIAccess *ui = [UIAccess new];
    NSArray *menu = [ui getAppMenu:menuApp];
    if ([identifier isEqualToString:@"hidebutton"]) {
        NSCustomTouchBarItem * tbi = [[NSCustomTouchBarItem alloc] initWithIdentifier:identifier];
        NSButton * button = [NSButton buttonWithTitle:@"" target:touchBar action:@selector(minimizeSystemModal)];
        button.image = [NSImage imageWithSystemSymbolName:@"chevron.right" accessibilityDescription:nil];
        button.bordered = false;

        tbi.view = button;
        //[tbi addToSystemTray];
        return tbi;
    }

    for (MenuItem * item in menu) {
        //NSLog(@"identifier: %@ | title: %@", identifier, item.name);
        if ([item.name isEqualToString:identifier]) {
            if (item.children) {
                if ([identifier isEqualToString:@"Apple"]) {
                    NSCustomTouchBarItem * tbi = [[NSCustomTouchBarItem alloc] initWithIdentifier:identifier];
                    //NSMenuButton * button = [NSMenuButton buttonWithTitle:item.title target:self action:@selector(dismiss:) item:item];
                    NSMenuButton * button = [NSMenuButton buttonWithTitle:@"" target:self action:@selector(swapTouchBars:) externalItem:item];
                    button.image = [NSImage imageWithSystemSymbolName:@"applelogo" accessibilityDescription:nil];
                    button.bordered = true;
                    button.showsBorderOnlyWhileMouseInside = false;
                    tbi.view = button;
                    //[tbi addToSystemTray];
                    return tbi;
                }
                if ([identifier isEqualToString:menuApp.localizedName]) {
                    NSCustomTouchBarItem * tbi = [[NSCustomTouchBarItem alloc] initWithIdentifier:identifier];
                    //NSMenuButton * button = [NSMenuButton buttonWithTitle:item.title target:self action:@selector(dismiss:) item:item];
                    NSMenuButton * button = [NSMenuButton buttonWithTitle:item.name target:self action:@selector(swapTouchBars:) externalItem:item];
                    button.font = [NSFont boldSystemFontOfSize:(button.font.pointSize + 3)];
                    //button.image = menuApp.icon;
                    button.bordered = true;
                    button.imagePosition = NSImageLeading;
                    button.imageHugsTitle = true;
                    tbi.view = button;
                    return tbi;
                }
                NSCustomTouchBarItem * tbi = [[NSCustomTouchBarItem alloc] initWithIdentifier:identifier];
                NSMenuButton * button = [NSMenuButton buttonWithTitle:item.name target:self action:@selector(swapTouchBars:) externalItem:item];
                if ([item.name isEqualToString:menuApp.localizedName]) {
                    //button.contentTintColor = [NSColor whiteColor];
                    button.font = [NSFont boldSystemFontOfSize:(button.font.pointSize + 2)];
                } else {
                    button.font = [NSFont menuBarFontOfSize:button.font.pointSize];
                }
                button.bordered = true;
                tbi.view = button;
                //NSLog(@"identifier: %@ | title: %@", identifier, item.name);
                return tbi;
            } else {
                NSCustomTouchBarItem * tbi = [[NSCustomTouchBarItem alloc] initWithIdentifier:identifier];
                NSMenuButton * button = [NSMenuButton buttonWithTitle:item.name target:nil action:nil externalItem:item];
                button.font = [NSFont menuBarFontOfSize:button.font.pointSize];
                button.bordered = true;
                tbi.view = button;
                //NSLog(@"identifier: %@ | title: %@ | enabled: %hhd", identifier, item.name, item.enabled);
                return tbi;
            }
        }
    }

    return nil;
}

-(void)showSubmenuWithIdentifier:(NSTouchBarItemIdentifier)identifier {
    
}

-(NSTouchBar *)makeTouchBar {
    [self dismiss:self];
    if (!_cachedMenuBars) {
        _cachedMenuBars = [NSMutableDictionary dictionary];
    }
    [((ViewController *)self.contentViewController).progress startAnimation:nil];
    NSRunningApplication *menuApp = nil;
    menuApp = [[NSWorkspace sharedWorkspace] menuBarOwningApplication];
    //_currentAppBID = [menuApp bundleIdentifier];



    NSTouchBar * touchBar = [NSTouchBar new];
    touchBar.delegate = self;
    touchBar.customizationIdentifier = @"menubar";

    UIAccess *ui = [UIAccess new];
    NSArray *menu = [ui getAppMenu:menuApp];
    NSMutableArray * identifierArray = [NSMutableArray array];
//    [identifierArray addObject:@"Apple"];
    for (MenuItem * item in menu) {
        [identifierArray addObject:[NSString stringWithString:item.name]];
    }
    //[identifierArray addObject:@"hidebutton"];
    //touchBar.defaultItemIdentifiers = @[ @"File", @"Edit", @"Format", @"View", @"Window", @"Help" ];
    touchBar.defaultItemIdentifiers = identifierArray;
    //[touchBar setTemplateItems:[NSPopoverTouchBarItem setForSubmenu:NSApplication.sharedApplication.menu]];
    //touchBar.suppressesLessFocusedBars = true;
    return touchBar;
}


@end

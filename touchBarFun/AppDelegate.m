//
//  AppDelegate.m
//  touchBarFun
//
//  Created by Ethan Chaffin on 10/28/21.
//

#import "AppDelegate.h"
#import "DFRPrivate/include/DFRPrivate.h"


@interface NSMenu()
-(long long)_backgroundStyle;
@end

@interface AppDelegate ()


@end

@implementation AppDelegate
NSStatusItem *statusItem;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [NSApp setActivationPolicy: NSApplicationActivationPolicyAccessory];
    [NSApplication.sharedApplication setAutomaticCustomizeTouchBarMenuItemEnabled:true];
//    NSLog(@"%@",[[NSApplication.sharedApplication menu] itemArray]);
//    NSLog(@"%lld", [[NSApplication.sharedApplication menu] _backgroundStyle]);
    
    NSDictionary *options = @{(__bridge id)kAXTrustedCheckOptionPrompt: @YES};
    BOOL accessibilityEnabled = AXIsProcessTrustedWithOptions((CFDictionaryRef)options);
    
    if (!accessibilityEnabled)
    {
        NSAlert *alert = [[NSAlert alloc] init];

        [alert setAlertStyle:NSAlertStyleWarning];
        [alert setMessageText:@"TouchBarFun"];
        [alert setInformativeText:@"TouchBarFun needs accessibility permissions to be able to parse and interact with the menu bars of other applications. Please enable them and then relaunch TouchBarFun."];
        [alert addButtonWithTitle:@"Close TouchBarFun"];

        NSInteger alertResult = [alert runModal];

        switch (alertResult) {
            case NSAlertFirstButtonReturn:
                [NSApp terminate:self];
                return;
                break;
        }


    }
//    NSAlert *alert = [[NSAlert alloc] init];
//
//    [alert setAlertStyle:NSAlertStyleInformational];
//    [alert setMessageText:@"TouchBarFun Beta"];
//    [alert setInformativeText:@"This is a beta. It's a bit slow sometimes and it's got bugs. To get your touch bar back, quit touchbarfun. To relaunch the control strip, if it disappears, open the terminal and run killall ControlStrip."];
//    [alert addButtonWithTitle:@"Continue"];
//
//    NSInteger alertResult = [alert runModal];
//
//    switch (alertResult) {
//        case NSAlertFirstButtonReturn:
//            return;
//            break;
//    }
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    statusItem.button.image = [NSImage imageWithSystemSymbolName:@"filemenu.and.selection" accessibilityDescription:nil];
    
    [AppDelegate buildMenu];
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

+ (void)buildMenu {
    NSMenu *itemsMenu = [NSMenu new];
    NSRunningApplication *menuApp = nil;
    menuApp = [[NSWorkspace sharedWorkspace] menuBarOwningApplication];
    [itemsMenu addItemWithTitle:[NSString stringWithFormat:@"Currently loaded menu bar: %@", menuApp.localizedName] action:nil keyEquivalent:@""];
    [itemsMenu addItem:NSMenuItem.separatorItem];
    [itemsMenu addItemWithTitle:@"Force Reload" action:@selector(forceReload) keyEquivalent:@""];
    [itemsMenu addItemWithTitle:@"Kill Control Strip" action:@selector(killControlStrip) keyEquivalent:@""];
    [itemsMenu addItem:NSMenuItem.separatorItem];
    [itemsMenu addItemWithTitle:@"Quit" action:@selector(exitApp) keyEquivalent:@""];
    
    statusItem.menu = itemsMenu;
}

- (void)okcheck {
    NSLog(@"ok checked 1");
}

- (void)forceReload {
    NSLog(@"ok checked 2");
}

- (void)killControlStrip {
    NSString* appName = @"ControlStrip";
    NSString* killCommand = [@"/usr/bin/killall " stringByAppendingString:appName];
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/bash"];
    [task setArguments:@[@"-c", killCommand]];
    [task launch];
}

- (void)exitApp {
    [NSApp terminate:self];
}

@end

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

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [NSApplication.sharedApplication setAutomaticCustomizeTouchBarMenuItemEnabled:true];
//    NSLog(@"%@",[[NSApplication.sharedApplication menu] itemArray]);
//    NSLog(@"%lld", [[NSApplication.sharedApplication menu] _backgroundStyle]);

    

    if (!AXAPIEnabled())
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
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}


@end

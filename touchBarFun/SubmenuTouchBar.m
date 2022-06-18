//
//  SubmenuTouchBar.m
//  touchBarFun
//
//  Created by Ethan Chaffin on 12/2/21.
//

#import "SubmenuTouchBar.h"
#import "NSMenuButton.h"
#import "WC.h"
#import "DFRPrivate/include/DFRPrivate.h"

@implementation SubmenuTouchBar

-(id)initWithMenu:(NSMenu *)menu {
    self = [super init];
    if (self) {
        _menu = menu;
        [NSTouchBar setSystemModalShowsCloseBoxWhenFrontMost:true];
        self.delegate = self;
        self.customizationIdentifier = [NSString stringWithString:menu.title];
        NSMutableArray * identifierArray = [NSMutableArray array];
        [identifierArray addObject:@"com.ethanrdoesmc.tbf.closebutton"];
        for (NSMenuItem * item in menu.itemArray) {
            [identifierArray addObject:[NSString stringWithString:item.title]];
        }
        self.defaultItemIdentifiers = identifierArray;
    }
    return self;
}

-(void)swapTouchBars:(id)sender {
    NSMenuButton * button = sender;
    [NSTouchBar presentSystemModalTouchBar:[[SubmenuTouchBar alloc] initWithMenu:button.item.submenu] placement:false systemTrayItemIdentifier:button.item.submenu.title];
}

-(void)dismiss:(id)sender {
    [NSTouchBar minimizeSystemModalTouchBar:self];
}

- (NSTouchBarItem *)touchBar:(NSTouchBar *)touchBar makeItemForIdentifier:(NSTouchBarItemIdentifier)identifier {
    for (NSMenuItem * item in _menu.itemArray) {
        NSLog(@"identifier: %@ | title: %@", identifier, item.title);
        if ([item.title isEqualToString:identifier]) {
            if (item.hasSubmenu) {
                NSCustomTouchBarItem * tbi = [[NSCustomTouchBarItem alloc] initWithIdentifier:identifier];
                NSMenuButton * button = [NSMenuButton buttonWithTitle:item.title target:self action:@selector(swapTouchBars:) item:item];
                button.font = [NSFont systemFontOfSize:button.font.pointSize];
                button.bordered = true;

                button.image = [NSImage imageNamed:NSImageNameTouchBarGoForwardTemplate];
                button.imagePosition = NSImageTrailing;

                if (item.target) {
                    if ([item.target respondsToSelector:@selector(validateMenuItem:)]) {
                        button.enabled = [((id<NSMenuItemValidation>)item.target) validateMenuItem:item];
                    }
                    else {
                        button.enabled = true;
                    }
                }
                else {
                    button.enabled = false;
                }
                tbi.view = button;
                NSLog(@"identifier: %@ | title: %@ | action: %@", identifier, item.title, item.action?@"yes":@"no");
                return tbi;
            } else {
                NSCustomTouchBarItem * ctbi = [[NSCustomTouchBarItem alloc] initWithIdentifier:identifier];
                //NSString * totalString = [NSString stringWithFormat:@"%@ (%@)",item.title,item.keyEquivalent];
                NSMenuButton * cbutton = [NSMenuButton buttonWithTitle:item.title item:item];
                cbutton.font = [NSFont systemFontOfSize:cbutton.font.pointSize];
                cbutton.bordered = true;
                if (item.isSeparatorItem) {
                    cbutton.bordered = false;
                    cbutton.image = [NSImage imageNamed:NSImageNameTouchBarPlayheadTemplate];
                }

                if (item.target) {
                    if ([item.target respondsToSelector:@selector(validateMenuItem:)]) {
                        cbutton.enabled = [((id<NSMenuItemValidation>)item.target) validateMenuItem:item];
                    }
                    else {
                        cbutton.enabled = [item.target respondsToSelector:item.action];
                    }
                }
//                else if (item.action) {
//                    cbutton.enabled = true;
//                }
                else {
                    cbutton.enabled = false;
                }
//                if ([item.target validateMenuItem:<#(nonnull NSMenuItem *)#>] == false) {
//                    cbutton.enabled = false;
//                }
                ctbi.view = cbutton;
                NSLog(@"identifier: %@ | title: %@ | action: %@", identifier, item.title, [((id<NSMenuItemValidation>)item.target) validateMenuItem:item]?@"yes":@"no");
                return ctbi;
            }
        }
    }
    if ([identifier isEqualToString:@"com.ethanrdoesmc.tbf.closebutton"]) {
        NSCustomTouchBarItem * tbi = [[NSCustomTouchBarItem alloc] initWithIdentifier:identifier];
        //NSMenuButton * button = [NSMenuButton buttonWithTitle:item.title target:self action:@selector(dismiss:) item:item];
        //NSButton * button = [NSButton buttonWithImage:[NSImage imageWithSystemSymbolName:@"xmark.circle.fill" accessibilityDescription:nil] target:self action:@selector(dismiss:)];
        NSButton * button = [NSButton buttonWithImage:[NSImage imageNamed:NSImageNameTouchBarGoBackTemplate] target:self action:@selector(dismiss:)];
        button.bordered = false;
        tbi.view = button;
        return tbi;
    }
    return nil;
}

@end

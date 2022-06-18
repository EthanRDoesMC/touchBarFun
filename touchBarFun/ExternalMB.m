//
//  ExternalMB.m
//  touchBarFun
//
//  Created by Ethan Chaffin on 12/7/21.
//

#import "ExternalMB.h"
#import "UIAccess.h"
#import "MenuItem.h"
#import "NSMenuButton.h"
#import "DFRPrivate/include/DFRPrivate.h"
#import <ApplicationServices/ApplicationServices.h>
#import "NSTouchBarExtra.h"

@implementation ExternalMB


-(id)initWithMenuItem:(MenuItem *)menu {
    self = [super init];
    if (self) {
        _menuItem = menu;
        [NSTouchBar setSystemModalShowsCloseBoxWhenFrontMost:true];
        self.delegate = self;
        self.customizationIdentifier = [NSString stringWithString:menu.name];
        NSMutableArray * identifierArray = [NSMutableArray array];
        [identifierArray addObject:@"com.ethanrdoesmc.tbf.closebutton"];
        [identifierArray addObject:[NSString stringWithString:menu.name]];
        self.defaultItemIdentifiers = identifierArray;
    }
    return self;
}


-(void)swapTouchBars:(id)sender {
    NSMenuButton * button = sender;
    [NSTouchBar presentSystemModalTouchBar:[[ExternalMB alloc] initWithMenuItem:button.externalItem] placement:false systemTrayItemIdentifier:button.externalItem.name];
}

-(void)dismiss:(id)sender {
    [self minimizeSystemModal];
}

-(void)handleAction:(id)sender {
    NSMenuButton * button = sender;
    if (AXIsProcessTrusted()) {
        AXError error = AXUIElementPerformAction(button.externalItem.element, kAXPickAction);
        NSLog(@"%d", (int)error);
        [[NSHapticFeedbackManager defaultPerformer] performFeedbackPattern:NSHapticFeedbackPatternAlignment performanceTime:NSHapticFeedbackPerformanceTimeDefault];
    }
}

- (NSTouchBarItem *)touchBar:(NSTouchBar *)touchBar makeItemForIdentifier:(NSTouchBarItemIdentifier)identifier {
    if ([identifier isEqualToString:@"com.ethanrdoesmc.tbf.closebutton"]) {
        NSCustomTouchBarItem * tbi = [[NSCustomTouchBarItem alloc] initWithIdentifier:identifier];
        NSButton * button = [NSButton buttonWithImage:[NSImage imageNamed:NSImageNameTouchBarGoBackTemplate] target:self action:@selector(dismiss:)];
        if ([_menuItem.name isEqualToString:@"Apple"]) {
            button.title = @" ";
        } else {
            button.title = _menuItem.name;
        }
        button.imagePosition = NSImageLeading;
        button.imageHugsTitle = true;
        button.bordered = true;
        tbi.view = button;
        return tbi;
    }
    
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:CGRectMake(0, 0, 400, 30)];
    NSMutableDictionary *constraintViews = [NSMutableDictionary dictionary];
    NSView *documentView = [[NSView alloc] initWithFrame:NSZeroRect];
    NSString *layoutFormat = @"H:|-8-";
    NSSize size = NSMakeSize(8, 30);




    for (MenuItem * item in _menuItem.children) {
        if ([_menuItem.name isEqualToString:identifier]) {
            if (item.children.count >> 0) {
                NSString *objectName = [NSString stringWithFormat:@"button%@",@([_menuItem.children indexOfObject:item])];
                //NSCustomTouchBarItem * tbi = [[NSCustomTouchBarItem alloc] initWithIdentifier:identifier];
                NSMenuButton * button = [NSMenuButton buttonWithTitle:item.name target:self action:@selector(swapTouchBars:) externalItem:item];
                //button.font = [NSFont menuBarFontOfSize:button.font.pointSize];
                button.bordered = true;
                button.image = [NSImage imageNamed:NSImageNameTouchBarGoForwardTemplate];
                button.imagePosition = NSImageTrailing;
                button.translatesAutoresizingMaskIntoConstraints = NO;
                [documentView addSubview:button];

                layoutFormat = [layoutFormat stringByAppendingString:[NSString stringWithFormat:@"[%@]-8-", objectName]];
                [constraintViews setObject:button forKey:objectName];
                size.width += 8 + button.intrinsicContentSize.width;
            }
            else {
                NSString *objectName = [NSString stringWithFormat:@"button%@",@([_menuItem.children indexOfObject:item])];
                //NSCustomTouchBarItem * tbi = [[NSCustomTouchBarItem alloc] initWithIdentifier:identifier];


                NSMenuButton * button = [NSMenuButton buttonWithTitle:[NSString stringWithFormat:@"%@%@%@", item.name, item.shortcut?@"   ":@"",item.shortcut?:@""] target:self action:@selector(handleAction:) externalItem:item];
                NSMutableDictionary * defaultattributes = [NSMutableDictionary dictionary];
                [defaultattributes setObject:button.font forKey:NSFontAttributeName];

                NSMutableDictionary * subscript = [NSMutableDictionary dictionary];
                [subscript setObject:button.font forKey:NSFontAttributeName];
                [subscript setObject:[NSColor systemGrayColor] forKey:NSForegroundColorAttributeName];
                NSMutableParagraphStyle * pgs = [[NSMutableParagraphStyle alloc] init];
                [pgs setAlignment:NSTextAlignmentRight];
                [subscript setObject:pgs forKey:NSParagraphStyleAttributeName];
                if (item.shortcut) {
                    if (@available(macOS 12.0, *)) {
                        [button setAttributedTitle:[NSAttributedString localizedAttributedStringWithFormat:[[NSAttributedString alloc] initWithString:@"%@%@%@"],[[NSAttributedString alloc] initWithString:item.name attributes:defaultattributes],[[NSAttributedString alloc] initWithString:item.shortcut?@"   ":@"" attributes:defaultattributes],[[NSAttributedString alloc] initWithString:item.shortcut?:@"" attributes:subscript]]];
                    }
                }
                button.enabled = item.enabled;
                //button.font = [NSFont menuBarFontOfSize:button.font.pointSize];
                button.bordered = true;
                button.translatesAutoresizingMaskIntoConstraints = NO;
                [documentView addSubview:button];
                layoutFormat = [layoutFormat stringByAppendingString:[NSString stringWithFormat:@"[%@]-8-", objectName]];
                [constraintViews setObject:button forKey:objectName];
                size.width += 8 + button.intrinsicContentSize.width;

            }
            
        }
    }
    layoutFormat = [layoutFormat stringByAppendingString:[NSString stringWithFormat:@"|"]];

    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:layoutFormat
                                                                    options:NSLayoutFormatAlignAllCenterY
                                                                    metrics:nil
                                                                      views:constraintViews];

    [documentView setFrame:NSMakeRect(0, 0, size.width, size.height)];
    [NSLayoutConstraint activateConstraints:hConstraints];
    //[documentView fit]
    scrollView.documentView = documentView;

    NSCustomTouchBarItem *item = [[NSCustomTouchBarItem alloc] initWithIdentifier:_menuItem.name];
    item.view = scrollView;
    return item;

    return nil;
}
@end

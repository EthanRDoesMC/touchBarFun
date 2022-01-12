//
//  NSTouchBarItem+NSTouchBarItemMagic.m
//  touchBarFun
//
//  Created by Ethan Chaffin on 10/28/21.
//

#import "NSPopoverTouchBarItem+NSTouchBarItemMagic.h"

@implementation NSPopoverTouchBarItem (NSTouchBarItemMagic)




+(NSSet *)setForSubmenu:(NSMenu *)submenu {
    NSMutableSet * set = [NSMutableSet new];

    for (NSMenuItem * item in submenu.itemArray) {
        [set addObject:[NSPopoverTouchBarItem.alloc initWithMenuItem:item]];
    }

    return set;
}


-(id)initWithMenuItem:(NSMenuItem *)menuItem {

    self = [self initWithIdentifier:menuItem.title];

    if (self) {
//        NSButton * button = [NSButton buttonWithTitle:menuItem.title target:self action:menuItem.action];
//        [button setBezelStyle:NSBezelStyleRounded];
//        NSButtonTouchBarItem * buttonItem = [[NSButtonTouchBarItem alloc] initWithIdentifier:@"bruh"];
//        [buttonItem setTitle:menuItem.title];
//        [self setCollapsedRepresentation:buttonItem.view];
        [self setCollapsedRepresentationLabel:menuItem.identifier];
//        NSTouchBar * subBar = [[NSTouchBar alloc] init];
//        [subBar setTemplateItems:[NSPopoverTouchBarItem setForSubmenu:menuItem.submenu]];
//        [self setPopoverTouchBar:subBar];
        NSLog(@"%@", menuItem.title);
        NSLog(@"%@", self);

    }

    return self;

}

@end

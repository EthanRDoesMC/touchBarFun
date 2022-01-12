//
//  NSMenuButton.m
//  touchBarFun
//
//  Created by Ethan Chaffin on 12/2/21.
//

#import "NSMenuButton.h"


@implementation NSMenuButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

+(NSMenuButton *)buttonWithTitle:(NSString *)title item:(NSMenuItem *)item {
    NSMenuButton * button = [NSMenuButton buttonWithTitle:title target:nil action:nil];
    [button setItem:item];
    [button setTarget:button.item.target];
    [button setAction:button.item.action];
    return button;
}

+(NSMenuButton *)buttonWithTitle:(NSString *)title externalItem:(MenuItem *)item {
    NSMenuButton * button = [NSMenuButton buttonWithTitle:title target:nil action:nil];
    [button setExternalItem:item];
    return button;
}

+(NSMenuButton *)buttonWithTitle:(NSString *)title target:(nullable id)target action:(nullable SEL)action item:(NSMenuItem *)item {
    NSMenuButton * button = [NSMenuButton buttonWithTitle:title target:target action:action];
    button.item = item;
    return button;
}

+(NSMenuButton *)buttonWithTitle:(NSString *)title target:(nullable id)target action:(nullable SEL)action externalItem:(MenuItem *)item {
    NSMenuButton * button = [NSMenuButton buttonWithTitle:title target:target action:action];
    button.externalItem = item;
    return button;
}

@end

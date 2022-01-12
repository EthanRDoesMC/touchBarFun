//
//  MenuItem.m
//  menudump
//
//  Created by Charles Wise on 4/12/13.
//

#import "MenuItem.h"

@implementation MenuItem {
@private
    NSString *_name;
    NSArray *_children;
    int _depth;
    NSString *_shortcut;
    NSString *_locator;
    NSString *_path;
    NSArray *_actions;
    AXUIElementRef element;
    BOOL enabled;
}

@synthesize name = _name;
@synthesize children = _children;
@synthesize depth = _depth;
@synthesize shortcut = _shortcut;
@synthesize locator = _locator;
@synthesize path = _path;
@synthesize actions = _actions;
@synthesize element;
@synthesize enabled;

-(id)initWithRef:(AXUIElementRef)rref {
    if (![super init]) {
        return nil;
    }
    element = CFRetain(rref);
    return self;
}

@end

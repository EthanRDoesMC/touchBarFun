//
//  StatusBarItemManager.m
//  touchBarFun
//
//  Created by Ethan Chaffin on 12/6/21.
//

#import "StatusBarItemManager.h"

@interface NSStatusBar()
-(NSPointerArray *)_statusItems;
@end

@implementation StatusBarItemManager

+(NSArray *)statusBarItems {
    NSLog(@"%@", [[[NSStatusBar systemStatusBar] _statusItems] allObjects]);
    return nil;
}

@end

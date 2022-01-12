//
//  NSMenuButton.h
//  touchBarFun
//
//  Created by Ethan Chaffin on 12/2/21.
//

#import <Cocoa/Cocoa.h>
#import "MenuItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSMenuButton : NSButton
@property (nonatomic,strong) NSMenuItem * item;
@property (nonatomic,strong) MenuItem * externalItem;
@property (nonatomic,strong) NSPopoverTouchBarItem * popover;

+(NSMenuButton *)buttonWithTitle:(NSString *)title item:(NSMenuItem *)item;
+(NSMenuButton *)buttonWithTitle:(NSString *)title externalItem:(MenuItem *)item;
+(NSMenuButton *)buttonWithTitle:(NSString *)title target:(nullable id)target action:(nullable SEL)action item:(NSMenuItem *)item;
+(NSMenuButton *)buttonWithTitle:(NSString *)title target:(nullable id)target action:(nullable SEL)action externalItem:(MenuItem *)item;
@end

NS_ASSUME_NONNULL_END

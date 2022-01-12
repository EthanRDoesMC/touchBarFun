//
//  NSTouchBarItem+NSTouchBarItemMagic.h
//  touchBarFun
//
//  Created by Ethan Chaffin on 10/28/21.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSPopoverTouchBarItem (NSTouchBarItemMagic)

+(NSSet *)setForSubmenu:(NSMenu *)submenu;
-(id)initWithMenuItem:(NSMenuItem*)menuItem;

@end

NS_ASSUME_NONNULL_END

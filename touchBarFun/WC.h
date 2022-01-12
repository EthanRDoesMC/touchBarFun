//
//  WC.h
//  touchBarFun
//
//  Created by Ethan Chaffin on 10/28/21.
//

#import <Cocoa/Cocoa.h>
#import "SubmenuTouchBar.h"
NS_ASSUME_NONNULL_BEGIN

@interface WC : NSWindowController <NSTouchBarDelegate>
@property (readwrite) NSString * currentAppBID;
@property (strong,nonatomic) NSMutableDictionary * cachedMenuBars;
@property (strong,nonatomic) NSCustomTouchBarItem * menuBarItem;
@property (strong,nonatomic) NSTouchBar * blankTB;
-(void)swapTouchBars:(id)sender;
-(void)dismiss:(id)sender;
-(void)refreshTouchBar;
@end

NS_ASSUME_NONNULL_END

//
//  ExternalMB.h
//  touchBarFun
//
//  Created by Ethan Chaffin on 12/7/21.
//

#import <Cocoa/Cocoa.h>
#import "MenuItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface ExternalMB : NSTouchBar <NSTouchBarDelegate>
@property (nonatomic,strong) MenuItem * menuItem;
-(id)initWithMenuItem:(MenuItem *)menu;
-(void)swapTouchBars:(id)sender;
@end

NS_ASSUME_NONNULL_END

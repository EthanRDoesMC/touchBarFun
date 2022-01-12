//
//  SubmenuTouchBar.h
//  touchBarFun
//
//  Created by Ethan Chaffin on 12/2/21.
//

#import <Cocoa/Cocoa.h>
NS_ASSUME_NONNULL_BEGIN
@class WC;
@interface SubmenuTouchBar : NSTouchBar <NSTouchBarDelegate>
@property (nonatomic,strong) NSMenu * menu;

-(void)swapTouchBars:(id)sender;
-(id)initWithMenu:(NSMenu *)menu;
@end

NS_ASSUME_NONNULL_END

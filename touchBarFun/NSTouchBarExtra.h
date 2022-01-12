//
//  NSTouchBarExtra.h
//  touchBarFun
//
//  Created by Ethan Chaffin on 12/8/21.
//

#ifndef NSTouchBarExtra_h
#define NSTouchBarExtra_h

@interface NSTouchBar (Extras)

@property(getter=isSuppressedByMoreFocusedTouchBars) BOOL suppressedByMoreFocusedTouchBars;
@property(getter=isSuppressedByLessFocusedTouchBars) BOOL suppressedByLessFocusedTouchBars;
@property BOOL suppressesMoreFocusedBars;
@property BOOL suppressesLessFocusedBars;

@property(readonly) CAMediaTimingFunction *animationTimingFunction;
@property(readonly) double animationDuration;
- (id)animationForKey:(id)arg1;
@property(copy) NSDictionary *animations;
- (id)animator;
- (Class)_animatorClass;

@end

#endif /* NSTouchBarExtra_h */

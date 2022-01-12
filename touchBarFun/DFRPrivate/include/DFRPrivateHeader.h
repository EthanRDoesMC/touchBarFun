#ifndef DFRPrivateHeader_h
#define DFRPrivateHeader_h

#import <AppKit/AppKit.h>

#import "Obfuscation.h"

NS_ASSUME_NONNULL_BEGIN

extern void DFRElementSetControlStripPresenceForIdentifier_(NSTouchBarItemIdentifier identifier, BOOL present);
extern void DFRSystemModalShowsCloseBoxWhenFrontMost_(BOOL show);

@interface NSTouchBarItem (DFRPrivate)

+ (void)addSystemTrayItem:(NSTouchBarItem *)item;

+ (void)removeSystemTrayItem:(NSTouchBarItem *)item;

@end

@interface NSTouchBar (DFRPrivate)

// MARK: macOS 10.14 and above

+ (void)presentSystemModalTouchBar:(NSTouchBar *)touchBar placement:(long long)placement systemTrayItemIdentifier:(NSTouchBarItemIdentifier)identifier NS_AVAILABLE_MAC(10_14);

+ (void)presentSystemModalTouchBar:(NSTouchBar *)touchBar systemTrayItemIdentifier:(NSTouchBarItemIdentifier)identifier NS_AVAILABLE_MAC(10_14);

+ (void)dismissSystemModalTouchBar:(NSTouchBar *)touchBar NS_AVAILABLE_MAC(10_14);

+ (void)minimizeSystemModalTouchBar:(NSTouchBar *)touchBar NS_AVAILABLE_MAC(10_14);

// MARK: lower than macOS 10.14

+ (void)presentSystemModalFunctionBar:(NSTouchBar *)touchBar placement:(long long)placement systemTrayItemIdentifier:(NSTouchBarItemIdentifier)identifier NS_DEPRECATED_WITH_REPLACEMENT_MAC("presentSystemModalTouchBar:placement:systemTrayItemIdentifier:", 10_12_2, 10_14);

+ (void)presentSystemModalFunctionBar:(NSTouchBar *)touchBar systemTrayItemIdentifier:(NSTouchBarItemIdentifier)identifier NS_DEPRECATED_WITH_REPLACEMENT_MAC("presentSystemModalTouchBar:systemTrayItemIdentifier:", 10_12_2, 10_14);

+ (void)dismissSystemModalFunctionBar:(NSTouchBar *)touchBar NS_DEPRECATED_WITH_REPLACEMENT_MAC("dismissSystemModalTouchBar:", 10_12_2, 10_14);

+ (void)minimizeSystemModalFunctionBar:(NSTouchBar *)touchBar NS_DEPRECATED_WITH_REPLACEMENT_MAC("minimizeSystemModalTouchBar:", 10_12_2, 10_14);

@end

NS_ASSUME_NONNULL_END

#endif /* DFRPrivateHeader_h */

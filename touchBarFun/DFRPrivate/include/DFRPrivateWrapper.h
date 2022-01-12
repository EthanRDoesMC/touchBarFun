#ifndef DFRPrivateWrapper_h
#define DFRPrivateWrapper_h

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTouchBarItem (DFRAccess)

- (void)addToSystemTray;

- (void)removeFromSystemTray;

/// Wrapper of `DFRElementSetControlStripPresenceForIdentifier`
+ (void)setControlStripPresence:(BOOL)present for:(NSTouchBarItemIdentifier)identifier;

- (void)setControlStripPresence:(BOOL)present;

@end

@interface NSTouchBar (DFRAccess)

- (void)presentAsSystemModalForItem:(NSTouchBarItem *)item;

- (void)presentAsSystemModalForItemIdentifier:(NSTouchBarItemIdentifier)identifier;

- (void)presentAsSystemModalForItemIdentifier:(NSTouchBarItemIdentifier)identifier placement:(BOOL)placement;

- (void)dismissSystemModal;

- (void)minimizeSystemModal;

/// Wrapper of DFRSystemModalShowsCloseBoxWhenFrontMost
+ (void)setSystemModalShowsCloseBoxWhenFrontMost:(BOOL)show;

@end

NS_ASSUME_NONNULL_END

#endif /* DFRPrivateWrapper_h */

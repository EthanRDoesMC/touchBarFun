#import "DFRPrivateWrapper.h"
#import "DFRPrivateHeader.h"

@implementation NSTouchBarItem (DFRAccess)

- (void)addToSystemTray {
    [NSTouchBarItem addSystemTrayItem:self];
}

- (void)removeFromSystemTray {
    [NSTouchBarItem removeSystemTrayItem:self];
}

+ (void)setControlStripPresence:(BOOL)present for:(NSTouchBarItemIdentifier)identifier {
    DFRElementSetControlStripPresenceForIdentifier_(identifier, present);
}

- (void)setControlStripPresence:(BOOL)present {
    DFRElementSetControlStripPresenceForIdentifier_(self.identifier, present);
}

@end

@implementation NSTouchBar (DFRAccess)

- (void)presentAsSystemModalForItem:(NSTouchBarItem *)item {
    [self presentAsSystemModalForItemIdentifier:item.identifier];
}

- (void)presentAsSystemModalForItemIdentifier:(NSTouchBarItemIdentifier)identifier {
    if (@available(macOS 10.14, *)) {
        [NSTouchBar presentSystemModalTouchBar:self
                      systemTrayItemIdentifier:identifier];
    } else {
        [NSTouchBar presentSystemModalFunctionBar:self
                         systemTrayItemIdentifier:identifier];
    }
}

- (void)presentAsSystemModalForItemIdentifier:(NSTouchBarItemIdentifier)identifier placement:(BOOL)placement {
    long long hideControlStrip = placement ? 1 : 0;
    if (@available(macOS 10.14, *)) {
        [NSTouchBar presentSystemModalTouchBar:self
                                     placement:hideControlStrip
                      systemTrayItemIdentifier:identifier];
    } else {
        [NSTouchBar presentSystemModalFunctionBar:self
                                        placement:hideControlStrip
                         systemTrayItemIdentifier:identifier];
    }
}

- (void)dismissSystemModal {
    if (@available(macOS 10.14, *)) {
        [NSTouchBar dismissSystemModalTouchBar:self];
    } else {
        [NSTouchBar dismissSystemModalFunctionBar:self];
    }
}

- (void)minimizeSystemModal {
    if (@available(macOS 10.14, *)) {
        [NSTouchBar minimizeSystemModalTouchBar:self];
    } else {
        [NSTouchBar minimizeSystemModalFunctionBar:self];
    }
}

+ (void)setSystemModalShowsCloseBoxWhenFrontMost:(BOOL)show {
    DFRSystemModalShowsCloseBoxWhenFrontMost_(show);
}

@end

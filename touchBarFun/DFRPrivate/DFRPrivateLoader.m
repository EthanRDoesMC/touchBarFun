#import "DFRPrivateHeader.h"
#import <dlfcn.h>

#define kDFRFoundationPath "/System/Library/PrivateFrameworks/DFRFoundation.framework/DFRFoundation"
#define kDFRElementSetControlStripPresenceForIdentifierSymbol "DFRElementSetControlStripPresenceForIdentifier"
#define kDFRSystemModalShowsCloseBoxWhenFrontMostSymbol "DFRSystemModalShowsCloseBoxWhenFrontMost"

static void (*pDFRElementSetControlStripPresenceForIdentifier)(NSTouchBarItemIdentifier, BOOL);
static void (*pDFRSystemModalShowsCloseBoxWhenFrontMost)(BOOL);

void DFRElementSetControlStripPresenceForIdentifier_(NSTouchBarItemIdentifier identifier, BOOL present) {
    if (pDFRElementSetControlStripPresenceForIdentifier) {
        pDFRElementSetControlStripPresenceForIdentifier(identifier, present);
    }
}

void DFRSystemModalShowsCloseBoxWhenFrontMost_(BOOL show) {
    if (pDFRSystemModalShowsCloseBoxWhenFrontMost) {
        pDFRSystemModalShowsCloseBoxWhenFrontMost(show);
    }
}

__attribute__((constructor)) static void loadDFRFoundation() {
    void *handle;
    if ((handle = dlopen(kDFRFoundationPath, RTLD_LAZY)) == NULL) {
        return;
    }
    pDFRElementSetControlStripPresenceForIdentifier = dlsym(handle, kDFRElementSetControlStripPresenceForIdentifierSymbol);
    pDFRSystemModalShowsCloseBoxWhenFrontMost = dlsym(handle, kDFRSystemModalShowsCloseBoxWhenFrontMostSymbol);
    dlclose(handle);
}

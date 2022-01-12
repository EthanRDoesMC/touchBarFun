//
//  ViewController.h
//  touchBarFun
//
//  Created by Ethan Chaffin on 10/28/21.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
@property (strong) IBOutlet NSButtonCell *AppIcon;
@property (strong) IBOutlet NSTextField *largeLabel;

@property (strong) IBOutlet NSProgressIndicator *progress;

@end


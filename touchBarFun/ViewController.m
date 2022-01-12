//
//  ViewController.m
//  touchBarFun
//
//  Created by Ethan Chaffin on 10/28/21.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_progress setUsesThreadedAnimation:true];
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

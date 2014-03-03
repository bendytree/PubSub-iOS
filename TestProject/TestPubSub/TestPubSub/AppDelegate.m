//
//  AppDelegate.m
//  TestPubSub
//
//  Created by Joshua Wright on 6/4/13.
//  Copyright (c) 2013 Joshua Wright. All rights reserved.
//

#import "AppDelegate.h"
#import "Notifications.h"


@implementation AppDelegate{
    
    id keeper;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    keeper = [[NSObject alloc] init];
    
    
    //
    // Zero arg subscription
    //
    [Sub while:keeper testWithZeroArgs:^{
        NSLog(@"Zero args...");
    }];
    
    [Pub testWithZeroArgs];
    [Pub testWithZeroArgs];
    [Pub testWithZeroArgs];
    [Pub testWithZeroArgs];

    //
    // One arg subscription
    //
    [Sub while:keeper testWithOneArg:^(NSString *a) {
        NSLog(@"One arg: %@", a);
    }];
    
    [Pub testWithOneArg:@"A"];
    
    
    //
    // Two arg subscription
    //
    [Sub while:keeper testWithTwoArgs:^(NSString *a, NSString *b) {
        NSLog(@"Two args: a: %@, b: %@", a, b);
    }];
    [Pub testWithTwoArgs:@"a" b:@"B"];
    [Pub testWithTwoArgs:@"A" b:@"b"];
    [Pub testWithTwoArgs:@"aaa" b:@"bbb"];
    
    //
    // Three arg subscription
    //
    [Sub while:keeper testWithThreeArgs:^(NSString *a, NSString *b, NSString *c) {
        NSLog(@"Three args: a: %@, b: %@, c: %@", a, b, c);
    }];
    [Pub testWithThreeArgs:@"a" b:@"b" c:@"c"];
    [Pub testWithThreeArgs:@"a" b:@"b" c:@"c"];
    [Pub testWithThreeArgs:@"a" b:@"b" c:@"c"];
    [Pub testWithThreeArgs:@"a" b:@"b" c:@"c"];
    [Pub testWithThreeArgs:@"a" b:@"b" c:@"c"];

    return YES;
}

@end

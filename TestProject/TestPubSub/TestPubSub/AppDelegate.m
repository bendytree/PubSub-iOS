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
    
    
    [self testEventWithNilArguments];

    return YES;
}


- (void) testEventWithNilArguments {
    [Sub while:self testWith1NilArguments:^(NSString *a) {
        NSParameterAssert(a == nil);
    }];
    [Pub testWith1NilArguments:nil];
    
    [Sub while:self testWith2NilArguments:^(NSString *a, NSString *b) {
        NSParameterAssert(a == nil);
        NSParameterAssert(b == nil);
    }];
    [Pub testWith2NilArguments:nil b:nil];
    
    [Sub while:self testWith3NilArguments:^(NSString *a, NSString *b, NSString *c) {
        NSParameterAssert(a == nil);
        NSParameterAssert(b == nil);
        NSParameterAssert(c == nil);
    }];
    [Pub testWith3NilArguments:nil b:nil c:nil];
}

@end

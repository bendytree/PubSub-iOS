//
//  Notifications.h
//  TestPubSub
//
//  Created by Joshua Wright on 6/4/13.
//  Copyright (c) 2013 Joshua Wright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PubSub.h"


PubSub0Arg(testWithZeroArgs)

PubSub1Arg(testWithOneArg, \
       NSString*, a)

PubSub2Arg(testWithTwoArgs, \
       NSString*, a, \
       NSString*, b)

PubSub3Arg(testWithThreeArgs, NSString*, a, NSString*, b, NSString *, c)


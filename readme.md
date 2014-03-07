
_NOTE: this project is a fork of [bendytree/PubSub-iOS](https://github.com/bendytree/PubSub-iOS) and has changed significantly from it's original source. I'd like to say thanks to *bendytree* for the idea and the kick-start of a project._



## PubSub-iOS

PubSub-iOS is a very simple, block based wrapper around `NSNotificationCenter`.

The goal is minimal syntax, strong typing, and automatic unregistering.

Here's what it looks like:

    // Declare your notification
    PubSub1(nameChanged, NSString*, name)

    // Subscribe
    [Sub while:self nameChanged:^(NSString *name){
        NSLog(@"New Name: %@", name);
    }];
    
    // Publish
    [Pub nameChanged:@"Josh"];



## Getting Started

This library has no dependencies and requires arc.

### Install into your project

#### Option 1 (Copy 3 files)

Copy `PubSub.h`, `PubSub.m`, and `Notifications.h` into your XCode project. The PubSub files
do all the work and `Notifications.h` is where you declare your notifications.

If your project doesn't have ARC enabled, add the `-fobjc-arc` flag for `PubSub.m`.

#### Option 2 (Installation with CocoaPods)

CocoaPods is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries.

    pod "PubSub"


### Import Notifications.h (Bonus step)

In your `AppName-Prefix.pch` file, add `#import "Notifications.h"`. This makes it available
in all your classes. You can skip this step if you want to do it differently.

### Declare your Notifications

In `Notifications.h` you will use a preprocessor statement to declare your notifications. Declare one per line. For example:

	PubSub0(testWithZeroArgs)
	
	PubSub1(testWithOneArg, \
    	    NSString*, a)

	PubSub2(testWithTwoArgs, \
    	    NSString*, a, \
        	NSString*, b)

	PubSub3(testWithThreeArgs, \
    	    NSString*, a, \
        	NSString*, b, \
        	NSString*, c)

The first argument to `PubZubN` is the name of the notification/event. For each parameter you specify the `type` and the `name` of the argument up to 3 arguments.

These macro's generate the below strongly typed interface definition methods:

    @interface Pub
    + (void) testWithZeroArgs;
    + (void) testWithOneArg:(NSString*)a;
    + (void) testWithTwoArgs:(NSString*)a b:(NSString*)b;
    + (void) testWithThreeArgs:(NSString*)a b:(NSString*)b c:(NSString*)c;
    @end
	
    @interface Sub
    + (void) while:(id)obj testWithZeroArgs:(void(^)(void))callback;
    + (void) while:(id)obj testWithOneArg:(void(^)(NSString *a))callback;
    + (void) while:(id)obj testWithTwoArgs:(void(^)(NSString *a, NSString *b))callback;
    + (void) while:(id)obj testWithThreeArgs:(void(^)(NSString *a, NSString *b, NSString *c))callback;
    @end

   
    
### Publishing

Now whenever you want to post a notification, you can call:

    [Pub testWithZeroArgs];
    
    [Pub testWithOneArg:@"a"];
    
    [Pub testWithTwoArgs:@"a" b:@"b"];
    
    [Pub testWithThreeArgs:@"a" b:@"b" c:@"c"];    


### Subscribing

When you want to subscribe to an event, you pass it the block of code that should run:

    [Sub while:self testWithZeroArgs:^{
        NSLog(@"zero args notification published");
    }];

    [Sub while:self testWithOneArg:^(NSString* a){
        NSLog(@"a:%@", a);
    }];

    [Sub while:self testWithTwoArgs:^(NSString *a, NSString *b){
        NSLog(@"a:%@ b:%@", a, b);
    }];

    [Sub while:self testWithThreeArgs:^(NSString *a, NSString *b, NSString *c){
        NSLog(@"a:%@ b:%@ c:%@", a, b, c);
    }];

The first argument `while` is the best part. It keeps a weak reference to an object. When
that object goes away, the subscription is automatically cancelled. So "while" the object
is not NULL, it subscribes.

For the most part you will pass `self`. That means when `self` goes away you are automatically
unsubscribed. No cleanup necessary.

Compare that to `NSNotificationCenter` where you have to retain an observer then you have
to explicitly unregister when you're done.


# WARNING:

You can't use value types such as `int`, `BOOL`, etc in the PubSub macro... _If someone could help me figure out a way to acomplish this (possibly through some macro tricks) I'd love the feedback!_

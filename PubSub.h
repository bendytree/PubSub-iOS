
//
// PubSub.h
//
// Josh Wright
// http://bendytree.com
// @BendyTree
// June 4, 2013
//
// Use this however you want.
//

#import <Foundation/Foundation.h>

@interface Pub : NSObject
@end

@interface Sub : NSObject
@end




// Variable expansion with variable arguments thanks to
// http://stackoverflow.com/questions/11761703/overloading-macro-on-number-of-arguments

#define PubSubWithZeroArgs(name) \
@interface Pub (PubSub_ ## name ## _Category) \
+ (void) name; \
@end\
@interface Sub (PubSub_ ## name ## _Category)\
+ (void) while:(id)obj name:(void(^)(void))callback;\
@end

#define PubSubWithOneArg(name, type) \
@interface Pub (PubSub_ ## name ## _Category) \
+ (void) name:(type)arg; \
@end\
@interface Sub (PubSub_ ## name ## _Category)\
+ (void) while:(id)obj name:(void(^)(type))callback;\
@end


#define _ARG2(_0, _1, _2, ...) _2
#define NARG2(...) _ARG2(__VA_ARGS__, 2, 1, 0)

#define _ONE_OR_TWO_ARGS_1(a) PubSubWithZeroArgs(a)
#define _ONE_OR_TWO_ARGS_2(a, b) PubSubWithOneArg(a,b)

#define __ONE_OR_TWO_ARGS(N, ...) _ONE_OR_TWO_ARGS_ ## N (__VA_ARGS__)
#define _ONE_OR_TWO_ARGS(N, ...) __ONE_OR_TWO_ARGS(N, __VA_ARGS__)

#define PubSub(...) _ONE_OR_TWO_ARGS(NARG2(__VA_ARGS__), __VA_ARGS__)
//
//  NSMutableArray+Shuffle.m
//  MemoryPuzzleGame
//
//  Created by stevie nguyen on 4/8/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"

@implementation NSMutableArray (Shuffle)

-   (NSMutableArray*) shuffle{
    NSMutableArray* shuffledArray = [NSMutableArray new];
    int count = [self count];
    for (int i = 0 ; i < count ; i ++) {
        int n = arc4random()%[self count];
        [shuffledArray addObject:[self objectAtIndex:n]];
        [self removeObjectAtIndex:n];
    }
    return shuffledArray;
}

@end

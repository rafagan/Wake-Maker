//
//  combinationGenerator.m
//  MemoryGame
//
//  Created by André Traleski de Campos on 11/21/13.
//  Copyright (c) 2013 André Traleski de Campos. All rights reserved.
//

#import "CombinationGenerator.h"
#import "Symbol.h"

@implementation CombinationGenerator

+(CombinationGenerator *)sharedGenerator;
{
    static CombinationGenerator* sharedGenerator = nil;
    if(!sharedGenerator)
        sharedGenerator = [[super alloc] init];
    
    return sharedGenerator;
}

- (id)init
{
    self = [super init];
    if (self) {
        combination = [[NSMutableArray alloc] init];
        Symbol* s1 = [[Symbol alloc] initWithImg:@"symbol1.jpg" Name:@"Triangle" Index:0];
        Symbol* s2 = [[Symbol alloc] initWithImg:@"symbol2.jpg" Name:@"Square" Index:1];
        Symbol* s3 = [[Symbol alloc] initWithImg:@"symbol3.jpg" Name:@"Circle" Index:2];
        Symbol* s4 = [[Symbol alloc] initWithImg:@"symbol4.jpg" Name:@"Polygon" Index:3];
        symbols = @[s1,s2,s3,s4];
    }
    return self;
}

- (NSArray *)generateCombinationWithQuantity:(int)i
{
    [combination removeAllObjects];
    int x;
    for (int j = 0;j < i;j++)
    {
        int rand = arc4random() % 100;
        Symbol* s;
        
        if(rand < 25)
        {
            s = [[Symbol alloc] initWithImg:@"symbol1.jpg" Name:@"Triangle" Index:0];
            x = 0;
        }
        else if (rand >= 25 && rand < 50)
        {
            s = [[Symbol alloc] initWithImg:@"symbol2.jpg" Name:@"Square" Index:1];
            x = 1;
        }
        else if (rand >= 50 && rand < 75)
        {
            s = [[Symbol alloc] initWithImg:@"symbol3.jpg" Name:@"Circle" Index:2];
            x = 2;
        }
        else if (rand >= 75 && rand < 100)
        {
            s = [[Symbol alloc] initWithImg:@"symbol4.jpg" Name:@"Polygon" Index:3];
            x = 3;
        }
    
        [combination addObject:s];
    }
    
    return combination;
}

- (NSArray *)returnSymbols
{
    return symbols;
}

-(NSArray *)returnGeneratedCombination
{
    return combination;
}
@end

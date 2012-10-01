//
//  DSSyntaxCollection.m
//  DSCodeTextViewDemo
//
//  Created by Fabio Pelosin on 01/10/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#import "DSSyntaxCollection.h"
#import "DSRubySyntaxDefinition.h"
#import "DSObjectiveCSyntaxDefinition.h"

@implementation DSSyntaxCollection {
  NSArray *_availableSyntaxes;
  NSDictionary *_extensionsMappings;
}

- (id)init {
  self = [super init];
  if (self) {
    _availableSyntaxes = @[
      [DSRubySyntaxDefinition class],
      [DSObjectiveCSyntaxDefinition class],
    ];
  }
  return self;
}

//- (NSString*)syntaxForName:(NSString*)name {
//  Class class = _namesMappings[name];
//  return [[class alloc] init];
//}
//
//- (NSString*)syntaxForExtension:(NSString*)rb {
//  
//
//}
//

@end

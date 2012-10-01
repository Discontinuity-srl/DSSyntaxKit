//
//  DSRubySyntaxDefinition.m
//  DSCodeTextViewDemo
//
//  Created by Fabio Pelosin on 29/09/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#import "DSRubySyntaxDefinition.h"

@implementation DSRubySyntaxDefinition

- (id)init {
  self = [super init];
  if (self) {
    self.keywords = @[
    @"BEGIN",
    @"END",
    @"alias",
    @"and",
    @"begin",
    @"break",
    @"case",
    @"class",
    @"def",
    @"defined",
    @"do",
    @"else",
    @"elsif",
    @"end",
    @"ensure",
    @"false",
    @"for",
    @"in",
    @"module",
    @"next",
    @"nil",
    @"not",
    @"or",
    @"redo",
    @"rescue",
    @"retry",
    @"return",
    @"self",
    @"super",
    @"then",
    @"true",
    @"undef",
    @"when",
    @"yield",
    @"if",
    @"unless",
    @"while",
    @"until",
    @"attr_reader",
    @"attr",
    @"attr_writer",
    @"autoload"
    ];

    self.delimiters = @[
    @[ @"def[[\\t\\p{Zs}]]*\\W+", @"end" ],
    @[ @"do", @"end" ],
    @[ @"{", @"}" ],
    @[ @"[", @"]" ],
    ];
  }
  return self;
}

@end

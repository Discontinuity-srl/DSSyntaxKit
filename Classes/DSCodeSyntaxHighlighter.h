//
//  DSCodeSyntaxHighlighter.h
//  DSCodeTextViewDemo
//
//  Created by Fabio Pelosin on 26/09/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSSyntaxDefinition.h"
#import "DSSyntaxTheme.h"

@interface DSCodeSyntaxHighlighter : NSObject <NSTextStorageDelegate, NSLayoutManagerDelegate>

@property (nonatomic, readonly) NSTextStorage* storage;
@property (nonatomic, readonly) DSSyntaxDefinition* syntaxDefinition;
@property (nonatomic, strong) DSSyntaxTheme* theme;

@property (nonatomic) BOOL indentsNewLine;
@property (nonatomic) NSUInteger tabsWidth;

- (id)initWithTextStorage:(NSTextStorage *)storage;

- (void)parse;

@end

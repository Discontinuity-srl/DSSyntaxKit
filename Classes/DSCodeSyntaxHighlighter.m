//
//  DSCodeSyntaxHighlighter.m
//  DSCodeTextViewDemo
//
//  Created by Fabio Pelosin on 26/09/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#import "DSCodeSyntaxHighlighter.h"

#import "DSRubySyntaxDefinition.h"

/**
 http://www.cocoabuilder.com/archive/cocoa/75741-syntax-colouring.html
 http://www.noodlesoft.com/blog/2012/05/29/syntax-coloring-for-fun-and-profit/

 After some research, I found that the -[NSMutableAttributedString
 addAttributes:range:] method was causing most of the slowdown in the
 code (and what a slowdown this was!).  Replacing the calls to that
 method to addAttribute:value:range: improved things exponentially (no
 exact measurements, but we're talking several minutes down to a few
 seconds).
 **/


@implementation DSCodeSyntaxHighlighter {
  NSAttributedString* _syntaxAttributedString;
}

- (id)initWithTextStorage:(NSTextStorage *)storage
{
  if ((self = [super init]) != nil) {
    _storage = storage;
    [_storage setDelegate:self];
    
    _syntaxDefinition = [DSRubySyntaxDefinition new];
    _theme = [DSSyntaxTheme defaultTheme];
    [self parse];
  }

  for (NSLayoutManager* layoutManager in _storage.layoutManagers)
  {
    [layoutManager setDelegate:self];
  }

  return self;
}

- (void)setTheme:(DSSyntaxTheme *)theme {
  _theme = theme;
  [self parse];

  for (NSLayoutManager* layoutManager in _storage.layoutManagers)
  {
    [layoutManager setDelegate:self];
  }
}

#pragma mark NSTextStorage delegate methods

- (void)textStorageDidProcessEditing:(NSNotification *)aNotification {
  [self performSelector:@selector(parse) withObject:self afterDelay:0.0];
}

- (void)parse {
  _syntaxAttributedString = [_syntaxDefinition parseString:_storage.string];
}



#pragma mark NSLayoutManager delegate methods

- (NSDictionary *)layoutManager:(NSLayoutManager *)layoutManager
   shouldUseTemporaryAttributes:(NSDictionary *)attrs
             forDrawingToScreen:(BOOL)toScreen
               atCharacterIndex:(NSUInteger)charIndex
                 effectiveRange:(NSRangePointer)effectiveCharRange {
  if (!toScreen || !_storage.string || _storage.string == @"" ) { return nil; }

  NSMutableDictionary* highlightAttrs = [NSMutableDictionary new];
  NSString *type = [_syntaxAttributedString attribute:DSSyntaxDefinitionAttributeName atIndex:charIndex effectiveRange:effectiveCharRange];
  NSColor *color;

  if (type) {
    color = [_theme colorForType:type];
  } else {
    color = _theme.plainTextColor;
  }

  [highlightAttrs setObject:color forKey:NSForegroundColorAttributeName];

  NSMutableDictionary *mutable = [attrs mutableCopy];
  [mutable addEntriesFromDictionary:highlightAttrs];
  return mutable;
}

@end


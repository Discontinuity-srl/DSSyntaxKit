//
//  DSSyntaxTheme.m
//  DSCodeTextViewDemo
//
//  Created by Fabio Pelosin on 26/09/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#import "DSSyntaxTheme.h"

#if TARGET_OS_IPHONE
  #define RGB(r, g, b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]
#else
  #define RGB(r, g, b) [NSColor colorWithCalibratedRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]
#endif

@interface NSString (DSSyntaxTheme)
- (UINSColor*)xcodeColor;
@end


///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------

@implementation DSSyntaxTheme

- (UINSColor*)colorForType:(NSString*)type {
  UINSColor *color;
  if (!type) {
    color = _plainTextColor;
  } else {
    NSString *key = [type stringByAppendingString:@"Color"];
    color = [self valueForKey:key];
    if (!color) {
      color = _plainTextColor;
    }
  }
  return color;
}

///-----------------------------------------------------------------------------
#pragma mark - Initialization & disposal
///-----------------------------------------------------------------------------

- (id)init {
  self = [super init];

  if (self) {
    _plainTextColor  = RGB(255.f, 255.f, 255.f);
    _backgroundColor = RGB(0.f, 0.f, 0.f);
    _selectionColor  = RGB(166.f, 201.f, 255.f);
  }
  return self;
}

+ (id)defaultTheme {
  DSSyntaxTheme *result = [[[self class] alloc] init];

  result.plainTextColor  = [UINSColor blackColor];
  result.backgroundColor = [UINSColor whiteColor];
  result.cursorColor     = [UINSColor blackColor];
  result.commentColor    = RGB(128.f, 128.f, 128.f);
  result.stringColor     = RGB(211.f, 045.f, 038.f);
  result.keywordColor    = RGB(188.f, 049.f, 156.f);
  result.variableColor   = RGB(63, 110, 116);
  result.constantColor   = result.variableColor;

  //  result.documentationCommentColor   =  RGB(000.f, 131.f, 039.f);
  //  result.characterColor              =  RGB(040.f, 052.f, 206.f);
  //  result.numberColor                 =  RGB(040.f, 052.f, 206.f);
  //  result.preprocessorColor           =  RGB(120.f, 072.f, 048.f);
  //  result.attributeColor              =  RGB(150.f, 125.f, 065.f);
  //  result.projectColor                =  RGB(077.f, 129.f, 134.f);
  
  return result;
}

+ (id)themeWithXcodeTheme:(NSString*)path {
  DSSyntaxTheme *result = [[[self class] alloc] init];

  NSDictionary* root     = [NSDictionary dictionaryWithContentsOfFile:path];
  result.backgroundColor = [root[@"DVTSourceTextBackground"] xcodeColor];
  result.cursorColor     = [root[@"DVTSourceTextInsertionPointColor"] xcodeColor];
  result.selectionColor  = [root[@"DVTSourceTextSelectionColor"] xcodeColor];

  NSDictionary* syntax   = root[@"DVTSourceTextSyntaxColors"];
  result.plainTextColor  = [syntax[@"xcode.syntax.plain"] xcodeColor];
  result.commentColor    = [syntax[@"xcode.syntax.comment"] xcodeColor];
  result.stringColor     = [syntax[@"xcode.syntax.string"] xcodeColor];
  result.keywordColor    = [syntax[@"xcode.syntax.keyword"] xcodeColor];
  result.attributeColor  = [syntax[@"xcode.syntax.attribute"] xcodeColor];
  result.characterColor  = [syntax[@"xcode.syntax.character"] xcodeColor];
  result.numberColor     = [syntax[@"xcode.syntax.number"] xcodeColor];

  result.constantColor   = [syntax[@"xcode.syntax.identifier.constant"] xcodeColor];
  result.variableColor   = [syntax[@"xcode.syntax.identifier.variable"] xcodeColor];
  result.functionColor   = [syntax[@"xcode.syntax.identifier.function"] xcodeColor];
  result.macroColor      = [syntax[@"xcode.syntax.identifier.macro"] xcodeColor];
  result.typeColor       = [syntax[@"xcode.syntax.identifier.type"] xcodeColor];
  result.classColor      = [syntax[@"xcode.syntax.identifier.class"] xcodeColor];

  result.DSLKeywordColor = result.keywordColor;

  // Automatically adjust the color of the cursor to the background
  // TODO: move to TextView?
#if !TARGET_OS_IPHONE
  if (!result.cursorColor || [result.cursorColor isEqualTo:RGB(0.f, 0.f, 0.f)]) {
    CGFloat r, b, g;
    [result.backgroundColor getRed:&r green:&g blue:&b alpha:NULL];
    CGFloat average = (r + b + g) /3.f;
    if (average > 0.5) {
      result.cursorColor = [NSColor blackColor];
    } else {
      result.cursorColor = [NSColor whiteColor];
    }
  }
#endif

  return result;
}

@end

///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------

@implementation NSString (DSSyntaxTheme)
- (UINSColor*)xcodeColor {
  NSScanner *scanner = [NSScanner scannerWithString:self];
  float r, b, g, a;
  [scanner scanFloat:&r];
  [scanner scanFloat:&g];
  [scanner scanFloat:&b];
  [scanner scanFloat:&a];

#if TARGET_OS_IPHONE
  return [UIColor colorWithRed:r green:g blue:b alpha:a];
#else
  return [NSColor colorWithCalibratedRed:r green:g blue:b alpha:a];
#endif
}

@end


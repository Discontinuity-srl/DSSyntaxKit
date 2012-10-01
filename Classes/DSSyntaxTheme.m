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

@implementation UINSColor (DSSyntaxTheme)

+ (UINSColor*)colorFromString:(NSString*)string {
  if (!string) {
    return nil;
  }
  NSScanner *scanner = [NSScanner scannerWithString:string];
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

@implementation DSSyntaxTheme

#pragma mark - Initialization

- (id)init {
  self = [super init];

  if (self) {
    _plainTextColor  = RGB(255.f, 255.f, 255.f);
    _backgroundColor = RGB(0.f, 0.f, 0.f);
  }
  return self;
}

- (UINSColor*)colorForType:(NSString*)type {
  NSString *key = [type stringByAppendingString:@"Color"];
  UINSColor *color = [self valueForKey:key];
  if (!color) {
    color = _plainTextColor;
  }
  return color;
}

+ (id)defaultTheme {
  DSSyntaxTheme *result = [[[self class] alloc] init];

  result.plainTextColor              =  [UINSColor blackColor];
  result.backgroundColor             =  [UINSColor whiteColor];
  result.cursorColor                 =  [UINSColor blackColor];
  result.commentColor                =  RGB(128.f, 128.f, 128.f);
  result.stringColor                 =  RGB(211.f, 045.f, 038.f);
  result.keywordColor                =  RGB(188.f, 049.f, 156.f);
  result.instanceVariableColor       =  RGB(63, 110, 116);

  result.constantColor              =  result.instanceVariableColor;

//  result.documentationCommentColor   =  RGB(000.f, 131.f, 039.f);
//  result.documentationCommentKeyword =  RGB(000.f, 076.f, 029.f);
//  result.characterColor              =  RGB(040.f, 052.f, 206.f);
//  result.numberColor                 =  RGB(040.f, 052.f, 206.f);
//  result.preprocessorColor           =  RGB(120.f, 072.f, 048.f);
//  result.urlColor                    =  RGB(021.f, 067.f, 244.f);
//  result.attributeColor              =  RGB(150.f, 125.f, 065.f);
//  result.projectColor                =  RGB(077.f, 129.f, 134.f);
//  result.otherColor                  =  RGB(113.f, 065.f, 163.f);

  return result;
}

+ (id)themeWithXcodeTheme:(NSString*)path {
  DSSyntaxTheme *result = [[[self class] alloc] init];

  NSDictionary* root = [NSDictionary dictionaryWithContentsOfFile:path];
  result.backgroundColor = [UINSColor colorFromString:root[@"DVTSourceTextBackground"]];
  result.cursorColor     = [UINSColor colorFromString:root[@"DVTSourceTextInsertionPointColor"]];
  result.selectionColor  = [UINSColor colorFromString:root[@"DVTSourceTextSelectionColor"]];

  NSDictionary* syntax = root[@"DVTSourceTextSyntaxColors"];
  result.plainTextColor        = [UINSColor colorFromString:syntax[@"xcode.syntax.plain"]];
  result.commentColor          = [UINSColor colorFromString:syntax[@"xcode.syntax.comment"]];
  result.commentKeywordColor   = [UINSColor colorFromString:syntax[@"xcode.syntax.comment.doc.keyword"]];
  result.stringColor           = [UINSColor colorFromString:syntax[@"xcode.syntax.string"]];
  result.keywordColor          = [UINSColor colorFromString:syntax[@"xcode.syntax.keyword"]];
  result.constantColor         = [UINSColor colorFromString:syntax[@"xcode.syntax.identifier.constant"]];
  result.instanceVariableColor = [UINSColor colorFromString:syntax[@"xcode.syntax.identifier.variable"]];

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

//  <key>xcode.syntax.attribute</key>
//  <key>xcode.syntax.character</key>
//  <key>xcode.syntax.identifier.class</key>
//  <key>xcode.syntax.identifier.constant</key>
//  <key>xcode.syntax.identifier.function</key>
//  <key>xcode.syntax.identifier.macro</key>
//  <key>xcode.syntax.identifier.type</key>
//  <key>xcode.syntax.number</key>
//  <key>xcode.syntax.preprocessor</key>
//	</dict>
}











@end

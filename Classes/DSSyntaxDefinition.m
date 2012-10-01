//
//  DSSyntaxDefinition.m
//  DSCodeTextViewDemo
//
//  Created by Fabio Pelosin on 26/09/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#import "DSSyntaxDefinition.h"
#import "BlocksKit.h"
#import "NSString+Conding.h"

NSString *const DSSyntaxDefinitionAttributeName = @"DSSyntaxDefinitionAttributeName";

NSString *const kDSCommentSyntaxType          = @"comment";
NSString *const kDSCommentKeywordSyntaxType   = @"commentKeyword";
NSString *const kDSStringSyntaxType           = @"string";
NSString *const kDSKeywordSyntaxType          = @"keyword";

NSString *const kDSInstanceVariableSyntaxType = @"instanceVariable";
NSString *const kDSConstantSyntaxType         = @"constant";

NSString *const kDSLKeywordSyntaxType         = @"DSLKeyword";

@implementation DSSyntaxDefinition

- (NSAttributedString*)parseString:(NSString*)code {
  NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:code];
  [self performParsingWithString:attributed];
  _code = attributed;
  return attributed;
}

- (void)performParsingWithString:(NSMutableAttributedString*)attributed {
  [self performRegExBasedParsingWithString:attributed words:self.keywords type:kDSKeywordSyntaxType];
  [self performRegExBasedParsingWithString:attributed words:@[@"[A-Z]\\w*"] type:kDSConstantSyntaxType];
  [self performRegExBasedParsingWithString:attributed words:@[@":\\w+"] type:kDSConstantSyntaxType];
  [self performRegExBasedParsingWithString:attributed words:@[@"@\\w+"] type:kDSInstanceVariableSyntaxType];

  // TODO: strings need to support escaping
  // TODO: strings need to support interpolation
  [self performRegExBasedParsingWithString:attributed words:@[@"\".*?\""] type:kDSStringSyntaxType];
  [self performRegExBasedParsingWithString:attributed words:@[@"'.*?'"] type:kDSStringSyntaxType];

  // TODO: fix comments in strings
  [self performRegExBasedParsingWithString:attributed words:@[@"#.*?\n"] type:kDSCommentSyntaxType];
  [self performAdvancedParsingWithString:attributed];

  // TODO: comments keywords
}

- (void)performAdvancedParsingWithString:(NSMutableAttributedString*)attributed {
  //  NSScanner *scanner = [NSScanner scannerWithString:code];
  //  [scanner setCharactersToBeSkipped:nil];
  //  NSCharacterSet *startCharacters  = [NSCharacterSet characterSetWithCharactersInString:@"\"/"];
}

- (void)performRegExBasedParsingWithString:(NSMutableAttributedString*)attributed
                                     words:(NSArray*)words type:(NSString*)type {
  if (!words || words.count == 0) {
    return;
  }
  
  NSRange range = NSMakeRange(0, attributed.length);
  NSMutableString *expression = [NSMutableString new];
  [expression appendString:@"(?<!\\w)("];
  [expression appendString:[words componentsJoinedByString:@"|"]];
  [expression appendString:@")(?!\\w)"];
  NSRegularExpression *regex = [NSRegularExpression
                                regularExpressionWithPattern:expression
                                options:NSRegularExpressionDotMatchesLineSeparators | NSRegularExpressionAnchorsMatchLines
                                error:nil];
  NSArray* matches = [regex matchesInString:attributed.string options:0 range:range];
  for(NSTextCheckingResult* match in matches) {
    [attributed addAttribute:DSSyntaxDefinitionAttributeName value:type range:match.range];
  }
}

- (NSString*)completionForNewLineAfterLine:(NSString*)line indentation:(NSString*)indentation {
  NSString *match = [line matchForPattern:@"def[[\\t\\p{Zs}]]*\\W+"];
  if ([match isValid]) {
    return [NSString stringWithFormat:@"%@  \n%@end", indentation, indentation];
  }
  return @"";
}

- (NSArray *)completionsForPartialWordRange:(NSRange)charRange indexOfSelectedItem:(NSInteger *)index {
  return @[@"test", @"tesr2"];
}

@end


































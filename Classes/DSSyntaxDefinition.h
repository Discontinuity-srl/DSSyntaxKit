//
//  DSSyntaxDefinition.h
//  DSCodeTextViewDemo
//
//  Created by Fabio Pelosin on 26/09/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const DSSyntaxDefinitionAttributeName;

FOUNDATION_EXPORT NSString *const kDSPlainTextSyntaxType;
FOUNDATION_EXPORT NSString *const kDSCommentSyntaxType;
FOUNDATION_EXPORT NSString *const kDSCommentKeywordSyntaxType;
FOUNDATION_EXPORT NSString *const kDSStringSyntaxType;
FOUNDATION_EXPORT NSString *const kDSKeywordSyntaxType;
FOUNDATION_EXPORT NSString *const kDSInstanceVariableSyntaxType;
FOUNDATION_EXPORT NSString *const kDSLKeywordSyntaxType;

@interface DSSyntaxDefinition : NSObject

@property (nonatomic, copy) NSAttributedString* code;

@property (nonatomic, copy) NSArray *keywords;
@property (nonatomic, copy) NSArray *delimiters;
@property (nonatomic, copy) NSArray *dslKeywords;

- (NSAttributedString*)parseString:(NSString*)code;

- (NSString*)completionForNewLineAfterLine:(NSString*)line indentation:(NSString*)indentation;
- (NSArray *)completionsForPartialWordRange:(NSRange)charRange indexOfSelectedItem:(NSInteger *)index;

@end

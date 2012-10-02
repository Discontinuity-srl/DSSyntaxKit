//
//  DSSyntaxTheme.h
//  DSSyntaxKit
//
//  Created by Fabio Pelosin on 26/09/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#if TARGET_OS_IPHONE
  #define UINSColor   UIColor
#else
  #define UINSColor   NSColor
#endif

#import <Foundation/Foundation.h>

/** A DSSyntaxTheme provides color information for syntax coloring. It's 
 properties striclty match the possbile values of DSSyntaxTypeAttribute
 defined by DSSyntaxDefinition. */
@interface DSSyntaxTheme : NSObject

///-----------------------------------------------------------------------------
/// @name Background & Context
///-----------------------------------------------------------------------------

@property (nonatomic, copy) UINSColor* backgroundColor;
@property (nonatomic, copy) UINSColor* cursorColor;
@property (nonatomic, copy) UINSColor* selectionColor;

///-----------------------------------------------------------------------------
/// @name Basic Values
///-----------------------------------------------------------------------------

@property (nonatomic, copy) UINSColor* plainTextColor;
@property (nonatomic, copy) UINSColor* commentColor;
@property (nonatomic, copy) UINSColor* stringColor;
@property (nonatomic, copy) UINSColor* keywordColor;

///-----------------------------------------------------------------------------
/// @name Advanced Values
///-----------------------------------------------------------------------------

@property (nonatomic, copy) UINSColor* typeColor;
@property (nonatomic, copy) UINSColor* classColor;
@property (nonatomic, copy) UINSColor* constantColor;
@property (nonatomic, copy) UINSColor* variableColor;
@property (nonatomic, copy) UINSColor* attributeColor;
@property (nonatomic, copy) UINSColor* functionColor;
@property (nonatomic, copy) UINSColor* characterColor;
@property (nonatomic, copy) UINSColor* numberColor;
@property (nonatomic, copy) UINSColor* macroColor;

///-----------------------------------------------------------------------------
/// @name Domain Specific Languages Values
///-----------------------------------------------------------------------------

@property (nonatomic, copy) UINSColor* DSLKeywordColor;

///-----------------------------------------------------------------------------
/// @name Initialization & disposal
///-----------------------------------------------------------------------------

/* Returns a barebone theme. */
- (id)init;

/* @return a default theme (similar to the default theme of Xcode). */
+ (id)defaultTheme;

/* @return a theme initialized with an Xcode theme (.dvtcolortheme files) */
+ (id)themeWithXcodeTheme:(NSString*)path;

///-----------------------------------------------------------------------------
/// @name Integration with DSSyntaxDefinition
///-----------------------------------------------------------------------------

/* @return a color for a given DSSyntaxTypeAttribute. Even if the theme doesn't
 specifies a color for the given key, one is always returned. */
- (UINSColor*)colorForType:(NSString*)type;

/* Convert a string with DSSyntaxDefinitionAttribute to attributed string with
 the theme foreground colors. */
//- (NSAttributedString*)syntaxHighlightedStringForString:(NSAttributedString*);

@end

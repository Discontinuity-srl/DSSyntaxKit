//
//  DSSyntaxTheme.h
//  DSCodeTextViewDemo
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

@interface DSSyntaxTheme : NSObject

///-----------------------------------------------------------------------------
/// @name Background
///-----------------------------------------------------------------------------

@property (nonatomic, copy) UINSColor* backgroundColor;
@property (nonatomic, copy) UINSColor* cursorColor;
@property (nonatomic, copy) UINSColor* selectionColor;

///-----------------------------------------------------------------------------
/// @name Basic Values
///-----------------------------------------------------------------------------

@property (nonatomic, copy) UINSColor* plainTextColor;
@property (nonatomic, copy) UINSColor* commentColor;
@property (nonatomic, copy) UINSColor* commentKeywordColor;
@property (nonatomic, copy) UINSColor* stringColor;
@property (nonatomic, copy) UINSColor* keywordColor;

///-----------------------------------------------------------------------------
/// @name Advanced Values
///-----------------------------------------------------------------------------

//@property (nonatomic, copy) UINSColor* charactersColor;
//@property (nonatomic, copy) UINSColor* numbersColor;
//@property (nonatomic, copy) UINSColor* preprocessorColor;
//@property (nonatomic, copy) UINSColor* attributesColor;
//@property (nonatomic, copy) UINSColor* functionsColor;
@property (nonatomic, copy) UINSColor* constantColor;
//@property (nonatomic, copy) UINSColor* typeNamesColor;
@property (nonatomic, copy) UINSColor* instanceVariableColor;

///-----------------------------------------------------------------------------
/// @name DSL Values
///-----------------------------------------------------------------------------

@property (nonatomic, copy) UINSColor* DSLKeywordColor;

///-----------------------------------------------------------------------------
/// @name Initialization & disposal
///-----------------------------------------------------------------------------

- (id)init;
+ (id)defaultTheme;
+ (id)themeWithXcodeTheme:(NSString*)path;

///-----------------------------------------------------------------------------
/// @name Integration with DSSyntaxDefinitionAttributeName
///-----------------------------------------------------------------------------

- (UINSColor*)colorForType:(NSString*)type;



@end

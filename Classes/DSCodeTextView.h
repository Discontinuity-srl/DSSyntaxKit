//
//  DSCodeTextView.h
//  DSCodeTextViewDemo
//
//  Created by Fabio Pelosin on 25/09/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DSCodeSyntaxHighlighter.h"


@interface DSCodeTextView : NSTextView

///-----------------------------------------------------------------------------
/// @name Syntax Highlighter
///-----------------------------------------------------------------------------

/** The syntax highlighter used by the text view. */
@property (nonatomic, readonly) DSCodeSyntaxHighlighter* syntaxHighlighter;

/** The color theme used by the syntax highlighter. */
@property (nonatomic, strong) DSSyntaxTheme *theme;

/** The syntax definition used by the syntax highlighter. */
@property (nonatomic, strong) DSSyntaxDefinition *syntaxDefinition;



///-----------------------------------------------------------------------------
/// @name Code editing options
///-----------------------------------------------------------------------------

/** Indicates if the line number ruler is visible. */
- (void)setLineNumbersVisible:(BOOL)visible;

/** The number of spaces for tab expansion. A value of 0 indicates no tab 
    expansion. */
@property (nonatomic) NSInteger tabWidth;

@end

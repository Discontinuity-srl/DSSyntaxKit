//
//  DSSyntaxTextView.m
//  DSSyntaxKit
//
//  Created by Fabio Pelosin on 25/09/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#import "DSSyntaxTextView.h"
#import "BlocksKit.h"
#import "NSString+DSCategory.h"

@implementation DSSyntaxTextView

///-----------------------------------------------------------------------------
#pragma mark - Initialization
///-----------------------------------------------------------------------------

- (id)initWithFrame:(NSRect)frame {
  self = [super initWithFrame:frame];
  if (self) { [self commonInitialization]; }
  return self;
}

- (void)awakeFromNib {
  [self commonInitialization];
}

- (void)commonInitialization {
  [self setGrammarCheckingEnabled:FALSE];
  [self setContinuousSpellCheckingEnabled:FALSE];
  [self setRichText:FALSE];
  [self setImportsGraphics:FALSE];
  [self setAutomaticDashSubstitutionEnabled:FALSE];
  [self setAutomaticTextReplacementEnabled:FALSE];
  [self setAutomaticSpellingCorrectionEnabled:FALSE];
  [self setAutomaticQuoteSubstitutionEnabled:FALSE];
  
  [self setUsesFindBar:TRUE];
  [self setAutomaticLinkDetectionEnabled:TRUE];
  [self setTabWidth:2];

  NSScrollView *scrollView = [self enclosingScrollView];
  _lineNumberView = [[NoodleLineNumberView alloc] initWithScrollView:scrollView];
  [scrollView setVerticalRulerView:_lineNumberView];
  [scrollView setHasHorizontalRuler:NO];
  [scrollView setHasVerticalRuler:YES];

  [self setHorizontallyResizable:YES];

  [scrollView setHasHorizontalScroller:TRUE];

  NSTextStorage* contents = self.textStorage;
  _syntaxHighlighter = [[DSSyntaxHighlighter alloc]
                        initWithTextStorage:contents];
  [self setFont:[NSFont userFixedPitchFontOfSize:12.f]];
}

///-----------------------------------------------------------------------------
#pragma mark - Properties
///-----------------------------------------------------------------------------

- (DSSyntaxDefinition *)syntaxDefinition {
  return _syntaxHighlighter.syntaxDefinition;
}

- (void)setSyntaxDefinition:(DSSyntaxDefinition *)syntaxDefinition {
  [_syntaxHighlighter setSyntaxDefinition:syntaxDefinition];
  [self setNeedsDisplay:TRUE];
}

- (DSSyntaxTheme *)theme {
  return _syntaxHighlighter.theme;
}

- (void)setTheme:(DSSyntaxTheme *)theme {
  [self setBackgroundColor:theme.backgroundColor];
  [self setInsertionPointColor:theme.cursorColor];
  [self setSelectedTextAttributes: @{ NSBackgroundColorAttributeName :
                                      theme.selectionColor }];
  [_syntaxHighlighter setTheme:theme];
  [self setNeedsDisplay:TRUE];
}

- (void)setLineNumbersVisible:(BOOL)visible {
  NSScrollView *scrollView = [self enclosingScrollView];
  [scrollView setRulersVisible:visible];
}

///-----------------------------------------------------------------------------
#pragma mark - Insertions
///-----------------------------------------------------------------------------

- (void)setString:(NSString *)string {
  [super setString:string];
}

- (void)configureContainer {
  [[self textContainer] setContainerSize:NSMakeSize(FLT_MAX, FLT_MAX)];
  [[self textContainer] setWidthTracksTextView:NO];
}

- (void)setTextContainer:(NSTextContainer *)container {
  [super setTextContainer:container];
  [self configureContainer];
}

// TODO: this shold not be here.
- (void)insertNewline:(id)sender {
  NSString* string = self.textStorage.string;
  NSRange insertionRange = [[[self selectedRanges] objectAtIndex:0] rangeValue];
  NSRange lineRange = [string lineRangeForRange:insertionRange];
  NSString *previousLine = [string substringWithRange:lineRange];

  NSRange nextCharRange = NSMakeRange(insertionRange.location, 1);
  NSString *nextChar = [string substringWithRange:nextCharRange];
  BOOL isRangeAtEndOfLine = [nextChar isEqualToString:@"\n"];

  [super insertNewline:sender];
  [self insertText:[previousLine indentation]];

  NSRange newCursorRange = [[[self selectedRanges] objectAtIndex:0] rangeValue];
  if (isRangeAtEndOfLine) {
    NSString *completion = [self.syntaxDefinition completionForNewLineAfterLine:previousLine
                                                                    indentation:[previousLine indentation]];
    if (completion) {
      [self insertText:completion];
    }
  }
  [self setSelectedRange:newCursorRange];
}

- (NSString*)partialLineToCursorPosition {
  NSString* string    = self.textStorage.string;
  NSRange cursorRange = [[[self selectedRanges] objectAtIndex:0] rangeValue];
  NSRange lineRange   = [string lineRangeForRange:cursorRange];
  lineRange.length = cursorRange.location - lineRange.location;
  return [string substringWithRange:lineRange];
}

- (NSArray *)completionsForPartialWordRange:(NSRange)charRange
                        indexOfSelectedItem:(NSInteger *)index {
  
  NSString *partialWord = [self.string substringWithRange:charRange];
  NSString *partialLine = [self partialLineToCursorPosition];
  return [self.syntaxDefinition completionsForPartialWord:partialWord
                                              partialLine:partialLine
                                      indexOfSelectedItem:index];
}

- (void)insertTab:(id)sender {
  if (_tabWidth) {
    NSMutableString *indent = [NSMutableString new];
    for (NSUInteger i = 0; i < _tabWidth; i++) {
      [indent appendString:@" "];
    }
    [self insertText:indent];
  } else {
    [super insertTab:sender];
  }
  // insert spaces
  // move to auto completion
}


@end









#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import <string.h>
#import <stdlib.h>
#import "window.h"

typedef struct string {
  char *str;
  int len;
  int is_lit;
} string;

typedef struct main__WindowParams {
  string title;
  int width;
  int height;
  void *win_ptr;
  int padding;
  int spacing;
  int always_on_top;
  int responsive_layout;
  int resizable;
  int minimizable;
  int maximizable;
} main__WindowParams;

typedef struct main__WindowInfo {
  void *app;
  void *app_delegate;
} main__WindowInfo;

static NSString *nsstring(const char *s) {
  if (!s) {
    s = "";
  }
  return [[NSString alloc] initWithBytes:s length:strlen(s) encoding:NSUTF8StringEncoding];
}

@interface FlippedStackView : NSStackView
@end

extern void vlang_dispatch_event(void *win_ptr, const char *name, const char *event, const char *value);

@implementation FlippedStackView
- (BOOL)isFlipped {
  return YES;
}
@end

@interface DropZoneView : NSBox
@property (nonatomic, assign) void *win_ptr;
@property (nonatomic, copy) NSString *controlName;
@end

@implementation DropZoneView
- (void)awakeFromNib {
  [super awakeFromNib];
  [self registerForDraggedTypes:@[NSPasteboardTypeFileURL]];
}

- (void)updateTrackingAreas {
  [super updateTrackingAreas];
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
  NSPasteboard *pboard = [sender draggingPasteboard];
  if ([[pboard types] containsObject:NSPasteboardTypeFileURL]) {
    return NSDragOperationCopy;
  }
  return NSDragOperationNone;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
  NSPasteboard *pboard = [sender draggingPasteboard];
  if ([[pboard types] containsObject:NSPasteboardTypeFileURL]) {
    NSArray *urls = [pboard readObjectsForClasses:@[[NSURL class]] options:nil];
    NSMutableArray *paths = [NSMutableArray array];
    for (NSURL *url in urls) {
      [paths addObject:[url path]];
    }
    if (self.win_ptr && self.controlName) {
      NSString *joinedPaths = [paths componentsJoinedByString:@"|"];
      vlang_dispatch_event(self.win_ptr, [self.controlName UTF8String], "file_drop", [joinedPaths UTF8String]);
    }
    return YES;
  }
  return NO;
}
@end

@interface ModernTextFieldCell : NSTextFieldCell
@end

@implementation ModernTextFieldCell
- (NSRect)drawingRectForBounds:(NSRect)rect {
  NSRect titleRect = [super drawingRectForBounds:rect];
  CGFloat horizontalPadding = 10.0;
  CGFloat verticalPadding = (titleRect.size.height - 18.0) / 2.0;
  if (verticalPadding < 0) verticalPadding = 2.0;
  return NSMakeRect(titleRect.origin.x + horizontalPadding,
                    titleRect.origin.y + verticalPadding,
                    titleRect.size.width - (horizontalPadding * 2.0),
                    titleRect.size.height - (verticalPadding * 2.0));
}
- (void)selectWithFrame:(NSRect)rect inView:(NSView *)controlView editor:(NSText *)textObj delegate:(id)anObject start:(NSInteger)selStart length:(NSInteger)selLength {
  NSRect textFrame = [self drawingRectForBounds:rect];
  [super selectWithFrame:textFrame inView:controlView editor:textObj delegate:anObject start:selStart length:selLength];
}
- (void)editWithFrame:(NSRect)rect inView:(NSView *)controlView editor:(NSText *)textObj delegate:(id)anObject event:(NSEvent *)theEvent {
  NSRect textFrame = [self drawingRectForBounds:rect];
  [super editWithFrame:textFrame inView:controlView editor:textObj delegate:anObject event:theEvent];
}
@end

@interface ModernSecureTextFieldCell : NSSecureTextFieldCell
@end

@implementation ModernSecureTextFieldCell
- (NSRect)drawingRectForBounds:(NSRect)rect {
  NSRect titleRect = [super drawingRectForBounds:rect];
  CGFloat horizontalPadding = 10.0;
  CGFloat verticalPadding = (titleRect.size.height - 18.0) / 2.0;
  if (verticalPadding < 0) verticalPadding = 2.0;
  return NSMakeRect(titleRect.origin.x + horizontalPadding,
                    titleRect.origin.y + verticalPadding,
                    titleRect.size.width - (horizontalPadding * 2.0),
                    titleRect.size.height - (verticalPadding * 2.0));
}
- (void)selectWithFrame:(NSRect)rect inView:(NSView *)controlView editor:(NSText *)textObj delegate:(id)anObject start:(NSInteger)selStart length:(NSInteger)selLength {
  NSRect textFrame = [self drawingRectForBounds:rect];
  [super selectWithFrame:textFrame inView:controlView editor:textObj delegate:anObject start:selStart length:selLength];
}
- (void)editWithFrame:(NSRect)rect inView:(NSView *)controlView editor:(NSText *)textObj delegate:(id)anObject event:(NSEvent *)theEvent {
  NSRect textFrame = [self drawingRectForBounds:rect];
  [super editWithFrame:textFrame inView:controlView editor:textObj delegate:anObject event:theEvent];
}
@end

@interface ModernTextField : NSTextField
@end

@implementation ModernTextField
- (instancetype)initWithFrame:(NSRect)frameRect {
  self = [super initWithFrame:frameRect];
  if (self) {
    ModernTextFieldCell *cell = [[ModernTextFieldCell alloc] init];
    [cell setEditable:YES];
    [cell setSelectable:YES];
    [cell setScrollable:YES];
    [cell setDrawsBackground:YES];
    self.cell = cell;
    self.wantsLayer = YES;
    self.layer.cornerRadius = 8.0;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [NSColor separatorColor].CGColor;
    self.focusRingType = NSFocusRingTypeNone;
  }
  return self;
}
- (void)layout {
  [super layout];
  NSColor *bgColor = self.backgroundColor ?: [NSColor textBackgroundColor];
  self.layer.backgroundColor = bgColor.CGColor;
  BOOL hasFocus = NO;
  if (self.window && self.window.firstResponder) {
    id responder = self.window.firstResponder;
    if ([responder isKindOfClass:[NSView class]] && [(NSView *)responder isDescendantOf:self]) {
      hasFocus = YES;
    }
  }
  if (hasFocus) {
    self.layer.borderColor = [NSColor controlAccentColor].CGColor;
    self.layer.borderWidth = 1.5;
  } else {
    self.layer.borderColor = [NSColor separatorColor].CGColor;
    self.layer.borderWidth = 1.0;
  }
}
- (BOOL)becomeFirstResponder {
  BOOL result = [super becomeFirstResponder];
  [self setNeedsLayout:YES];
  return result;
}
- (BOOL)resignFirstResponder {
  BOOL result = [super resignFirstResponder];
  [self setNeedsLayout:YES];
  return result;
}
@end

@interface ModernSecureTextField : NSSecureTextField
@end

@implementation ModernSecureTextField
- (instancetype)initWithFrame:(NSRect)frameRect {
  self = [super initWithFrame:frameRect];
  if (self) {
    ModernSecureTextFieldCell *cell = [[ModernSecureTextFieldCell alloc] init];
    [cell setEditable:YES];
    [cell setSelectable:YES];
    [cell setScrollable:YES];
    [cell setDrawsBackground:YES];
    self.cell = cell;
    self.wantsLayer = YES;
    self.layer.cornerRadius = 8.0;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [NSColor separatorColor].CGColor;
    self.focusRingType = NSFocusRingTypeNone;
  }
  return self;
}
- (void)layout {
  [super layout];
  NSColor *bgColor = self.backgroundColor ?: [NSColor textBackgroundColor];
  self.layer.backgroundColor = bgColor.CGColor;
  BOOL hasFocus = NO;
  if (self.window && self.window.firstResponder) {
    id responder = self.window.firstResponder;
    if ([responder isKindOfClass:[NSView class]] && [(NSView *)responder isDescendantOf:self]) {
      hasFocus = YES;
    }
  }
  if (hasFocus) {
    self.layer.borderColor = [NSColor controlAccentColor].CGColor;
    self.layer.borderWidth = 1.5;
  } else {
    self.layer.borderColor = [NSColor separatorColor].CGColor;
    self.layer.borderWidth = 1.0;
  }
}
- (BOOL)becomeFirstResponder {
  BOOL result = [super becomeFirstResponder];
  [self setNeedsLayout:YES];
  return result;
}
- (BOOL)resignFirstResponder {
  BOOL result = [super resignFirstResponder];
  [self setNeedsLayout:YES];
  return result;
}
@end

@interface ModernSearchFieldCell : NSSearchFieldCell
@end

@implementation ModernSearchFieldCell
- (NSRect)drawingRectForBounds:(NSRect)rect {
  NSRect titleRect = [super drawingRectForBounds:rect];
  CGFloat horizontalPadding = 0.0;
  CGFloat verticalPadding = (titleRect.size.height - 18.0) / 2.0;
  if (verticalPadding < 0) verticalPadding = 2.0;
  return NSMakeRect(titleRect.origin.x + horizontalPadding,
                    titleRect.origin.y + verticalPadding,
                    titleRect.size.width - (horizontalPadding * 2.0),
                    titleRect.size.height - (verticalPadding * 2.0));
}
- (void)selectWithFrame:(NSRect)rect inView:(NSView *)controlView editor:(NSText *)textObj delegate:(id)anObject start:(NSInteger)selStart length:(NSInteger)selLength {
  NSRect textFrame = [self drawingRectForBounds:rect];
  [super selectWithFrame:textFrame inView:controlView editor:textObj delegate:anObject start:selStart length:selLength];
}
- (void)editWithFrame:(NSRect)rect inView:(NSView *)controlView editor:(NSText *)textObj delegate:(id)anObject event:(NSEvent *)theEvent {
  NSRect textFrame = [self drawingRectForBounds:rect];
  [super editWithFrame:textFrame inView:controlView editor:textObj delegate:anObject event:theEvent];
}
@end

@interface ModernSearchField : NSSearchField
@end

@implementation ModernSearchField
- (instancetype)initWithFrame:(NSRect)frameRect {
  self = [super initWithFrame:frameRect];
  if (self) {
    ModernSearchFieldCell *cell = [[ModernSearchFieldCell alloc] init];
    [cell setEditable:YES];
    [cell setSelectable:YES];
    [cell setScrollable:YES];
    [cell setDrawsBackground:YES];
    self.cell = cell;
    self.wantsLayer = YES;
    self.layer.cornerRadius = 8.0;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [NSColor separatorColor].CGColor;
    self.focusRingType = NSFocusRingTypeNone;
    
    // Bind the clear/cancel button cell to trigger the event action
    NSButtonCell *cancelButtonCell = [cell cancelButtonCell];
    [cancelButtonCell setTarget:self];
    [cancelButtonCell setAction:@selector(handleCancelButtonClicked:)];
  }
  return self;
}

- (void)handleCancelButtonClicked:(id)sender {
  [self setStringValue:@""];
  [self resignFirstResponder];
  if (self.target && self.action) {
    [self sendAction:self.action to:self.target];
  }
}

- (void)layout {
  [super layout];
  NSColor *bgColor = self.backgroundColor ?: [NSColor textBackgroundColor];
  self.layer.backgroundColor = bgColor.CGColor;
  BOOL hasFocus = NO;
  if (self.window && self.window.firstResponder) {
    id responder = self.window.firstResponder;
    if ([responder isKindOfClass:[NSView class]] && [(NSView *)responder isDescendantOf:self]) {
      hasFocus = YES;
    }
  }
  if (hasFocus) {
    self.layer.borderColor = [NSColor controlAccentColor].CGColor;
    self.layer.borderWidth = 1.5;
  } else {
    self.layer.borderColor = [NSColor separatorColor].CGColor;
    self.layer.borderWidth = 1.0;
  }
}
- (BOOL)becomeFirstResponder {
  BOOL result = [super becomeFirstResponder];
  [self setNeedsLayout:YES];
  return result;
}
- (BOOL)resignFirstResponder {
  BOOL result = [super resignFirstResponder];
  [self setNeedsLayout:YES];
  return result;
}
@end

@interface TreeItem : NSObject
@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) TreeItem *parent;
@property (nonatomic, retain) NSMutableArray<TreeItem *> *children;
@end

@implementation TreeItem
- (instancetype)init {
  self = [super init];
  if (self) {
    _children = [[NSMutableArray alloc] init];
  }
  return self;
}
- (void)dealloc {
  [_itemId release];
  [_text release];
  [_children release];
  [super dealloc];
}
@end

@interface AppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate, NSTextFieldDelegate, NSTextViewDelegate, NSTableViewDataSource, NSTableViewDelegate, NSOutlineViewDataSource, NSOutlineViewDelegate>
@property (nonatomic, assign) main__WindowParams params;
@property (nonatomic, assign) void *win_ptr;
@property (nonatomic, strong) NSWindow *window;
@property (nonatomic, strong) NSWindowController *windowController;
@property (nonatomic, strong) NSScrollView *scrollView;
@property (nonatomic, strong) NSStackView *mainStackView;
@property (nonatomic, strong) NSStackView *currentRowStack;
@property (nonatomic, strong) NSMutableDictionary *controlsByName;
@property (nonatomic, strong) NSMutableDictionary *listItemsByName;
@property (nonatomic, strong) NSMutableDictionary *tableItemsByName;
@property (nonatomic, strong) NSMutableDictionary *treeItemsByName;
@property (nonatomic, strong) NSColor *currentBackgroundColor;
@property (nonatomic, strong) NSColor *currentFontColor;
@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) NSMenu *statusBarMenu;
@property (nonatomic, assign) BOOL responsiveLayoutEnabled;

- (TreeItem *)findTreeItemWithId:(NSString *)targetId inItems:(NSArray<TreeItem *> *)items;
- (NSString *)nameForControl:(NSView *)control;
- (void)addControlToLayout:(NSView *)view;
- (void)beginRowWithName:(NSString *)name;
- (void)endRow;
- (void)applyColorsRecursively:(NSView *)view backgroundColor:(NSColor *)backgroundColor fontColor:(NSColor *)fontColor;
- (NSView *)makeLabelWithName:(NSString *)name text:(NSString *)text;
- (NSView *)makeTextFieldWithName:(NSString *)name value:(NSString *)value;
- (NSView *)makePasswordFieldWithName:(NSString *)name value:(NSString *)value;
- (NSView *)makeTextAreaWithName:(NSString *)name value:(NSString *)value;
- (NSView *)makeHtmlViewWithName:(NSString *)name html:(NSString *)html;
- (NSView *)makeDropZoneWithName:(NSString *)name label:(NSString *)label;
- (NSView *)makeButtonWithName:(NSString *)name title:(NSString *)title;
- (NSView *)makeCheckboxWithName:(NSString *)name label:(NSString *)label checked:(BOOL)checked;
- (NSView *)makeNumberFieldWithName:(NSString *)name value:(int)value;
- (NSView *)makeSliderWithName:(NSString *)name value:(int)value;
- (NSView *)makePopUpButtonWithName:(NSString *)name selected:(NSString *)selected;
- (NSView *)makeColorWellWithName:(NSString *)name color:(NSString *)colorString;
- (NSView *)makeDatePickerWithName:(NSString *)name date:(NSString *)dateString;
- (NSView *)makeSegmentedControlWithName:(NSString *)name selected:(NSString *)selected;
- (NSView *)makeProgressIndicatorWithName:(NSString *)name value:(int)value;
- (NSView *)makeDropdownWithName:(NSString *)name items:(NSArray<NSString *> *)items selected:(NSString *)selected;
- (NSView *)makeSegmentedControlWithName:(NSString *)name items:(NSArray<NSString *> *)items selected:(NSString *)selected;
- (NSView *)makeRadioGroupWithName:(NSString *)name items:(NSArray<NSString *> *)items selected:(NSString *)selected;
- (NSView *)makeSwitchWithName:(NSString *)name label:(NSString *)label checked:(BOOL)checked;
- (NSView *)makeSearchFieldWithName:(NSString *)name placeholder:(NSString *)placeholder;
- (NSView *)makeComboBoxWithName:(NSString *)name items:(NSArray<NSString *> *)items selected:(NSString *)selected;
- (NSView *)makeLevelIndicatorWithName:(NSString *)name style:(int)style minValue:(double)minValue maxValue:(double)maxValue value:(double)value;
- (NSView *)makeSpinnerWithName:(NSString *)name active:(BOOL)active;
- (NSView *)makePathControlWithName:(NSString *)name path:(NSString *)pathString;
- (NSView *)makeTokenFieldWithName:(NSString *)name value:(NSString *)value;
- (void)handleRadioChanged:(id)sender;
- (void)handleSwitchChanged:(id)sender;
- (void)setupMenuBar;
- (NSMenu *)findOrCreateMenuWithName:(NSString *)menuName;
- (void)handleMenuItemClicked:(id)sender;
@end

@interface CustomWindow : NSWindow
@end

@implementation CustomWindow
- (BOOL)performKeyEquivalent:(NSEvent *)event {
  NSEventModifierFlags flags = [event modifierFlags] & NSEventModifierFlagDeviceIndependentFlagsMask;
  if (flags == NSEventModifierFlagCommand) {
    NSString *chars = [event charactersIgnoringModifiers];
    if ([chars isEqualToString:@"q"]) {
      [NSApp terminate:self];
      return YES;
    } else if ([chars isEqualToString:@"f"]) {
      [self toggleFullScreen:nil];
      return YES;
    }
  }
  return [super performKeyEquivalent:event];
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
  NSPasteboard *pboard = [sender draggingPasteboard];
  if ([[pboard types] containsObject:NSPasteboardTypeFileURL]) {
    return NSDragOperationCopy;
  }
  return NSDragOperationNone;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
  NSPasteboard *pboard = [sender draggingPasteboard];
  if ([[pboard types] containsObject:NSPasteboardTypeFileURL]) {
    NSArray *urls = [pboard readObjectsForClasses:@[[NSURL class]] options:nil];
    NSMutableArray *paths = [NSMutableArray array];
    for (NSURL *url in urls) {
      [paths addObject:[url path]];
    }
    AppDelegate *delegate = (AppDelegate *)self.delegate;
    if (delegate && delegate.win_ptr) {
      NSString *joinedPaths = [paths componentsJoinedByString:@"|"];
      vlang_dispatch_event(delegate.win_ptr, "window", "file_drop", [joinedPaths UTF8String]);
    }
    return YES;
  }
  return NO;
}
@end

static NSColor *colorFromString(const char *colorString) {
  if (!colorString || !*colorString) {
    return [NSColor controlAccentColor];
  }

  NSString *value = nsstring(colorString);
  NSString *normalized = [[value lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

  if ([normalized isEqualToString:@"black"]) return [NSColor blackColor];
  if ([normalized isEqualToString:@"white"]) return [NSColor whiteColor];
  if ([normalized isEqualToString:@"red"]) return [NSColor systemRedColor];
  if ([normalized isEqualToString:@"green"]) return [NSColor systemGreenColor];
  if ([normalized isEqualToString:@"blue"]) return [NSColor systemBlueColor];
  if ([normalized isEqualToString:@"yellow"]) return [NSColor systemYellowColor];
  if ([normalized isEqualToString:@"orange"]) return [NSColor systemOrangeColor];
  if ([normalized isEqualToString:@"purple"]) return [NSColor systemPurpleColor];
  if ([normalized isEqualToString:@"gray"] || [normalized isEqualToString:@"grey"]) return [NSColor grayColor];
  if ([normalized isEqualToString:@"cyan"]) return [NSColor cyanColor];
  if ([normalized isEqualToString:@"magenta"]) return [NSColor magentaColor];

  if ([normalized hasPrefix:@"#"]) {
    NSString *hex = [normalized substringFromIndex:1];
    if ([hex length] == 3) {
      NSMutableString *expanded = [NSMutableString stringWithCapacity:6];
      for (NSUInteger i = 0; i < [hex length]; i++) {
        unichar ch = [hex characterAtIndex:i];
        [expanded appendFormat:@"%C%C", ch, ch];
      }
      hex = expanded;
    }
    if ([hex length] == 6) {
      const char *hexChars = [hex UTF8String];
      char *end = NULL;
      unsigned long value = strtoul(hexChars, &end, 16);
      if (end && *end == '\0') {
        CGFloat r = ((value >> 16) & 0xFF) / 255.0;
        CGFloat g = ((value >> 8) & 0xFF) / 255.0;
        CGFloat b = (value & 0xFF) / 255.0;
        return [NSColor colorWithCalibratedRed:r green:g blue:b alpha:1.0];
      }
    }
  }

  return [NSColor controlAccentColor];
}

static NSColor *modernAccentColor(void) {
  return [NSColor controlAccentColor];
}

static NSColor *modernSurfaceColor(void) {
  NSAppearance *appearance = [NSApp effectiveAppearance];
  if ([appearance bestMatchFromAppearancesWithNames:@[NSAppearanceNameDarkAqua, NSAppearanceNameAqua]] == NSAppearanceNameDarkAqua) {
    return [NSColor colorWithSRGBRed:0.095 green:0.10 blue:0.13 alpha:0.85];
  }
  return [NSColor colorWithSRGBRed:0.97 green:0.97 blue:0.985 alpha:0.85];
}

static NSColor *modernElevatedSurfaceColor(void) {
  return [NSColor controlBackgroundColor];
}

static NSColor *modernBorderColor(void) {
  return [NSColor separatorColor];
}

static NSColor *modernTextColor(void) {
  return [NSColor labelColor];
}

static void setButtonTitleColor(NSButton *button, NSColor *color) {
  if (!button || !color) return;
  NSString *title = button.title;
  if (!title) title = @"";
  
  NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
  [style setAlignment:button.alignment];
  
  NSDictionary *attrs = @{
    NSForegroundColorAttributeName: color,
    NSFontAttributeName: button.font ?: [NSFont systemFontOfSize:12],
    NSParagraphStyleAttributeName: style
  };
  
  NSAttributedString *attrTitle = [[NSAttributedString alloc] initWithString:title attributes:attrs];
  [button setAttributedTitle:attrTitle];
}

static NSColor *currentFontColorForView(NSView *view) {
  if (!view) {
    return nil;
  }
  if ([view isKindOfClass:[NSTextField class]]) {
    return [(NSTextField *)view textColor];
  }
  if ([view isKindOfClass:[NSTextView class]]) {
    return [(NSTextView *)view textColor];
  }
  if ([view isKindOfClass:[NSButton class]]) {
    return [(NSButton *)view contentTintColor];
  }
  return nil;
}

static NSColor *currentBackgroundColorForView(NSView *view) {
  if (!view) {
    return nil;
  }
  if ([view isKindOfClass:[NSTextField class]]) {
    return [(NSTextField *)view backgroundColor];
  }
  if ([view isKindOfClass:[NSTextView class]]) {
    return [(NSTextView *)view backgroundColor];
  }
  return nil;
}

static void applyStyleToView(NSView *view, NSColor *backgroundColor, NSColor *fontColor) {
  if (!view) {
    return;
  }

  NSColor *effectiveBackground = backgroundColor ?: ([view isKindOfClass:[NSTextField class]] || [view isKindOfClass:[NSTextView class]] || [view isKindOfClass:[NSDatePicker class]] || [view isKindOfClass:[NSPopUpButton class]]) ? [NSColor textBackgroundColor] : [NSColor clearColor];
  NSColor *effectiveFont = fontColor ?: modernTextColor();

  if ([view isKindOfClass:[NSTextField class]]) {
    NSTextField *field = (NSTextField *)view;
    if (!field.isEditable) {
      [field setDrawsBackground:NO];
      [field setBordered:NO];
      [field setBezeled:NO];
      [field setTextColor:effectiveFont];
    } else {
      [field setFont:[NSFont systemFontOfSize:13 weight:NSFontWeightRegular]];
      [field setControlSize:NSControlSizeRegular];
      [field setFocusRingType:NSFocusRingTypeNone];
      [field setBordered:NO];
      [field setBezeled:NO];
      [field setWantsLayer:YES];
      [field setDrawsBackground:NO];
      [field setBackgroundColor:effectiveBackground];
      [field setTextColor:effectiveFont];
      field.layer.cornerRadius = 8.0;
      field.layer.backgroundColor = effectiveBackground.CGColor;
      
      BOOL hasFocus = NO;
      if (field.window && field.window.firstResponder) {
        id responder = field.window.firstResponder;
        if ([responder isKindOfClass:[NSView class]] && [(NSView *)responder isDescendantOf:field]) {
          hasFocus = YES;
        }
      }
      if (hasFocus) {
        field.layer.borderColor = [NSColor controlAccentColor].CGColor;
        field.layer.borderWidth = 1.5;
      } else {
        field.layer.borderColor = [NSColor separatorColor].CGColor;
        field.layer.borderWidth = 1.0;
      }
    }
  } else if ([view isKindOfClass:[NSTextView class]]) {
    NSTextView *textView = (NSTextView *)view;
    [textView setFont:[NSFont systemFontOfSize:13]];
    [textView setDrawsBackground:YES];
    [textView setBackgroundColor:effectiveBackground];
    [textView setTextColor:effectiveFont];
    [textView setWantsLayer:YES];
  } else if ([view isKindOfClass:[NSButton class]]) {
    NSButton *button = (NSButton *)view;
    [button setFont:[NSFont systemFontOfSize:12 weight:NSFontWeightMedium]];
    [button setControlSize:NSControlSizeRegular];

    BOOL isCheckboxOrRadio = ![button isBordered];
    if (isCheckboxOrRadio) {
      [button setBezelStyle:NSBezelStyleRounded];
      [button setWantsLayer:YES];
      [button setBordered:NO];
      [button setContentTintColor:fontColor ?: modernAccentColor()];
      setButtonTitleColor(button, effectiveFont);
    } else {
      if (backgroundColor && ![backgroundColor isEqual:[NSColor clearColor]]) {
        [button setBezelStyle:NSBezelStyleRounded];
        [button setWantsLayer:YES];
        button.layer.backgroundColor = backgroundColor.CGColor;
        button.layer.cornerRadius = 8.0;
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [NSColor separatorColor].CGColor;
        setButtonTitleColor(button, fontColor ?: [NSColor labelColor]);
      } else {
        [button setWantsLayer:YES];
        [button setBordered:YES];
        [button setBezelStyle:NSBezelStyleRounded];
        button.layer.cornerRadius = 8.0;
        if (fontColor) {
          setButtonTitleColor(button, fontColor);
        } else {
          if (button.attributedTitle && button.attributedTitle.length > 0) {
            [button setAttributedTitle:[[NSAttributedString alloc] initWithString:@""]];
          }
        }
      }
    }
  } else if ([view isKindOfClass:[NSPopUpButton class]]) {
    NSPopUpButton *popup = (NSPopUpButton *)view;
    [popup setFont:[NSFont systemFontOfSize:12 weight:NSFontWeightRegular]];
    [popup setControlSize:NSControlSizeRegular];
    [popup setBezelStyle:NSBezelStyleRounded];
    [popup setWantsLayer:YES];
    popup.layer.cornerRadius = 8.0;
    popup.layer.borderWidth = 1.0;
    popup.layer.borderColor = [NSColor separatorColor].CGColor;
    popup.layer.backgroundColor = (backgroundColor ?: modernElevatedSurfaceColor()).CGColor;
    if ([popup respondsToSelector:@selector(setContentTintColor:)]) {
      [popup setContentTintColor:effectiveFont];
    }
  } else if ([view isKindOfClass:[NSSegmentedControl class]]) {
    NSSegmentedControl *segment = (NSSegmentedControl *)view;
    if (@available(macOS 10.15, *)) {
      [segment setSegmentStyle:NSSegmentStyleAutomatic];
    } else {
      [segment setSegmentStyle:NSSegmentStyleRounded];
    }
    [segment setControlSize:NSControlSizeRegular];
    [segment setFont:[NSFont systemFontOfSize:12 weight:NSFontWeightRegular]];
    [segment setWantsLayer:YES];
    segment.layer.cornerRadius = 8.0;
    if ([segment respondsToSelector:@selector(setContentTintColor:)]) {
      [segment setContentTintColor:fontColor ?: modernAccentColor()];
    }
  } else if ([view isKindOfClass:[NSSlider class]]) {
    NSSlider *slider = (NSSlider *)view;
    [slider setControlSize:NSControlSizeRegular];
    [slider setWantsLayer:YES];
    [slider setFocusRingType:NSFocusRingTypeNone];
    slider.layer.cornerRadius = 8.0;
    if (fontColor && [slider respondsToSelector:@selector(setContentTintColor:)]) {
      [slider setContentTintColor:fontColor];
    }
  } else if ([view isKindOfClass:[NSDatePicker class]]) {
    NSDatePicker *picker = (NSDatePicker *)view;
    [picker setControlSize:NSControlSizeRegular];
    [picker setWantsLayer:YES];
    picker.layer.cornerRadius = 8.0;
    picker.layer.borderWidth = 1.0;
    picker.layer.borderColor = [NSColor separatorColor].CGColor;
    picker.layer.backgroundColor = (backgroundColor ?: modernElevatedSurfaceColor()).CGColor;
  } else if ([view isKindOfClass:[NSScrollView class]]) {
    [view setWantsLayer:YES];
    [view.layer setCornerRadius:10.0];
    [view.layer setBorderWidth:1.0];
    [view.layer setBorderColor:[modernBorderColor() CGColor]];
    [view.layer setBackgroundColor:(backgroundColor ?: modernElevatedSurfaceColor()).CGColor];
  } else {
    if (backgroundColor) {
      [view setWantsLayer:YES];
      [view.layer setBackgroundColor:backgroundColor.CGColor];
    }
  }
}

@implementation AppDelegate
- (instancetype)initWithParams:(main__WindowParams)params {
  self = [super init];
  if (self) {
    _params = params;
    _win_ptr = params.win_ptr;
    _responsiveLayoutEnabled = params.responsive_layout != 0;
    [self setupWindow];
  }
  return self;
}

- (void)setupWindow {
  if (self.window) {
    return;
  }

  NSRect frame = NSMakeRect(100, 100, self.params.width, self.params.height);
  NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskFullSizeContentView;
  if (self.params.resizable) {
    style |= NSWindowStyleMaskResizable;
  }
  if (self.params.minimizable) {
    style |= NSWindowStyleMaskMiniaturizable;
  }
  self.window = [[CustomWindow alloc] initWithContentRect:frame
                                            styleMask:style
                                              backing:NSBackingStoreBuffered
                                                defer:NO];
  const char *title = self.params.title.str ? self.params.title.str : "";
  [self.window setTitle:nsstring(title)];
  [self.window setTitlebarAppearsTransparent:YES];
  [self.window setTitleVisibility:NSWindowTitleVisible];
  
  if ([self.window respondsToSelector:@selector(setTitlebarSeparatorStyle:)]) {
    // NSTitlebarSeparatorStyleNone (0) removes standard divider lines for unified macOS Sonoma/Tahoe sidebar look
    [self.window setTitlebarSeparatorStyle:0];
  }
  
  [self.window setToolbar:nil];
  [self.window setShowsToolbarButton:NO];
  [self.window setBackgroundColor:[NSColor clearColor]];
  [self.window setOpaque:NO];
  [self.window setLevel:self.params.always_on_top ? NSFloatingWindowLevel : NSNormalWindowLevel];
  [self.window setDelegate:self];
  [self.window setReleasedWhenClosed:NO];
  [self.window registerForDraggedTypes:@[NSPasteboardTypeFileURL]];
  
  // Apply maximizable setting
  NSButton *zoomButton = [self.window standardWindowButton:NSWindowZoomButton];
  if (zoomButton) {
    [zoomButton setEnabled:self.params.maximizable != 0];
  }
  
  [self buildUI];
  [self.window center];
  self.windowController = [[NSWindowController alloc] initWithWindow:self.window];
}

- (NSView *)viewForControlName:(NSString *)name {
  if (!name) {
    return nil;
  }
  NSString *normalized = [[name lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  return self.controlsByName[normalized];
}

- (NSString *)nameForControl:(NSView *)control {
  for (NSString *key in self.controlsByName) {
    if (self.controlsByName[key] == control) {
      return key;
    }
  }
  // Scroll view wrappers (like for notes view)
  if ([control isKindOfClass:[NSTextView class]]) {
    NSView *clip = control.superview;
    if (clip) {
      NSView *scroll = clip.superview;
      if ([scroll isKindOfClass:[NSScrollView class]]) {
        for (NSString *key in self.controlsByName) {
          if (self.controlsByName[key] == scroll) {
            return key;
          }
        }
      }
    }
  }
  return nil;
}

- (void)applyStyleToControlNamed:(NSString *)name backgroundColor:(NSColor *)backgroundColor fontColor:(NSColor *)fontColor {
  NSView *view = [self viewForControlName:name];
  if (!view) {
    return;
  }
  NSColor *effectiveBackgroundColor = backgroundColor ?: currentBackgroundColorForView(view) ?: [NSColor clearColor];
  NSColor *effectiveFontColor = fontColor ?: currentFontColorForView(view) ?: [NSColor labelColor];
  applyStyleToView(view, effectiveBackgroundColor, effectiveFontColor);
}

- (void)applyColorsRecursively:(NSView *)view backgroundColor:(NSColor *)backgroundColor fontColor:(NSColor *)fontColor {
  if (!view) {
    return;
  }

  NSColor *effBg = nil;
  if ([view isKindOfClass:[NSTextField class]]) {
    NSTextField *field = (NSTextField *)view;
    if (field.isEditable) {
      effBg = backgroundColor ?: [NSColor textBackgroundColor];
    }
  }
  applyStyleToView(view, effBg, fontColor);

  if ([view isKindOfClass:[NSScrollView class]]) {
    NSScrollView *scroll = (NSScrollView *)view;
    NSView *doc = [scroll documentView];
    if (doc) {
      if ([doc isKindOfClass:[NSTextView class]]) {
        [(NSTextView *)doc setTextColor:fontColor];
        [(NSTextView *)doc setBackgroundColor:backgroundColor ?: [NSColor textBackgroundColor]];
        [(NSTextView *)doc setDrawsBackground:YES];
      } else if ([doc isKindOfClass:[NSTableView class]]) {
        NSTableView *tv = (NSTableView *)doc;
        [tv setBackgroundColor:backgroundColor ?: [NSColor controlBackgroundColor]];
        [tv reloadData];
      } else {
        [self applyColorsRecursively:doc backgroundColor:backgroundColor fontColor:fontColor];
      }
    }
  } else if ([view isKindOfClass:[NSStackView class]]) {
    for (NSView *subview in [(NSStackView *)view arrangedSubviews]) {
      [self applyColorsRecursively:subview backgroundColor:backgroundColor fontColor:fontColor];
    }
  } else if ([view isKindOfClass:[NSBox class]]) {
    NSBox *box = (NSBox *)view;
    if (box.contentView) {
      [self applyColorsRecursively:box.contentView backgroundColor:backgroundColor fontColor:fontColor];
    }
  }

  for (NSView *subview in view.subviews) {
    if ([view isKindOfClass:[NSStackView class]] && [[(NSStackView *)view arrangedSubviews] containsObject:subview]) {
      continue;
    }
    if ([view isKindOfClass:[NSScrollView class]] && subview == [(NSScrollView *)view documentView]) {
      continue;
    }
    [self applyColorsRecursively:subview backgroundColor:backgroundColor fontColor:fontColor];
  }
}

- (void)applyColors:(NSColor *)backgroundColor fontColor:(NSColor *)fontColor {
  self.currentBackgroundColor = backgroundColor;
  self.currentFontColor = fontColor;

  if (self.window) {
    if (backgroundColor) {
      NSColor *rgbBg = [backgroundColor colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
      if (rgbBg) {
        CGFloat r=0, g=0, b=0, a=0;
        [rgbBg getRed:&r green:&g blue:&b alpha:&a];
        double luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b;
        if (luminance < 0.5) {
          if (@available(macOS 10.14, *)) {
            self.window.appearance = [NSAppearance appearanceNamed:NSAppearanceNameDarkAqua];
          } else {
            self.window.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantDark];
          }
        } else {
          if (@available(macOS 10.14, *)) {
            self.window.appearance = [NSAppearance appearanceNamed:NSAppearanceNameAqua];
          } else {
            self.window.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
          }
        }
      }
    }

    if (backgroundColor.alphaComponent < 1.0) {
      [self.window setBackgroundColor:[NSColor clearColor]];
      [self.window setOpaque:NO];
    } else {
      [self.window setBackgroundColor:backgroundColor];
    }
    if (self.window.contentView) {
      [self.window.contentView setWantsLayer:YES];
      [self.window.contentView.layer setBackgroundColor:backgroundColor.CGColor];
    }
  }
  if (self.scrollView) {
    [self.scrollView setBackgroundColor:[NSColor clearColor]];
  }
  if (self.mainStackView) {
    [self.mainStackView setWantsLayer:YES];
    [self.mainStackView.layer setBackgroundColor:[NSColor clearColor].CGColor];
  }
  
  if (self.mainStackView) {
    [self applyColorsRecursively:self.mainStackView backgroundColor:backgroundColor fontColor:fontColor];
  }
}

- (void)makeStretchableView:(NSView *)view minimumWidth:(CGFloat)minimumWidth {
  [view setTranslatesAutoresizingMaskIntoConstraints:NO];
  if (!self.responsiveLayoutEnabled) {
    [view setContentHuggingPriority:NSLayoutPriorityDefaultHigh forOrientation:NSLayoutConstraintOrientationHorizontal];
    [view setContentCompressionResistancePriority:NSLayoutPriorityDefaultHigh forOrientation:NSLayoutConstraintOrientationHorizontal];
    return;
  }
  [view setContentHuggingPriority:NSLayoutPriorityDefaultLow forOrientation:NSLayoutConstraintOrientationHorizontal];
  [view setContentCompressionResistancePriority:NSLayoutPriorityDefaultHigh forOrientation:NSLayoutConstraintOrientationHorizontal];
  [view.widthAnchor constraintGreaterThanOrEqualToConstant:minimumWidth].active = YES;
}

- (void)configureRowStack:(NSStackView *)row {
  [row setTranslatesAutoresizingMaskIntoConstraints:NO];
  [row setDistribution:NSStackViewDistributionFill];
  [row setAlignment:NSLayoutAttributeCenterY];
}

- (void)buildUI {
  NSLog(@"buildUI called");
  self.controlsByName = [NSMutableDictionary dictionary];
  self.treeItemsByName = [NSMutableDictionary dictionary];

  NSVisualEffectView *backgroundView = [[NSVisualEffectView alloc] initWithFrame:NSMakeRect(0, 0, self.params.width, self.params.height)];
  [backgroundView setMaterial:NSVisualEffectMaterialWindowBackground];
  [backgroundView setBlendingMode:NSVisualEffectBlendingModeBehindWindow];
  [backgroundView setState:NSVisualEffectStateActive];
  [backgroundView setWantsLayer:YES];
  [backgroundView.layer setBackgroundColor:modernSurfaceColor().CGColor];
  [backgroundView.layer setCornerRadius:0.0];
  [backgroundView.layer setBorderWidth:0.0];
  [backgroundView.layer setMasksToBounds:NO];

  self.scrollView = [[NSScrollView alloc] initWithFrame:NSZeroRect];
  [self.scrollView setHasVerticalScroller:YES];
  [self.scrollView setHasHorizontalScroller:NO];
  [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self.scrollView setDrawsBackground:NO];
  [self.scrollView setBackgroundColor:[NSColor clearColor]];

  self.mainStackView = [[FlippedStackView alloc] init];
  [self.mainStackView setOrientation:NSUserInterfaceLayoutOrientationVertical];
  [self.mainStackView setAlignment:NSLayoutAttributeLeading];
  [self.mainStackView setDistribution:NSStackViewDistributionFill];
  [self.mainStackView setSpacing:5.0];
  [self.mainStackView setEdgeInsets:NSEdgeInsetsMake(10, 16, 10, 16)];
  [self.mainStackView setWantsLayer:YES];
  [self.mainStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
  
  [self.scrollView setDocumentView:self.mainStackView];
  [backgroundView addSubview:self.scrollView];
  [self.window setContentView:backgroundView];
  
  // High-precision modern AutoLayout constraints to clear transparent titlebar area
  [NSLayoutConstraint activateConstraints:@[
    [self.scrollView.topAnchor constraintEqualToAnchor:backgroundView.topAnchor constant:40.0],
    [self.scrollView.leadingAnchor constraintEqualToAnchor:backgroundView.leadingAnchor constant:8.0],
    [self.scrollView.trailingAnchor constraintEqualToAnchor:backgroundView.trailingAnchor constant:-8.0],
    [self.scrollView.bottomAnchor constraintEqualToAnchor:backgroundView.bottomAnchor constant:-8.0]
  ]];
  
  NSView *clipView = self.scrollView.contentView;
  [self.mainStackView.topAnchor constraintEqualToAnchor:clipView.topAnchor].active = YES;
  [self.mainStackView.leadingAnchor constraintEqualToAnchor:clipView.leadingAnchor].active = YES;
  [self.mainStackView.trailingAnchor constraintEqualToAnchor:clipView.trailingAnchor].active = YES;
  [self.mainStackView.widthAnchor constraintEqualToAnchor:clipView.widthAnchor].active = YES;

  [self applyColors:modernSurfaceColor() fontColor:modernTextColor()];
}

- (void)addControlToLayout:(NSView *)view {
  if (self.currentRowStack) {
    [self.currentRowStack addArrangedSubview:view];
  } else {
    [self.mainStackView addArrangedSubview:view];
  }
}

- (void)beginRowWithName:(NSString *)name {
  NSStackView *row = [[NSStackView alloc] init];
  [row setOrientation:NSUserInterfaceLayoutOrientationHorizontal];
  [row setAlignment:NSLayoutAttributeCenterY];
  [row setDistribution:NSStackViewDistributionFill];
  [row setSpacing:8.0];
  [row setWantsLayer:YES];
  [row setTranslatesAutoresizingMaskIntoConstraints:NO];
  
  [self addControlToLayout:row];
  self.currentRowStack = row;
  self.controlsByName[[name lowercaseString]] = row;
}

- (void)endRow {
  self.currentRowStack = nil;
}

// Control creation methods
- (NSView *)makeLabelWithName:(NSString *)name text:(NSString *)text {
  NSTextField *label = [NSTextField labelWithString:text];
  [label setTextColor:self.currentFontColor ?: [NSColor labelColor]];
  [label setFont:[NSFont systemFontOfSize:10.5 weight:NSFontWeightMedium]];
  [label setLineBreakMode:NSLineBreakByWordWrapping];
  [label setWantsLayer:YES];
  
  self.controlsByName[[name lowercaseString]] = label;
  [self addControlToLayout:label];
  return label;
}

- (NSView *)makeTextFieldWithName:(NSString *)name value:(NSString *)value {
  ModernTextField *textField = [[ModernTextField alloc] initWithFrame:NSZeroRect];
  [textField setStringValue:value];
  [textField setPlaceholderString:@"Type here..."];
  [textField setDelegate:self];
  [textField setTarget:self];
  [textField setAction:@selector(handleInputChanged:)];
  [self makeStretchableView:textField minimumWidth:220];
  [textField.heightAnchor constraintEqualToConstant:34.0].active = YES;
  
  applyStyleToView(textField, self.currentBackgroundColor, self.currentFontColor);
  
  self.controlsByName[[name lowercaseString]] = textField;
  [self addControlToLayout:textField];
  return textField;
}

- (NSView *)makePasswordFieldWithName:(NSString *)name value:(NSString *)value {
  ModernSecureTextField *passwordField = [[ModernSecureTextField alloc] initWithFrame:NSZeroRect];
  [passwordField setStringValue:value];
  [passwordField setPlaceholderString:@"Password..."];
  [passwordField setDelegate:self];
  [passwordField setTarget:self];
  [passwordField setAction:@selector(handleInputChanged:)];
  [self makeStretchableView:passwordField minimumWidth:220];
  [passwordField.heightAnchor constraintEqualToConstant:34.0].active = YES;
  
  applyStyleToView(passwordField, self.currentBackgroundColor, self.currentFontColor);
  
  self.controlsByName[[name lowercaseString]] = passwordField;
  [self addControlToLayout:passwordField];
  return passwordField;
}

- (NSView *)makeHtmlViewWithName:(NSString *)name html:(NSString *)html {
  WKWebView *webView = [[WKWebView alloc] initWithFrame:NSZeroRect configuration:[[WKWebViewConfiguration alloc] init]];
  [self makeStretchableView:webView minimumWidth:320];
  [webView.heightAnchor constraintEqualToConstant:180].active = YES;
  [webView setWantsLayer:YES];
  webView.layer.cornerRadius = 8.0;
  webView.layer.masksToBounds = YES;
  webView.layer.borderWidth = 1.0;
  webView.layer.borderColor = [modernBorderColor() CGColor];
  
  // Make WKWebView background transparent to blend in beautifully with dark/light themes
  if ([webView respondsToSelector:@selector(setValue:forKey:)]) {
    [webView setValue:@NO forKey:@"drawsBackground"];
  }
  
  [webView loadHTMLString:html baseURL:nil];
  [self addControlToLayout:webView];
  self.controlsByName[[name lowercaseString]] = webView;
  return webView;
}

- (NSView *)makeDropZoneWithName:(NSString *)name label:(NSString *)label {
  DropZoneView *box = [[DropZoneView alloc] initWithFrame:NSZeroRect];
  [box setBoxType:NSBoxCustom];
  [box setBorderType:NSLineBorder];
  [box setContentViewMargins:NSMakeSize(12, 12)];
  [box setTitle:@""];
  [box setWantsLayer:YES];
  [self makeStretchableView:box minimumWidth:320];
  [box.heightAnchor constraintEqualToConstant:96].active = YES;
  [box.layer setCornerRadius:10.0];
  [box.layer setBorderWidth:1.0];
  [box.layer setBorderColor:[modernBorderColor() CGColor]];
  box.layer.backgroundColor = [modernElevatedSurfaceColor() CGColor];
  [box registerForDraggedTypes:@[NSPasteboardTypeFileURL]];
  box.win_ptr = self.win_ptr;
  box.controlName = [name lowercaseString];

  NSTextField *labelField = [NSTextField labelWithString:label ?: @"Drop files here"];
  [labelField setAlignment:NSTextAlignmentCenter];
  [labelField setFont:[NSFont systemFontOfSize:11 weight:NSFontWeightMedium]];
  [labelField setTextColor:[NSColor secondaryLabelColor]];
  [labelField setTranslatesAutoresizingMaskIntoConstraints:NO];
  [box addSubview:labelField];
  [NSLayoutConstraint activateConstraints:@[
    [labelField.centerXAnchor constraintEqualToAnchor:box.centerXAnchor],
    [labelField.centerYAnchor constraintEqualToAnchor:box.centerYAnchor]
  ]];

  [self addControlToLayout:box];
  self.controlsByName[[name lowercaseString]] = box;
  return box;
}

- (NSView *)makeTextAreaWithName:(NSString *)name value:(NSString *)value {
  NSScrollView *scroll = [[NSScrollView alloc] initWithFrame:NSZeroRect];
  [scroll setHasVerticalScroller:YES];
  [scroll setHasHorizontalScroller:NO];
  [scroll setBorderType:NSNoBorder];
  [scroll setWantsLayer:YES];
  scroll.layer.cornerRadius = 8.0;
  scroll.layer.borderWidth = 1.0;
  scroll.layer.borderColor = [modernBorderColor() CGColor];
  [self makeStretchableView:scroll minimumWidth:320];
  [scroll.heightAnchor constraintEqualToConstant:120].active = YES;
  
  NSTextView *textView = [[NSTextView alloc] initWithFrame:NSZeroRect];
  [textView setMinSize:NSMakeSize(0.0, 120.0)];
  [textView setMaxSize:NSMakeSize(FLT_MAX, FLT_MAX)];
  [textView setVerticallyResizable:YES];
  [textView setHorizontallyResizable:NO];
  [textView setAutoresizingMask:NSViewWidthSizable];
  [textView setString:value];
  [textView setDelegate:self];
  [textView setWantsLayer:YES];
  [textView setTextContainerInset:NSMakeSize(8.0, 8.0)];
  
  [scroll setDocumentView:textView];
  
  applyStyleToView(scroll, self.currentBackgroundColor ?: [NSColor textBackgroundColor], self.currentFontColor);
  
  [textView setTextColor:self.currentFontColor ?: modernTextColor()];
  [textView setBackgroundColor:self.currentBackgroundColor ?: [NSColor textBackgroundColor]];
  [textView setDrawsBackground:YES];
  
  self.controlsByName[[name lowercaseString]] = scroll;
  [self addControlToLayout:scroll];
  return scroll;
}

- (NSView *)makeButtonWithName:(NSString *)name title:(NSString *)title {
  NSButton *button = [NSButton buttonWithTitle:title target:self action:@selector(handleButtonClicked:)];
  [button setBezelStyle:NSBezelStyleRounded];
  [self makeStretchableView:button minimumWidth:120];
  [button setWantsLayer:NO];
  
  self.controlsByName[[name lowercaseString]] = button;
  [self addControlToLayout:button];
  return button;
}

- (NSView *)makeCheckboxWithName:(NSString *)name label:(NSString *)label checked:(BOOL)checked {
  NSButton *checkbox = [NSButton checkboxWithTitle:label target:self action:@selector(handleCheckboxClicked:)];
  [checkbox setState:checked ? NSOnState : NSOffState];
  [checkbox setWantsLayer:YES];
  
  if (self.currentFontColor) {
    applyStyleToView(checkbox, nil, self.currentFontColor);
  }
  
  self.controlsByName[[name lowercaseString]] = checkbox;
  [self addControlToLayout:checkbox];
  return checkbox;
}

- (NSView *)makeNumberFieldWithName:(NSString *)name value:(int)value {
  NSStackView *row = [[NSStackView alloc] initWithFrame:NSZeroRect];
  [row setOrientation:NSUserInterfaceLayoutOrientationHorizontal];
  [row setSpacing:8.0];
  [self configureRowStack:row];
  
  ModernTextField *numField = [[ModernTextField alloc] initWithFrame:NSZeroRect];
  [numField setStringValue:[NSString stringWithFormat:@"%d", value]];
  [self makeStretchableView:numField minimumWidth:70];
  [numField setTarget:self];
  [numField setAction:@selector(handleNumberChanged:)];
  [numField.heightAnchor constraintEqualToConstant:34.0].active = YES;
  
  NSStepper *stepper = [[NSStepper alloc] initWithFrame:NSZeroRect];
  [stepper setMinValue:0];
  [stepper setMaxValue:1000];
  [stepper setDoubleValue:(double)value];
  [stepper setTarget:self];
  [stepper setAction:@selector(handleNumberChanged:)];
  [stepper setWantsLayer:YES];
  
  [row addArrangedSubview:numField];
  [row addArrangedSubview:stepper];
  
  applyStyleToView(numField, self.currentBackgroundColor, self.currentFontColor);
  
  self.controlsByName[[name lowercaseString]] = numField;
  [self addControlToLayout:row];
  return numField;
}

- (NSView *)makeSliderWithName:(NSString *)name value:(int)value {
  NSStackView *row = [[NSStackView alloc] initWithFrame:NSZeroRect];
  [row setOrientation:NSUserInterfaceLayoutOrientationHorizontal];
  [row setSpacing:10.0];
  [self configureRowStack:row];
  
  NSSlider *slider = [[NSSlider alloc] initWithFrame:NSZeroRect];
  [slider setMinValue:0];
  [slider setMaxValue:100];
  [slider setDoubleValue:(double)value];
  [self makeStretchableView:slider minimumWidth:200];
  [slider setTarget:self];
  [slider setAction:@selector(handleSliderChanged:)];
  [slider setWantsLayer:YES];
  
  NSTextField *label = [NSTextField labelWithString:[NSString stringWithFormat:@"Value: %d", value]];
  [label.widthAnchor constraintEqualToConstant:100].active = YES;
  [label setWantsLayer:YES];
  
  if (self.currentFontColor) {
    [label setTextColor:self.currentFontColor];
  }
  
  [row addArrangedSubview:slider];
  [row addArrangedSubview:label];
  
  self.controlsByName[[name lowercaseString]] = slider;
  [self addControlToLayout:row];
  return slider;
}

- (NSView *)makePopUpButtonWithName:(NSString *)name selected:(NSString *)selected {
  NSPopUpButton *popup = [[NSPopUpButton alloc] initWithFrame:NSZeroRect pullsDown:NO];
  [popup addItemWithTitle:@"Light"];
  [popup addItemWithTitle:@"Dark"];
  [popup addItemWithTitle:@"System"];
  [popup selectItemWithTitle:selected];
  [popup setTarget:self];
  [popup setAction:@selector(handlePopUpChanged:)];
  [self makeStretchableView:popup minimumWidth:180];
  [popup setWantsLayer:YES];
  
  self.controlsByName[[name lowercaseString]] = popup;
  [self addControlToLayout:popup];
  return popup;
}

- (NSView *)makeColorWellWithName:(NSString *)name color:(NSString *)colorString {
  NSColorWell *well = [[NSColorWell alloc] initWithFrame:NSMakeRect(0, 0, 60, 30)];
  [well setColor:colorFromString([colorString UTF8String])];
  [well setTarget:self];
  [well setAction:@selector(handleColorWellChanged:)];
  [well.widthAnchor constraintEqualToConstant:60].active = YES;
  [well.heightAnchor constraintEqualToConstant:30].active = YES;
  [well setWantsLayer:YES];
  well.layer.cornerRadius = 6.0;
  
  if ([well respondsToSelector:@selector(setColorWellStyle:)]) {
    // 1 is NSColorWellStyleMinimal, which looks incredibly slick and modern (like the Safari web inspector / system settings circles)
    [well setColorWellStyle:1];
  }
  
  self.controlsByName[[name lowercaseString]] = well;
  [self addControlToLayout:well];
  return well;
}

- (NSView *)makeDatePickerWithName:(NSString *)name date:(NSString *)dateString {
  NSDatePicker *picker = [[NSDatePicker alloc] initWithFrame:NSZeroRect];
  [picker setDatePickerStyle:NSDatePickerStyleTextField];
  [picker setDatePickerMode:NSDatePickerModeSingle];
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd"];
  NSDate *date = [formatter dateFromString:dateString] ?: [NSDate date];
  [picker setDateValue:date];
  [picker setTarget:self];
  [picker setAction:@selector(handleDatePickerChanged:)];
  [self makeStretchableView:picker minimumWidth:160];
  [picker setWantsLayer:YES];
  
  if (self.currentFontColor) {
    applyStyleToView(picker, nil, self.currentFontColor);
  }
  
  self.controlsByName[[name lowercaseString]] = picker;
  [self addControlToLayout:picker];
  return picker;
}

- (NSView *)makeSegmentedControlWithName:(NSString *)name selected:(NSString *)selected {
  NSSegmentedControl *seg = [[NSSegmentedControl alloc] initWithFrame:NSZeroRect];
  [seg setSegmentCount:3];
  [seg setLabel:@"Simple" forSegment:0];
  [seg setLabel:@"Advanced" forSegment:1];
  [seg setLabel:@"Expert" forSegment:2];
  
  [seg setSelectedSegment:0];
  for (NSInteger i = 0; i < [seg segmentCount]; i++) {
    if ([[seg labelForSegment:i] isEqualToString:selected]) {
      [seg setSelectedSegment:i];
      break;
    }
  }
  [seg setTarget:self];
  [seg setAction:@selector(handleSegmentedChanged:)];
  [self makeStretchableView:seg minimumWidth:220];
  [seg setWantsLayer:YES];
  
  applyStyleToView(seg, self.currentBackgroundColor, self.currentFontColor);
  
  self.controlsByName[[name lowercaseString]] = seg;
  [self addControlToLayout:seg];
  return seg;
}

- (NSView *)makeProgressIndicatorWithName:(NSString *)name value:(int)value {
  NSProgressIndicator *progress = [[NSProgressIndicator alloc] initWithFrame:NSZeroRect];
  [progress setStyle:NSProgressIndicatorStyleBar];
  [progress setMinValue:0];
  [progress setMaxValue:100];
  [progress setDoubleValue:(double)value];
  [progress setIndeterminate:NO];
  [self makeStretchableView:progress minimumWidth:260];
  [progress setWantsLayer:YES];
  
  self.controlsByName[[name lowercaseString]] = progress;
  [self addControlToLayout:progress];
  return progress;
}

- (NSView *)makeDropdownWithName:(NSString *)name items:(NSArray<NSString *> *)items selected:(NSString *)selected {
  NSPopUpButton *popup = [[NSPopUpButton alloc] initWithFrame:NSZeroRect pullsDown:NO];
  for (NSString *item in items) {
    [popup addItemWithTitle:item];
  }
  [popup selectItemWithTitle:selected];
  [popup setTarget:self];
  [popup setAction:@selector(handlePopUpChanged:)];
  [self makeStretchableView:popup minimumWidth:180];
  [popup setWantsLayer:YES];
  
  if (self.currentFontColor || self.currentBackgroundColor) {
    applyStyleToView(popup, self.currentBackgroundColor, self.currentFontColor);
  }
  
  self.controlsByName[[name lowercaseString]] = popup;
  [self addControlToLayout:popup];
  return popup;
}

- (NSView *)makeSegmentedControlWithName:(NSString *)name items:(NSArray<NSString *> *)items selected:(NSString *)selected {
  NSSegmentedControl *seg = [[NSSegmentedControl alloc] initWithFrame:NSZeroRect];
  [seg setSegmentCount:items.count];
  for (NSInteger i = 0; i < items.count; i++) {
    [seg setLabel:items[i] forSegment:i];
  }
  [seg setSelectedSegment:-1];
  for (NSInteger i = 0; i < items.count; i++) {
    if ([items[i] isEqualToString:selected]) {
      [seg setSelectedSegment:i];
      break;
    }
  }
  [seg setTarget:self];
  [seg setAction:@selector(handleSegmentedChanged:)];
  [self makeStretchableView:seg minimumWidth:220];
  [seg setWantsLayer:YES];
  
  if (self.currentFontColor) {
    applyStyleToView(seg, nil, self.currentFontColor);
  }
  
  self.controlsByName[[name lowercaseString]] = seg;
  [self addControlToLayout:seg];
  return seg;
}

- (NSView *)makeRadioGroupWithName:(NSString *)name items:(NSArray<NSString *> *)items selected:(NSString *)selected {
  NSStackView *radioStack = [[NSStackView alloc] init];
  [radioStack setOrientation:NSUserInterfaceLayoutOrientationVertical];
  [radioStack setAlignment:NSLayoutAttributeLeading];
  [radioStack setSpacing:6.0];
  [radioStack setWantsLayer:YES];
  [radioStack setTranslatesAutoresizingMaskIntoConstraints:NO];
  
  for (NSInteger i = 0; i < items.count; i++) {
    NSButton *radio = [NSButton radioButtonWithTitle:items[i] target:self action:@selector(handleRadioChanged:)];
    if ([items[i] isEqualToString:selected]) {
      [radio setState:NSControlStateValueOn];
    } else {
      [radio setState:NSControlStateValueOff];
    }
    [radio setIdentifier:[NSString stringWithFormat:@"%@_radio_%ld", name, (long)i]];
    if (self.currentFontColor) {
      applyStyleToView(radio, nil, self.currentFontColor);
    }
    [radioStack addArrangedSubview:radio];
  }
  
  self.controlsByName[[name lowercaseString]] = radioStack;
  [self addControlToLayout:radioStack];
  return radioStack;
}

- (void)handleRadioChanged:(id)sender {
  NSButton *clickedRadio = (NSButton *)sender;
  NSStackView *radioStack = (NSStackView *)[clickedRadio superview];
  if ([radioStack isKindOfClass:[NSStackView class]]) {
    for (NSView *subview in [radioStack arrangedSubviews]) {
      if ([subview isKindOfClass:[NSButton class]]) {
        NSButton *btn = (NSButton *)subview;
        if (btn != clickedRadio) {
          [btn setState:NSControlStateValueOff];
        } else {
          [btn setState:NSControlStateValueOn];
        }
      }
    }
    NSString *name = [self nameForControl:radioStack];
    if (name && self.win_ptr) {
      NSString *choice = [clickedRadio title];
      vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [choice UTF8String]);
    }
  }
}

- (NSView *)makeSwitchWithName:(NSString *)name label:(NSString *)labelText checked:(BOOL)checked {
  NSStackView *row = [[NSStackView alloc] init];
  [row setOrientation:NSUserInterfaceLayoutOrientationHorizontal];
  [row setAlignment:NSLayoutAttributeCenterY];
  [row setSpacing:8.0];
  [row setTranslatesAutoresizingMaskIntoConstraints:NO];

  NSTextField *label = [NSTextField labelWithString:labelText];
  [label setFont:[NSFont systemFontOfSize:13]];
  if (self.currentFontColor) {
    applyStyleToView(label, nil, self.currentFontColor);
  }
  
  NSSwitch *sw = [[NSSwitch alloc] init];
  [sw setState:checked ? NSControlStateValueOn : NSControlStateValueOff];
  [sw setTarget:self];
  [sw setAction:@selector(handleSwitchChanged:)];
  
  [row addArrangedSubview:label];
  [row addArrangedSubview:sw];

  self.controlsByName[[name lowercaseString]] = sw;
  [self addControlToLayout:row];
  return sw;
}

- (void)handleSwitchChanged:(id)sender {
  NSSwitch *sw = (NSSwitch *)sender;
  int checked = (sw.state == NSControlStateValueOn) ? 1 : 0;
  NSString *name = [self nameForControl:sw];
  if (name && self.win_ptr) {
    NSString *valStr = checked ? @"true" : @"false";
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [valStr UTF8String]);
  }
}

- (NSView *)makeSearchFieldWithName:(NSString *)name placeholder:(NSString *)placeholder {
  ModernSearchField *searchField = [[ModernSearchField alloc] initWithFrame:NSZeroRect];
  [[searchField cell] setPlaceholderString:placeholder];
  [searchField setDelegate:self];
  [searchField setTarget:self];
  [searchField setAction:@selector(handleInputChanged:)];
  [self makeStretchableView:searchField minimumWidth:180];
  [searchField.heightAnchor constraintEqualToConstant:34.0].active = YES;
  
  applyStyleToView(searchField, self.currentBackgroundColor, self.currentFontColor);
  
  self.controlsByName[[name lowercaseString]] = searchField;
  [self addControlToLayout:searchField];
  return searchField;
}

- (NSView *)makeComboBoxWithName:(NSString *)name items:(NSArray<NSString *> *)items selected:(NSString *)selected {
  NSComboBox *combo = [[NSComboBox alloc] initWithFrame:NSZeroRect];
  [combo addItemsWithObjectValues:items];
  [combo setStringValue:selected ?: @""];
  [combo setDelegate:self];
  [combo setTarget:self];
  [combo setAction:@selector(handleInputChanged:)];
  [self makeStretchableView:combo minimumWidth:180];
  [combo.heightAnchor constraintEqualToConstant:34.0].active = YES;
  
  applyStyleToView(combo, self.currentBackgroundColor, self.currentFontColor);
  
  self.controlsByName[[name lowercaseString]] = combo;
  [self addControlToLayout:combo];
  return combo;
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification {
  NSComboBox *combo = (NSComboBox *)notification.object;
  NSString *name = [self nameForControl:combo];
  if (name && self.win_ptr) {
    NSInteger selectedIdx = [combo indexOfSelectedItem];
    if (selectedIdx >= 0) {
      NSString *val = [combo itemObjectValueAtIndex:selectedIdx];
      vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [val UTF8String]);
    }
  }
}

- (NSView *)makeLevelIndicatorWithName:(NSString *)name style:(int)style minValue:(double)minValue maxValue:(double)maxValue value:(double)value {
  NSLevelIndicator *indicator = [[NSLevelIndicator alloc] initWithFrame:NSZeroRect];
  
  if (@available(macOS 10.13, *)) {
    indicator.levelIndicatorStyle = style;
  }
  
  indicator.minValue = minValue;
  indicator.maxValue = maxValue;
  indicator.doubleValue = value;
  indicator.editable = YES;
  indicator.target = self;
  indicator.action = @selector(handleLevelIndicatorChanged:);
  
  [self makeStretchableView:indicator minimumWidth:120];
  [indicator.heightAnchor constraintEqualToConstant:24.0].active = YES;
  
  self.controlsByName[[name lowercaseString]] = indicator;
  [self addControlToLayout:indicator];
  return indicator;
}

- (void)handleLevelIndicatorChanged:(id)sender {
  NSLevelIndicator *indicator = (NSLevelIndicator *)sender;
  NSString *name = [self nameForControl:indicator];
  if (name && self.win_ptr) {
    double value = [indicator doubleValue];
    NSString *valStr = [NSString stringWithFormat:@"%.1f", value];
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [valStr UTF8String]);
  }
}

- (NSView *)makeSpinnerWithName:(NSString *)name active:(BOOL)active {
  NSProgressIndicator *spinner = [[NSProgressIndicator alloc] initWithFrame:NSZeroRect];
  [spinner setStyle:NSProgressIndicatorStyleSpinning];
  [spinner setControlSize:NSControlSizeRegular];
  [spinner setIndeterminate:YES];
  if (active) {
    [spinner startAnimation:nil];
  } else {
    [spinner stopAnimation:nil];
  }
  [spinner setHidden:!active];
  
  [spinner setTranslatesAutoresizingMaskIntoConstraints:NO];
  [spinner.widthAnchor constraintEqualToConstant:32.0].active = YES;
  [spinner.heightAnchor constraintEqualToConstant:32.0].active = YES;
  
  self.controlsByName[[name lowercaseString]] = spinner;
  [self addControlToLayout:spinner];
  return spinner;
}

- (NSView *)makePathControlWithName:(NSString *)name path:(NSString *)pathString {
  NSPathControl *pathControl = [[NSPathControl alloc] initWithFrame:NSZeroRect];
  [pathControl setPathStyle:NSPathStyleStandard];
  if (pathString && pathString.length > 0) {
    [pathControl setURL:[NSURL fileURLWithPath:pathString]];
  }
  [pathControl setEditable:YES];
  [pathControl setTarget:self];
  [pathControl setAction:@selector(handlePathControlChanged:)];
  
  [self makeStretchableView:pathControl minimumWidth:240];
  [pathControl.heightAnchor constraintEqualToConstant:28.0].active = YES;
  
  self.controlsByName[[name lowercaseString]] = pathControl;
  [self addControlToLayout:pathControl];
  return pathControl;
}

- (void)handlePathControlChanged:(id)sender {
  NSPathControl *pathControl = (NSPathControl *)sender;
  NSString *name = [self nameForControl:pathControl];
  if (name && self.win_ptr) {
    NSURL *url = [pathControl URL];
    NSString *path = url ? [url path] : @"";
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [path UTF8String]);
  }
}

- (NSView *)makeTokenFieldWithName:(NSString *)name value:(NSString *)value {
  NSTokenField *tokenField = [[NSTokenField alloc] initWithFrame:NSZeroRect];
  [tokenField setStringValue:value ?: @""];
  [tokenField setDelegate:self];
  [tokenField setTarget:self];
  [tokenField setAction:@selector(handleInputChanged:)];
  
  [tokenField setTokenizingCharacterSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
  
  [self makeStretchableView:tokenField minimumWidth:220];
  [tokenField.heightAnchor constraintEqualToConstant:34.0].active = YES;
  
  applyStyleToView(tokenField, self.currentBackgroundColor, self.currentFontColor);
  
  self.controlsByName[[name lowercaseString]] = tokenField;
  [self addControlToLayout:tokenField];
  return tokenField;
}

- (void)handleInputChanged:(id)sender {
  NSString *name = [self nameForControl:sender];
  if (name && self.win_ptr) {
    NSString *value = [(NSTextField *)sender stringValue];
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [value UTF8String]);
  }
}

- (void)controlTextDidChange:(NSNotification *)notification {
  NSView *control = (NSView *)notification.object;
  NSString *name = [self nameForControl:control];
  if (name && self.win_ptr) {
    NSString *value = [(NSTextField *)control stringValue];
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [value UTF8String]);
  }
}

- (void)textDidChange:(NSNotification *)notification {
  NSView *control = (NSView *)notification.object;
  NSString *name = [self nameForControl:control];
  if (name && self.win_ptr) {
    NSString *value = [(NSTextView *)control string];
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [value UTF8String]);
  }
}

// NSTableViewDataSource methods
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
  NSString *name = tableView.identifier;
  if (!name) return 0;
  NSString *key = [[name lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  if (self.tableItemsByName && self.tableItemsByName[key]) {
    NSArray *rows = self.tableItemsByName[key];
    return rows.count;
  }
  
  NSArray *items = self.listItemsByName[key];
  return items ? items.count : 0;
}

// NSTableViewDelegate methods
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  NSString *name = tableView.identifier;
  if (!name) return nil;
  NSString *key = [[name lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  if (self.tableItemsByName && self.tableItemsByName[key]) {
    NSArray *rows = self.tableItemsByName[key];
    if (row < 0 || row >= rows.count) return nil;
    NSArray *cols = rows[row];
    
    NSString *colId = tableColumn.identifier;
    int colIdx = 0;
    if ([colId hasPrefix:@"Col_"]) {
      colIdx = [[colId substringFromIndex:4] intValue];
    }
    if (colIdx < 0 || colIdx >= cols.count) return nil;
    
    NSTableCellView *cell = [tableView makeViewWithIdentifier:@"TableCell" owner:self];
    if (!cell) {
      cell = [[NSTableCellView alloc] initWithFrame:NSMakeRect(0, 0, 100, 20)];
      NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 100, 20)];
      [textField setBezeled:NO];
      [textField setDrawsBackground:NO];
      [textField setEditable:NO];
      [textField setSelectable:NO];
      [cell addSubview:textField];
      cell.textField = textField;
      
      textField.translatesAutoresizingMaskIntoConstraints = NO;
      [NSLayoutConstraint activateConstraints:@[
        [textField.leadingAnchor constraintEqualToAnchor:cell.leadingAnchor constant:4],
        [textField.trailingAnchor constraintEqualToAnchor:cell.trailingAnchor constant:-4],
        [textField.topAnchor constraintEqualToAnchor:cell.topAnchor constant:2],
        [textField.bottomAnchor constraintEqualToAnchor:cell.bottomAnchor constant:-2]
      ]];
    }
    [cell.textField setStringValue:cols[colIdx]];
    if (self.currentFontColor) {
      [cell.textField setTextColor:self.currentFontColor];
    }
    return cell;
  }
  
  NSArray *items = self.listItemsByName[key];
  if (!items || row < 0 || row >= items.count) return nil;
  
  NSTableCellView *cell = [tableView makeViewWithIdentifier:@"ListCell" owner:self];
  if (!cell) {
    cell = [[NSTableCellView alloc] initWithFrame:NSMakeRect(0, 0, 100, 20)];
    NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 100, 20)];
    [textField setBezeled:NO];
    [textField setDrawsBackground:NO];
    [textField setEditable:NO];
    [textField setSelectable:NO];
    [cell addSubview:textField];
    cell.textField = textField;
    
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
      [textField.leadingAnchor constraintEqualToAnchor:cell.leadingAnchor constant:4],
      [textField.trailingAnchor constraintEqualToAnchor:cell.trailingAnchor constant:-4],
      [textField.topAnchor constraintEqualToAnchor:cell.topAnchor constant:2],
      [textField.bottomAnchor constraintEqualToAnchor:cell.bottomAnchor constant:-2]
    ]];
  }
  [cell.textField setStringValue:items[row]];
  [cell.textField setTextColor:self.currentFontColor ?: [NSColor labelColor]];
  [cell.textField setFont:[NSFont systemFontOfSize:13]];
  [cell.textField setDrawsBackground:NO];
  [cell.textField setBackgroundColor:[NSColor clearColor]];
  [cell setBackgroundStyle:NSBackgroundStyleNormal];
  return cell;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
  NSTableView *tableView = notification.object;
  NSString *name = tableView.identifier;
  if (name && self.win_ptr) {
    if ([tableView isKindOfClass:[NSOutlineView class]]) {
      return; // Handled by outlineViewSelectionDidChange
    }
    NSInteger selectedRow = [tableView selectedRow];
    NSString *value = [NSString stringWithFormat:@"%ld", (long)selectedRow];
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [value UTF8String]);
  }
}

- (TreeItem *)findTreeItemWithId:(NSString *)targetId inItems:(NSArray<TreeItem *> *)items {
  for (TreeItem *item in items) {
    if ([item.itemId isEqualToString:targetId]) {
      return item;
    }
    TreeItem *found = [self findTreeItemWithId:targetId inItems:item.children];
    if (found) {
      return found;
    }
  }
  return nil;
}

// NSOutlineViewDataSource methods
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
  NSString *name = outlineView.identifier;
  if (!name) return 0;
  NSString *key = [[name lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  if (item == nil) {
    NSArray<TreeItem *> *roots = self.treeItemsByName[key];
    return roots ? roots.count : 0;
  } else {
    TreeItem *treeItem = (TreeItem *)item;
    return treeItem.children.count;
  }
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
  NSString *name = outlineView.identifier;
  if (!name) return nil;
  NSString *key = [[name lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  if (item == nil) {
    NSArray<TreeItem *> *roots = self.treeItemsByName[key];
    return (roots && index >= 0 && index < roots.count) ? roots[index] : nil;
  } else {
    TreeItem *treeItem = (TreeItem *)item;
    return (index >= 0 && index < treeItem.children.count) ? treeItem.children[index] : nil;
  }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
  if (item == nil) {
    return YES;
  }
  TreeItem *treeItem = (TreeItem *)item;
  return treeItem.children.count > 0;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
  TreeItem *treeItem = (TreeItem *)item;
  return treeItem.text;
}

// NSOutlineViewDelegate methods
- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
  NSTableCellView *cell = [outlineView makeViewWithIdentifier:@"TreeCell" owner:self];
  if (!cell) {
    cell = [[NSTableCellView alloc] initWithFrame:NSMakeRect(0, 0, 100, 20)];
    NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 100, 20)];
    [textField setBezeled:NO];
    [textField setDrawsBackground:NO];
    [textField setEditable:NO];
    [textField setSelectable:NO];
    [cell addSubview:textField];
    cell.textField = textField;
    
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
      [textField.leadingAnchor constraintEqualToAnchor:cell.leadingAnchor constant:4],
      [textField.trailingAnchor constraintEqualToAnchor:cell.trailingAnchor constant:-4],
      [textField.topAnchor constraintEqualToAnchor:cell.topAnchor constant:2],
      [textField.bottomAnchor constraintEqualToAnchor:cell.bottomAnchor constant:-2]
    ]];
  }
  
  TreeItem *treeItem = (TreeItem *)item;
  [cell.textField setStringValue:treeItem.text];
  [cell.textField setTextColor:self.currentFontColor ?: [NSColor labelColor]];
  [cell.textField setFont:[NSFont systemFontOfSize:13]];
  [cell.textField setDrawsBackground:NO];
  [cell.textField setBackgroundColor:[NSColor clearColor]];
  [cell setBackgroundStyle:NSBackgroundStyleNormal];
  return cell;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
  NSOutlineView *outlineView = notification.object;
  NSString *name = outlineView.identifier;
  if (name && self.win_ptr) {
    NSInteger selectedRow = [outlineView selectedRow];
    TreeItem *item = [outlineView itemAtRow:selectedRow];
    NSString *value = item ? item.itemId : @"";
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [value UTF8String]);
  }
}

// NSTextFieldDelegate Focus Gained & Lost
- (void)controlTextDidBeginEditing:(NSNotification *)notification {
  NSView *control = (NSView *)notification.object;
  NSString *name = [self nameForControl:control];
  if (name && self.win_ptr) {
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "focus", "");
  }
}

- (void)controlTextDidEndEditing:(NSNotification *)notification {
  NSView *control = (NSView *)notification.object;
  NSString *name = [self nameForControl:control];
  if (name && self.win_ptr) {
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "blur", "");
  }
}

// NSWindowDelegate Window Resized
- (void)windowDidResize:(NSNotification *)notification {
  if (self.win_ptr && self.window) {
    NSRect frame = [self.window contentRectForFrameRect:self.window.frame];
    NSString *sizeStr = [NSString stringWithFormat:@"%.0fx%.0f", frame.size.width, frame.size.height];
    vlang_dispatch_event(self.win_ptr, "window", "resize", [sizeStr UTF8String]);
  }
}

// Hover Event Tracking Delegates
- (void)mouseEntered:(NSEvent *)event {
  NSTrackingArea *area = [event trackingArea];
  if (area) {
    NSDictionary *userInfo = [area userInfo];
    NSString *name = userInfo[@"name"];
    if (name && self.win_ptr) {
      vlang_dispatch_event(self.win_ptr, [name UTF8String], "hover_enter", "");
    }
  }
}

- (void)mouseExited:(NSEvent *)event {
  NSTrackingArea *area = [event trackingArea];
  if (area) {
    NSDictionary *userInfo = [area userInfo];
    NSString *name = userInfo[@"name"];
    if (name && self.win_ptr) {
      vlang_dispatch_event(self.win_ptr, [name UTF8String], "hover_exit", "");
    }
  }
}

- (void)handleButtonClicked:(id)sender {
  NSString *name = [self nameForControl:sender];
  if (name && self.win_ptr) {
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "click", "");
  }
}

- (void)handleCheckboxClicked:(id)sender {
  NSString *name = [self nameForControl:sender];
  BOOL checked = [(NSButton *)sender state] == NSOnState;
  if (name && self.win_ptr) {
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", checked ? "true" : "false");
  }
}

- (void)handleNumberChanged:(id)sender {
  NSTextField *field = nil;
  NSStepper *stepper = nil;
  if ([sender isKindOfClass:[NSStepper class]]) {
    stepper = (NSStepper *)sender;
    NSStackView *row = (NSStackView *)stepper.superview;
    field = (NSTextField *)row.arrangedSubviews[0];
    [field setDoubleValue:[stepper doubleValue]];
  } else {
    field = (NSTextField *)sender;
    NSStackView *row = (NSStackView *)field.superview;
    stepper = (NSStepper *)row.arrangedSubviews[1];
    [stepper setDoubleValue:[field doubleValue]];
  }
  NSString *name = [self nameForControl:field];
  if (name && self.win_ptr) {
    NSString *valStr = [NSString stringWithFormat:@"%.0f", [field doubleValue]];
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [valStr UTF8String]);
  }
}

- (void)handleSliderChanged:(id)sender {
  NSSlider *slider = (NSSlider *)sender;
  NSStackView *row = (NSStackView *)slider.superview;
  NSTextField *label = (NSTextField *)row.arrangedSubviews[1];
  int val = [slider intValue];
  [label setStringValue:[NSString stringWithFormat:@"Value: %d", val]];
  
  NSString *name = [self nameForControl:slider];
  if (name && self.win_ptr) {
    NSString *valStr = [NSString stringWithFormat:@"%d", val];
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [valStr UTF8String]);
  }
}

- (void)handlePopUpChanged:(id)sender {
  NSPopUpButton *popup = (NSPopUpButton *)sender;
  NSString *choice = [popup titleOfSelectedItem];
  NSString *name = [self nameForControl:popup];
  if (name && self.win_ptr) {
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [choice UTF8String]);
  }
}

- (void)handleColorWellChanged:(id)sender {
  NSColorWell *well = (NSColorWell *)sender;
  NSColor *color = [well color];
  CGFloat r=0, g=0, b=0, a=0;
  NSColor *rgbColor = [color colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
  if (rgbColor) {
    [rgbColor getRed:&r green:&g blue:&b alpha:&a];
  } else {
    [color getRed:&r green:&g blue:&b alpha:&a];
  }
  NSString *colorStr = [NSString stringWithFormat:@"#%02X%02X%02X", (int)(r * 255.99), (int)(g * 255.99), (int)(b * 255.99)];
  NSString *name = [self nameForControl:well];
  if (name && self.win_ptr) {
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [colorStr UTF8String]);
  }
}

- (void)handleDatePickerChanged:(id)sender {
  NSDatePicker *picker = (NSDatePicker *)sender;
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd"];
  NSString *dateText = [formatter stringFromDate:[picker dateValue]];
  NSString *name = [self nameForControl:picker];
  if (name && self.win_ptr) {
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [dateText UTF8String]);
  }
}

- (void)handleSegmentedChanged:(id)sender {
  NSSegmentedControl *seg = (NSSegmentedControl *)sender;
  NSInteger index = [seg selectedSegment];
  NSString *label = [seg labelForSegment:index];
  NSString *name = [self nameForControl:seg];
  if (name && self.win_ptr) {
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "change", [label UTF8String]);
  }
}

- (void)setupMenuBar {
  NSMenu *mainMenu = [[NSMenu alloc] init];
  
  NSString *appName = nil;
  if (self.params.title.str && strlen(self.params.title.str) > 0) {
    appName = nsstring(self.params.title.str);
  } else {
    appName = [[NSProcessInfo processInfo] processName];
  }
  
  // 1. App Menu
  NSMenuItem *appMenuItem = [[NSMenuItem alloc] init];
  [mainMenu addItem:appMenuItem];
  NSMenu *appMenu = [[NSMenu alloc] init];
  
  NSString *aboutTitle = [NSString stringWithFormat:@"About %@", appName];
  [appMenu addItemWithTitle:aboutTitle action:@selector(orderFrontStandardAboutPanel:) keyEquivalent:@""];
  
  [appMenu addItem:[NSMenuItem separatorItem]];
  
  NSString *hideTitle = [NSString stringWithFormat:@"Hide %@", appName];
  [appMenu addItemWithTitle:hideTitle action:@selector(hide:) keyEquivalent:@"h"];
  
  NSMenuItem *hideOthersItem = [appMenu addItemWithTitle:@"Hide Others" action:@selector(hideOtherApplications:) keyEquivalent:@"h"];
  [hideOthersItem setKeyEquivalentModifierMask:NSEventModifierFlagCommand | NSEventModifierFlagOption];
  
  [appMenu addItemWithTitle:@"Show All" action:@selector(unhideAllApplications:) keyEquivalent:@""];
  
  [appMenu addItem:[NSMenuItem separatorItem]];
  
  NSString *quitTitle = [NSString stringWithFormat:@"Quit %@", appName];
  [appMenu addItemWithTitle:quitTitle action:@selector(terminate:) keyEquivalent:@"q"];
  
  [appMenuItem setSubmenu:appMenu];
  
  // 2. Edit Menu (Fixes standard copy/paste shortcuts)
  NSMenuItem *editMenuItem = [[NSMenuItem alloc] init];
  [mainMenu addItem:editMenuItem];
  NSMenu *editMenu = [[NSMenu alloc] initWithTitle:@"Edit"];
  
  [editMenu addItemWithTitle:@"Undo" action:@selector(undo:) keyEquivalent:@"z"];
  [editMenu addItemWithTitle:@"Redo" action:@selector(redo:) keyEquivalent:@"Z"];
  [editMenu addItem:[NSMenuItem separatorItem]];
  [editMenu addItemWithTitle:@"Cut" action:@selector(cut:) keyEquivalent:@"x"];
  [editMenu addItemWithTitle:@"Copy" action:@selector(copy:) keyEquivalent:@"c"];
  [editMenu addItemWithTitle:@"Paste" action:@selector(paste:) keyEquivalent:@"v"];
  [editMenu addItemWithTitle:@"Select All" action:@selector(selectAll:) keyEquivalent:@"a"];
  
  [editMenuItem setSubmenu:editMenu];
  
  // 3. Window Menu
  NSMenuItem *windowMenuItem = [[NSMenuItem alloc] init];
  [mainMenu addItem:windowMenuItem];
  NSMenu *windowMenu = [[NSMenu alloc] initWithTitle:@"Window"];
  [windowMenu addItemWithTitle:@"Minimize" action:@selector(performMiniaturize:) keyEquivalent:@"m"];
  [windowMenu addItemWithTitle:@"Zoom" action:@selector(performZoom:) keyEquivalent:@""];
  
  [windowMenuItem setSubmenu:windowMenu];
  
  [[NSApplication sharedApplication] setMainMenu:mainMenu];
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
  (void)notification;
  NSLog(@"applicationWillFinishLaunching");
  [self setupWindow];
  [self setupMenuBar];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
  (void)notification;
  NSLog(@"applicationDidFinishLaunching");
  [self setupWindow];
  
  // Auto-fit the window to the actual content while keeping it within the visible screen.
  [self.mainStackView layoutSubtreeIfNeeded];
  NSSize fitSize = [self.mainStackView fittingSize];
  NSRect screenFrame = [[NSScreen mainScreen] visibleFrame];
  CGFloat targetWidth = MAX(fitSize.width + 60.0, 320.0);
  CGFloat targetHeight = MAX(fitSize.height + 48.0, 180.0);
  
  if (targetWidth > screenFrame.size.width * 0.9) {
    targetWidth = screenFrame.size.width * 0.9;
  }
  if (targetHeight > screenFrame.size.height * 0.85) {
    targetHeight = screenFrame.size.height * 0.85;
  }
  
  [self.window setContentSize:NSMakeSize(targetWidth, targetHeight)];
  [self.window center];
  
  [self.windowController showWindow:nil];
  [self.window makeKeyAndOrderFront:nil];
  [self.window orderFrontRegardless];
  [self.window makeMainWindow];
  [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
  [[NSApplication sharedApplication] arrangeInFront:nil];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
  (void)sender;
  return YES;
}

- (BOOL)windowShouldClose:(id)sender {
  (void)sender;
  [NSApp terminate:self];
  return YES;
}

- (void)applicationWillTerminate:(NSNotification *)notification {
  (void)notification;
}

- (NSMenu *)findOrCreateMenuWithName:(NSString *)menuName {
  NSMenu *mainMenu = [NSApp mainMenu];
  if (!mainMenu) {
    mainMenu = [[NSMenu alloc] init];
    [NSApp setMainMenu:mainMenu];
  }
  
  // Search existing submenus
  for (NSMenuItem *item in mainMenu.itemArray) {
    if (item.submenu && [[item.submenu title] isEqualToString:menuName]) {
      return item.submenu;
    }
  }
  
  // Create new top-level menu
  NSMenuItem *menuItem = [mainMenu addItemWithTitle:menuName action:nil keyEquivalent:@""];
  NSMenu *submenu = [[NSMenu alloc] initWithTitle:menuName];
  [menuItem setSubmenu:submenu];
  return submenu;
}

- (void)handleMenuItemClicked:(id)sender {
  NSMenuItem *item = (NSMenuItem *)sender;
  NSString *name = item.representedObject;
  if (name && self.win_ptr) {
    vlang_dispatch_event(self.win_ptr, [name UTF8String], "click", "");
  }
}
@end

void window_add_menu_item(main__WindowInfo *info, const char *menu_name, const char *item_title, const char *shortcut, const char *handler_name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSString *menuName = nsstring(menu_name);
  NSString *itemTitle = nsstring(item_title);
  NSString *key = nsstring(shortcut);
  NSString *handlerName = nsstring(handler_name);
  
  dispatch_async(dispatch_get_main_queue(), ^{
    if (delegate.statusBarMenu) {
      NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:itemTitle action:@selector(handleMenuItemClicked:) keyEquivalent:key];
      [item setTarget:delegate];
      [item setRepresentedObject:handlerName];
      [delegate.statusBarMenu addItem:item];
    } else {
      NSMenu *submenu = [delegate findOrCreateMenuWithName:menuName];
      if (submenu) {
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:itemTitle action:@selector(handleMenuItemClicked:) keyEquivalent:key];
        [item setTarget:delegate];
        [item setRepresentedObject:handlerName];
        [submenu addItem:item];
      }
    }
  });
}

void window_add_context_menu_item(main__WindowInfo *info, const char *control_name, const char *item_title, const char *handler_name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSString *controlName = nsstring(control_name);
  NSString *itemTitle = nsstring(item_title);
  NSString *handlerName = nsstring(handler_name);
  
  dispatch_async(dispatch_get_main_queue(), ^{
    NSView *view = nil;
    if ([controlName isEqualToString:@"window"]) {
      view = delegate.window.contentView;
    } else {
      view = [delegate viewForControlName:controlName];
    }
    
    if (view) {
      if (!view.menu) {
        view.menu = [[NSMenu alloc] init];
      }
      NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:itemTitle action:@selector(handleMenuItemClicked:) keyEquivalent:@""];
      [item setTarget:delegate];
      [item setRepresentedObject:handlerName];
      [view.menu addItem:item];
    }
  });
}

main__WindowInfo *window_app_init(void *params) {
  main__WindowParams window_params = {0};
  if (params) {
    window_params = *(main__WindowParams *)params;
  }

  NSApplication *app = [NSApplication sharedApplication];
  AppDelegate *delegate = [[AppDelegate alloc] initWithParams:window_params];
  [app setActivationPolicy:NSApplicationActivationPolicyRegular];
  [app setDelegate:delegate];

  main__WindowInfo *info = malloc(sizeof(main__WindowInfo));
  info->app = app;
  info->app_delegate = delegate;
  return info;
}

void window_app_run(main__WindowInfo *info) {
  NSApplication *app = (NSApplication *)info->app;
  [app run];
}

void window_app_exit(main__WindowInfo *info) {
  NSApplication *app = (NSApplication *)info->app;
  [app terminate:app];
}

void window_set_input_text(main__WindowInfo *info, const char *text) {
  window_set_control_text_by_name(info, "name", text);
}

char *window_get_input_text(main__WindowInfo *info) {
  return window_get_control_text_by_name(info, "name");
}

void window_set_text_area(main__WindowInfo *info, const char *text) {
  window_set_control_text_by_name(info, "notes", text);
}

char *window_get_text_area(main__WindowInfo *info) {
  return window_get_control_text_by_name(info, "notes");
}

void window_set_status_text(main__WindowInfo *info, const char *text) {
  window_set_control_text_by_name(info, "status", text);
}

void window_set_title_text(main__WindowInfo *info, const char *text) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  [delegate.window setTitle:nsstring(text)];
}

void window_set_always_on_top(main__WindowInfo *info, int enabled) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  if (!delegate.window) {
    return;
  }
  [delegate.window setLevel:enabled ? NSFloatingWindowLevel : NSNormalWindowLevel];
}

int window_get_always_on_top(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  if (!delegate.window) {
    return 0;
  }
  return delegate.window.level == NSFloatingWindowLevel ? 1 : 0;
}

void window_set_button_title(main__WindowInfo *info, const char *text) {
  window_set_control_text_by_name(info, "run", text);
}

void window_set_checkbox_text(main__WindowInfo *info, const char *text) {
  window_set_control_text_by_name(info, "ready", text);
}

void window_set_checkbox_state(main__WindowInfo *info, int checked) {
  window_set_control_bool_by_name(info, "ready", checked);
}

int window_get_checkbox_state(main__WindowInfo *info) {
  return window_get_control_bool_by_name(info, "ready");
}

void window_set_number_value(main__WindowInfo *info, int value) {
  window_set_control_int_by_name(info, "number", value);
}

int window_get_number_value(main__WindowInfo *info) {
  return window_get_control_int_by_name(info, "number");
}

static BOOL isDarkColor(NSColor *color) {
  if (!color) return YES;
  NSColor *rgbColor = [color colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
  if (!rgbColor) return YES;
  CGFloat r=0, g=0, b=0, a=0;
  [rgbColor getRed:&r green:&g blue:&b alpha:&a];
  double luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b;
  return luminance < 0.5;
}

static NSColor *getContrastColor(NSColor *color) {
  return isDarkColor(color) ? [NSColor whiteColor] : [NSColor blackColor];
}

void window_set_background_color(main__WindowInfo *info, const char *color) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSColor *backgroundColor = colorFromString(color);
  NSColor *fontColor = delegate.currentFontColor;
  if (!fontColor) {
    fontColor = getContrastColor(backgroundColor);
  } else {
    NSColor *rgbBg = [backgroundColor colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
    NSColor *rgbFg = [fontColor colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
    if (rgbBg && rgbFg) {
      CGFloat r1=0, g1=0, b1=0, a1=0;
      CGFloat r2=0, g2=0, b2=0, a2=0;
      [rgbBg getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
      [rgbFg getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
      double lum1 = 0.2126 * r1 + 0.7152 * g1 + 0.0722 * b1;
      double lum2 = 0.2126 * r2 + 0.7152 * g2 + 0.0722 * b2;
      if (fabs(lum1 - lum2) < 0.25) {
        fontColor = getContrastColor(backgroundColor);
      }
    }
  }
  [delegate applyColors:backgroundColor fontColor:fontColor];
}

void window_set_font_color(main__WindowInfo *info, const char *color) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSColor *fontColor = colorFromString(color);
  NSColor *backgroundColor = delegate.currentBackgroundColor ?: [NSColor colorWithCalibratedWhite:0.12 alpha:1.0];
  
  NSColor *rgbBg = [backgroundColor colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
  NSColor *rgbFg = [fontColor colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
  if (rgbBg && rgbFg) {
    CGFloat r1=0, g1=0, b1=0, a1=0;
    CGFloat r2=0, g2=0, b2=0, a2=0;
    [rgbBg getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [rgbFg getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    double lum1 = 0.2126 * r1 + 0.7152 * g1 + 0.0722 * b1;
    double lum2 = 0.2126 * r2 + 0.7152 * g2 + 0.0722 * b2;
    if (fabs(lum1 - lum2) < 0.25) {
      fontColor = getContrastColor(backgroundColor);
    }
  }
  [delegate applyColors:backgroundColor fontColor:fontColor];
}

void window_set_control_background_color_by_name(main__WindowInfo *info, const char *name, const char *color) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSColor *backgroundColor = colorFromString(color);
  [delegate applyStyleToControlNamed:nsstring(name) backgroundColor:backgroundColor fontColor:nil];
}

void window_set_control_font_color_by_name(main__WindowInfo *info, const char *name, const char *color) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSColor *fontColor = colorFromString(color);
  [delegate applyStyleToControlNamed:nsstring(name) backgroundColor:nil fontColor:fontColor];
}

void window_set_control_width_by_name(main__WindowInfo *info, const char *name, int width) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (!view) return;
  
  NSLayoutConstraint *found = nil;
  for (NSLayoutConstraint *constraint in view.constraints) {
    if (constraint.firstAttribute == NSLayoutAttributeWidth && constraint.relation == NSLayoutRelationEqual) {
      found = constraint;
      break;
    }
  }
  
  if (found) {
    found.constant = width;
  } else {
    [view.widthAnchor constraintEqualToConstant:width].active = YES;
  }
  [view setNeedsLayout:YES];
}

void window_set_control_height_by_name(main__WindowInfo *info, const char *name, int height) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (!view) return;
  
  NSLayoutConstraint *found = nil;
  for (NSLayoutConstraint *constraint in view.constraints) {
    if (constraint.firstAttribute == NSLayoutAttributeHeight && constraint.relation == NSLayoutRelationEqual) {
      found = constraint;
      break;
    }
  }
  
  if (found) {
    found.constant = height;
  } else {
    [view.heightAnchor constraintEqualToConstant:height].active = YES;
  }
  [view setNeedsLayout:YES];
}

void window_set_control_font_size_by_name(main__WindowInfo *info, const char *name, int size) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (!view) return;
  
  void (^applyFont)(id) = ^(id target) {
    if ([target respondsToSelector:@selector(setFont:)]) {
      NSFont *oldFont = [target font];
      NSFont *newFont = nil;
      if (oldFont) {
        newFont = [[NSFontManager sharedFontManager] convertFont:oldFont toSize:size];
      } else {
        newFont = [NSFont systemFontOfSize:size];
      }
      [target setFont:newFont];
    }
  };

  if ([view isKindOfClass:[NSScrollView class]]) {
    NSScrollView *scroll = (NSScrollView *)view;
    if ([scroll.documentView isKindOfClass:[NSTextView class]]) {
      applyFont(scroll.documentView);
    }
  } else {
    applyFont(view);
  }
}

void window_set_control_font_bold_by_name(main__WindowInfo *info, const char *name, int bold) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (!view) return;
  
  void (^applyFontBold)(id) = ^(id target) {
    if ([target respondsToSelector:@selector(setFont:)]) {
      NSFont *oldFont = [target font] ?: [NSFont systemFontOfSize:13];
      NSFont *newFont = nil;
      if (bold) {
        newFont = [[NSFontManager sharedFontManager] convertFont:oldFont toHaveTrait:NSBoldFontMask];
      } else {
        newFont = [[NSFontManager sharedFontManager] convertFont:oldFont toNotHaveTrait:NSBoldFontMask];
      }
      if (newFont) {
        [target setFont:newFont];
      }
    }
  };

  if ([view isKindOfClass:[NSScrollView class]]) {
    NSScrollView *scroll = (NSScrollView *)view;
    if ([scroll.documentView isKindOfClass:[NSTextView class]]) {
      applyFontBold(scroll.documentView);
    }
  } else {
    applyFontBold(view);
  }
}

void window_set_control_font_name_by_name(main__WindowInfo *info, const char *name, const char *font_name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (!view) return;
  NSString *fontName = nsstring(font_name);
  
  void (^applyFontName)(id) = ^(id target) {
    if ([target respondsToSelector:@selector(setFont:)]) {
      NSFont *oldFont = [target font] ?: [NSFont systemFontOfSize:13];
      CGFloat size = oldFont ? [oldFont pointSize] : 13;
      NSFont *newFont = [NSFont fontWithName:fontName size:size];
      if (!newFont) {
        newFont = [NSFont systemFontOfSize:size];
      }
      [target setFont:newFont];
    }
  };

  if ([view isKindOfClass:[NSScrollView class]]) {
    NSScrollView *scroll = (NSScrollView *)view;
    if ([scroll.documentView isKindOfClass:[NSTextView class]]) {
      applyFontName(scroll.documentView);
    }
  } else {
    applyFontName(view);
  }
}

void window_set_padding(main__WindowInfo *info, int padding) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  dispatch_async(dispatch_get_main_queue(), ^{
    if (delegate.mainStackView) {
      [delegate.mainStackView setEdgeInsets:NSEdgeInsetsMake(padding, padding, padding, padding)];
      [delegate.mainStackView setNeedsLayout:YES];
    }
  });
}

void window_set_spacing(main__WindowInfo *info, int spacing) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  dispatch_async(dispatch_get_main_queue(), ^{
    if (delegate.mainStackView) {
      [delegate.mainStackView setSpacing:(double)spacing];
      [delegate.mainStackView setNeedsLayout:YES];
    }
  });
}

void window_set_responsive_layout(main__WindowInfo *info, int enabled) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  if (!delegate) return;
  delegate.responsiveLayoutEnabled = enabled != 0;
  dispatch_async(dispatch_get_main_queue(), ^{
    if (delegate.mainStackView) {
      [delegate.mainStackView setNeedsLayout:YES];
    }
  });
}

void *window_add_group_box_control(main__WindowInfo *info, const char *name, const char *title) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSBox *box = nil;
  void (^runBlock)(void) = ^{
    box = [[NSBox alloc] initWithFrame:NSZeroRect];
    [box setTitle:nsstring(title)];
    [box setBorderType:NSLineBorder];
    [box setBoxType:NSBoxCustom];
    [box setContentViewMargins:NSMakeSize(12, 12)];
    [box setWantsLayer:YES];
    box.layer.cornerRadius = 10.0;
    box.layer.borderWidth = 1.0;
    box.layer.borderColor = [modernBorderColor() CGColor];
    box.layer.backgroundColor = (delegate.currentBackgroundColor ?: modernElevatedSurfaceColor()).CGColor;
    
    [delegate addControlToLayout:box];
    NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    delegate.controlsByName[key] = box;
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)box;
}

void *window_add_tabs_control(main__WindowInfo *info, const char *name, const char **titles, int titles_count) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSTabView *tabs = nil;
  void (^runBlock)(void) = ^{
    tabs = [[NSTabView alloc] initWithFrame:NSZeroRect];
    [tabs setTabViewType:NSTopTabsBezelBorder];
    [tabs setControlSize:NSSmallControlSize];
    [tabs setFont:[NSFont systemFontOfSize:12]];
    [tabs setTranslatesAutoresizingMaskIntoConstraints:NO];
    [tabs.widthAnchor constraintLessThanOrEqualToConstant:420].active = YES;
    [tabs.heightAnchor constraintEqualToConstant:32].active = YES;
    for (int i = 0; i < titles_count; i++) {
      NSTabViewItem *item = [[NSTabViewItem alloc] initWithIdentifier:[NSString stringWithFormat:@"tab_%d", i]];
      [item setLabel:nsstring(titles[i])];
      [tabs addTabViewItem:item];
    }
    [delegate addControlToLayout:tabs];
    NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    delegate.controlsByName[key] = tabs;
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)tabs;
}

void *window_add_scroll_view_control(main__WindowInfo *info, const char *name, int height) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSScrollView *scroll = nil;
  void (^runBlock)(void) = ^{
    scroll = [[NSScrollView alloc] initWithFrame:NSZeroRect];
    [scroll setHasVerticalScroller:YES];
    [scroll setHasHorizontalScroller:NO];
    [scroll.heightAnchor constraintEqualToConstant:height].active = YES;
    NSView *content = [[NSView alloc] initWithFrame:NSZeroRect];
    [content setFrameSize:NSMakeSize(300, height)];
    [scroll setDocumentView:content];
    [delegate addControlToLayout:scroll];
    NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    delegate.controlsByName[key] = scroll;
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)scroll;
}

void window_focus_control(main__WindowInfo *info, const char *name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  dispatch_async(dispatch_get_main_queue(), ^{
    NSView *view = [delegate viewForControlName:nsstring(name)];
    if (view) {
      [delegate.window makeFirstResponder:view];
    }
  });
}

void window_set_placeholder_by_name(main__WindowInfo *info, const char *name, const char *text) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  dispatch_async(dispatch_get_main_queue(), ^{
    NSView *view = [delegate viewForControlName:nsstring(name)];
    if ([view isKindOfClass:[NSTextField class]]) {
      [(NSTextField *)view setPlaceholderString:nsstring(text)];
    }
  });
}

void window_set_error_by_name(main__WindowInfo *info, const char *name, const char *text) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  dispatch_async(dispatch_get_main_queue(), ^{
    NSView *view = [delegate viewForControlName:nsstring(name)];
    if (view) {
      [view setToolTip:nsstring(text)];
      [view setWantsLayer:YES];
      if (text && *text) {
        view.layer.borderWidth = 1.2;
        view.layer.borderColor = [[NSColor systemRedColor] CGColor];
        view.layer.cornerRadius = 8.0;
      } else {
        view.layer.borderWidth = 0.0;
        view.layer.borderColor = nil;
      }
    }
  });
}

void window_set_tooltip_by_name(main__WindowInfo *info, const char *name, const char *text) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  dispatch_async(dispatch_get_main_queue(), ^{
    NSView *view = [delegate viewForControlName:nsstring(name)];
    if (view) {
      [view setToolTip:nsstring(text)];
    }
  });
}

void window_set_default_button_by_name(main__WindowInfo *info, const char *name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  dispatch_async(dispatch_get_main_queue(), ^{
    NSView *view = [delegate viewForControlName:nsstring(name)];
    if ([view isKindOfClass:[NSButton class]]) {
      [(NSButton *)view setKeyEquivalent:@"\r"];
    }
  });
}

void window_run_after(main__WindowInfo *info, int ms, const char *handler_name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSString *handler = nsstring(handler_name);
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)ms * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
    vlang_dispatch_event(delegate.win_ptr, [handler UTF8String], "run_after", "");
  });
}

void window_show_toast(main__WindowInfo *info, const char *message) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  dispatch_async(dispatch_get_main_queue(), ^{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Notice"];
    [alert setInformativeText:nsstring(message)];
    [alert addButtonWithTitle:@"OK"];
    [alert setAlertStyle:NSAlertStyleInformational];
    [alert runModal];
  });
}

void window_open_url(main__WindowInfo *info, const char *url) {
  dispatch_async(dispatch_get_main_queue(), ^{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:nsstring(url)]];
  });
}

void window_copy_to_clipboard(main__WindowInfo *info, const char *text) {
  dispatch_async(dispatch_get_main_queue(), ^{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard setString:nsstring(text) forType:NSPasteboardTypeString];
  });
}

// C creation bridges calling AppDelegate make methods
void *window_add_label_control(main__WindowInfo *info, const char *name, const char *text) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makeLabelWithName:nsstring(name) text:nsstring(text)];
}

void *window_add_input_control(main__WindowInfo *info, const char *name, const char *value) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makeTextFieldWithName:nsstring(name) value:nsstring(value)];
}

void *window_add_password_control(main__WindowInfo *info, const char *name, const char *value) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makePasswordFieldWithName:nsstring(name) value:nsstring(value)];
}

void *window_add_textarea_control(main__WindowInfo *info, const char *name, const char *value) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makeTextAreaWithName:nsstring(name) value:nsstring(value)];
}

void *window_add_html_view_control(main__WindowInfo *info, const char *name, const char *html) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makeHtmlViewWithName:nsstring(name) html:nsstring(html)];
}

void *window_add_drop_zone_control(main__WindowInfo *info, const char *name, const char *label) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makeDropZoneWithName:nsstring(name) label:nsstring(label)];
}

void *window_add_checkbox_control(main__WindowInfo *info, const char *name, const char *text, int checked) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makeCheckboxWithName:nsstring(name) label:nsstring(text) checked:checked == 1];
}

void *window_add_button_control(main__WindowInfo *info, const char *name, const char *text) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makeButtonWithName:nsstring(name) title:nsstring(text)];
}

void *window_add_number_control(main__WindowInfo *info, const char *name, int value) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makeNumberFieldWithName:nsstring(name) value:value];
}

void *window_add_slider_control(main__WindowInfo *info, const char *name, int value) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makeSliderWithName:nsstring(name) value:value];
}

void *window_add_theme_menu_control(main__WindowInfo *info, const char *name, const char *selected) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makePopUpButtonWithName:nsstring(name) selected:nsstring(selected)];
}

void *window_add_color_well_control(main__WindowInfo *info, const char *name, const char *color) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makeColorWellWithName:nsstring(name) color:nsstring(color)];
}

void *window_add_date_picker_control(main__WindowInfo *info, const char *name, const char *date) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makeDatePickerWithName:nsstring(name) date:nsstring(date)];
}

void *window_add_mode_control_control(main__WindowInfo *info, const char *name, const char *selected) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makeSegmentedControlWithName:nsstring(name) selected:nsstring(selected)];
}

void *window_add_progress_indicator_control(main__WindowInfo *info, const char *name, int value) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  return [delegate makeProgressIndicatorWithName:nsstring(name) value:value];
}

// Generic control styling and access
void window_set_control_text(void *control, const char *text) {
  NSView *view = (NSView *)control;
  NSString *nsText = nsstring(text);
  if ([view isKindOfClass:[NSScrollView class]]) {
    NSView *doc = [(NSScrollView *)view documentView];
    if ([doc isKindOfClass:[NSTextView class]]) {
      view = doc;
    }
  }
  
  if ([view isKindOfClass:[NSTextField class]]) {
    [(NSTextField *)view setStringValue:nsText];
  } else if ([view isKindOfClass:[NSTextView class]]) {
    [(NSTextView *)view setString:nsText];
  } else if ([view isKindOfClass:[WKWebView class]]) {
    [(WKWebView *)view loadHTMLString:nsText baseURL:nil];
  } else if ([view isKindOfClass:[NSButton class]]) {
    [(NSButton *)view setTitle:nsText];
  } else if ([view isKindOfClass:[NSSlider class]]) {
    [(NSSlider *)view setDoubleValue:[nsText doubleValue]];
  } else if ([view isKindOfClass:[NSColorWell class]]) {
    [(NSColorWell *)view setColor:colorFromString(text)];
  } else if ([view isKindOfClass:[NSDatePicker class]]) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:nsText];
    if (date) {
      [(NSDatePicker *)view setDateValue:date];
    } else {
      [formatter setDateStyle:NSDateFormatterMediumStyle];
      date = [formatter dateFromString:nsText];
      if (date) {
        [(NSDatePicker *)view setDateValue:date];
      }
    }
  } else if ([view isKindOfClass:[NSPopUpButton class]]) {
    [(NSPopUpButton *)view selectItemWithTitle:nsText];
  } else if ([view isKindOfClass:[NSSegmentedControl class]]) {
    NSSegmentedControl *seg = (NSSegmentedControl *)view;
    for (NSInteger i = 0; i < [seg segmentCount]; i++) {
      if ([[seg labelForSegment:i] isEqualToString:nsText]) {
        [seg setSelectedSegment:i];
        break;
      }
    }
  } else if ([view isKindOfClass:[NSProgressIndicator class]]) {
    [(NSProgressIndicator *)view setDoubleValue:[nsText doubleValue]];
  } else if ([view isKindOfClass:[NSLevelIndicator class]]) {
    [(NSLevelIndicator *)view setDoubleValue:[nsText doubleValue]];
  } else if ([view isKindOfClass:[NSPathControl class]]) {
    if (nsText.length > 0) {
      [(NSPathControl *)view setURL:[NSURL fileURLWithPath:nsText]];
    } else {
      [(NSPathControl *)view setURL:nil];
    }
  } else if ([view isKindOfClass:[NSSwitch class]]) {
    [(NSSwitch *)view setState:[nsText isEqualToString:@"true"] || [nsText isEqualToString:@"1"] ? NSControlStateValueOn : NSControlStateValueOff];
  } else if ([view isKindOfClass:[NSStackView class]]) {
    NSStackView *radioStack = (NSStackView *)view;
    for (NSView *subview in [radioStack arrangedSubviews]) {
      if ([subview isKindOfClass:[NSButton class]]) {
        NSButton *btn = (NSButton *)subview;
        if ([[btn title] isEqualToString:nsText]) {
          [btn setState:NSControlStateValueOn];
        } else {
          [btn setState:NSControlStateValueOff];
        }
      }
    }
  }
}

char *window_get_control_text(void *control) {
  NSView *view = (NSView *)control;
  if ([view isKindOfClass:[NSScrollView class]]) {
    NSView *doc = [(NSScrollView *)view documentView];
    if ([doc isKindOfClass:[NSTextView class]]) {
      view = doc;
    } else if ([doc isKindOfClass:[NSOutlineView class]]) {
      view = doc;
    } else if ([doc isKindOfClass:[NSTableView class]]) {
      view = doc;
    }
  }
  
  NSString *result = @"";
  if ([view isKindOfClass:[NSTextField class]]) {
    result = [(NSTextField *)view stringValue];
  } else if ([view isKindOfClass:[NSTextView class]]) {
    result = [(NSTextView *)view string];
  } else if ([view isKindOfClass:[NSButton class]]) {
    if ([view isKindOfClass:[NSSwitch class]]) {
      result = [(NSSwitch *)view state] == NSControlStateValueOn ? @"true" : @"false";
    } else {
      result = [(NSButton *)view title];
    }
  } else if ([view isKindOfClass:[NSSlider class]]) {
    result = [NSString stringWithFormat:@"%.0f", [(NSSlider *)view doubleValue]];
  } else if ([view isKindOfClass:[NSColorWell class]]) {
    NSColor *color = [(NSColorWell *)view color];
    CGFloat r=0, g=0, b=0, a=0;
    NSColor *rgbColor = [color colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
    if (rgbColor) {
      [rgbColor getRed:&r green:&g blue:&b alpha:&a];
    } else {
      [color getRed:&r green:&g blue:&b alpha:&a];
    }
    result = [NSString stringWithFormat:@"#%02X%02X%02X", (int)(r * 255.99), (int)(g * 255.99), (int)(b * 255.99)];
  } else if ([view isKindOfClass:[NSDatePicker class]]) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    result = [formatter stringFromDate:[(NSDatePicker *)view dateValue]];
  } else if ([view isKindOfClass:[NSPopUpButton class]]) {
    result = [(NSPopUpButton *)view titleOfSelectedItem] ?: @"";
  } else if ([view isKindOfClass:[NSSegmentedControl class]]) {
    NSSegmentedControl *seg = (NSSegmentedControl *)view;
    NSInteger sel = [seg selectedSegment];
    if (sel >= 0 && sel < [seg segmentCount]) {
      result = [seg labelForSegment:sel];
    }
  } else if ([view isKindOfClass:[NSProgressIndicator class]]) {
    result = [NSString stringWithFormat:@"%.0f", [(NSProgressIndicator *)view doubleValue]];
  } else if ([view isKindOfClass:[NSLevelIndicator class]]) {
    result = [NSString stringWithFormat:@"%.1f", [(NSLevelIndicator *)view doubleValue]];
  } else if ([view isKindOfClass:[NSPathControl class]]) {
    NSURL *url = [(NSPathControl *)view URL];
    result = url ? [url path] : @"";
  } else if ([view isKindOfClass:[NSOutlineView class]]) {
    NSOutlineView *outlineView = (NSOutlineView *)view;
    NSInteger selectedRow = [outlineView selectedRow];
    if (selectedRow != -1) {
      TreeItem *item = [outlineView itemAtRow:selectedRow];
      if (item) {
        result = item.itemId;
      }
    }
  } else if ([view isKindOfClass:[NSTableView class]]) {
    NSTableView *tableView = (NSTableView *)view;
    AppDelegate *delegate = (AppDelegate *)tableView.delegate;
    NSString *key = [tableView.identifier lowercaseString];
    NSArray *items = delegate.listItemsByName[key];
    NSInteger selectedRow = [tableView selectedRow];
    if (items && selectedRow >= 0 && selectedRow < items.count) {
      result = items[selectedRow];
    }
  } else if ([view isKindOfClass:[NSSwitch class]]) {
    result = [(NSSwitch *)view state] == NSControlStateValueOn ? @"true" : @"false";
  } else if ([view isKindOfClass:[NSStackView class]]) {
    NSStackView *radioStack = (NSStackView *)view;
    for (NSView *subview in [radioStack arrangedSubviews]) {
      if ([subview isKindOfClass:[NSButton class]]) {
        NSButton *btn = (NSButton *)subview;
        if ([btn state] == NSControlStateValueOn) {
          result = [btn title];
          break;
        }
      }
    }
  }
  const char *utf8 = [result UTF8String];
  return utf8 ? strdup(utf8) : strdup("");
}

void window_set_control_bool(void *control, int checked) {
  NSView *view = (NSView *)control;
  if ([view isKindOfClass:[NSButton class]]) {
    [(NSButton *)view setState:checked ? NSOnState : NSOffState];
  } else if ([view isKindOfClass:[NSSwitch class]]) {
    [(NSSwitch *)view setState:checked ? NSControlStateValueOn : NSControlStateValueOff];
  } else if ([view isKindOfClass:[NSProgressIndicator class]]) {
    NSProgressIndicator *prog = (NSProgressIndicator *)view;
    if (prog.style == NSProgressIndicatorStyleSpinning) {
      if (checked) {
        [prog startAnimation:nil];
        [prog setHidden:NO];
      } else {
        [prog stopAnimation:nil];
        [prog setHidden:YES];
      }
    }
  }
}

int window_get_control_bool(void *control) {
  NSView *view = (NSView *)control;
  if ([view isKindOfClass:[NSButton class]]) {
    return [(NSButton *)view state] == NSOnState ? 1 : 0;
  } else if ([view isKindOfClass:[NSSwitch class]]) {
    return [(NSSwitch *)view state] == NSControlStateValueOn ? 1 : 0;
  } else if ([view isKindOfClass:[NSProgressIndicator class]]) {
    NSProgressIndicator *prog = (NSProgressIndicator *)view;
    if (prog.style == NSProgressIndicatorStyleSpinning) {
      return [prog isHidden] ? 0 : 1;
    }
  }
  return 0;
}

void window_set_control_int(void *control, int value) {
  NSView *view = (NSView *)control;
  if ([view isKindOfClass:[NSTextField class]]) {
    [(NSTextField *)view setIntValue:value];
  } else if ([view isKindOfClass:[NSSlider class]]) {
    [(NSSlider *)view setIntValue:value];
  } else if ([view isKindOfClass:[NSSegmentedControl class]]) {
    [(NSSegmentedControl *)view setSelectedSegment:value];
  } else if ([view isKindOfClass:[NSProgressIndicator class]]) {
    [(NSProgressIndicator *)view setDoubleValue:(double)value];
  } else if ([view isKindOfClass:[NSLevelIndicator class]]) {
    [(NSLevelIndicator *)view setIntValue:value];
  } else if ([view isKindOfClass:[NSStackView class]]) {
    NSStackView *radioStack = (NSStackView *)view;
    NSInteger idx = 0;
    for (NSView *subview in [radioStack arrangedSubviews]) {
      if ([subview isKindOfClass:[NSButton class]]) {
        NSButton *btn = (NSButton *)subview;
        if (idx == value) {
          [btn setState:NSControlStateValueOn];
        } else {
          [btn setState:NSControlStateValueOff];
        }
        idx++;
      }
    }
  }
}

int window_get_control_int(void *control) {
  NSView *view = (NSView *)control;
  if ([view isKindOfClass:[NSTextField class]]) {
    return [(NSTextField *)view intValue];
  } else if ([view isKindOfClass:[NSSlider class]]) {
    return [(NSSlider *)view intValue];
  } else if ([view isKindOfClass:[NSSegmentedControl class]]) {
    return (int)[(NSSegmentedControl *)view selectedSegment];
  } else if ([view isKindOfClass:[NSProgressIndicator class]]) {
    return (int)[(NSProgressIndicator *)view doubleValue];
  } else if ([view isKindOfClass:[NSLevelIndicator class]]) {
    return (int)[(NSLevelIndicator *)view intValue];
  } else if ([view isKindOfClass:[NSStackView class]]) {
    NSStackView *radioStack = (NSStackView *)view;
    NSInteger idx = 0;
    for (NSView *subview in [radioStack arrangedSubviews]) {
      if ([subview isKindOfClass:[NSButton class]]) {
        NSButton *btn = (NSButton *)subview;
        if ([btn state] == NSControlStateValueOn) {
          return (int)idx;
        }
        idx++;
      }
    }
    return -1;
  }
  return 0;
}

void window_set_control_text_by_name(main__WindowInfo *info, const char *name, const char *text) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (view) {
    window_set_control_text(view, text);
    // Extra row-specific updates if needed (e.g. number stepper text or slider label value)
    if ([view isKindOfClass:[NSTextField class]]) {
      NSView *parent = view.superview;
      if ([parent isKindOfClass:[NSStackView class]]) {
        NSStackView *row = (NSStackView *)parent;
        if (row.arrangedSubviews.count > 1 && [row.arrangedSubviews[1] isKindOfClass:[NSStepper class]]) {
          NSStepper *stepper = (NSStepper *)row.arrangedSubviews[1];
          [stepper setDoubleValue:[nsstring(text) doubleValue]];
        }
      }
    } else if ([view isKindOfClass:[NSSlider class]]) {
      NSView *parent = view.superview;
      if ([parent isKindOfClass:[NSStackView class]]) {
        NSStackView *row = (NSStackView *)parent;
        if (row.arrangedSubviews.count > 1 && [row.arrangedSubviews[1] isKindOfClass:[NSTextField class]]) {
          NSTextField *label = (NSTextField *)row.arrangedSubviews[1];
          [label setStringValue:[NSString stringWithFormat:@"Value: %d", [nsstring(text) intValue]]];
        }
      }
    }
  }
}

char *window_get_control_text_by_name(main__WindowInfo *info, const char *name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (view) {
    return window_get_control_text(view);
  }
  return strdup("");
}

void window_set_control_bool_by_name(main__WindowInfo *info, const char *name, int checked) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (view) {
    window_set_control_bool(view, checked);
  }
}

int window_get_control_bool_by_name(main__WindowInfo *info, const char *name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (view) {
    return window_get_control_bool(view);
  }
  return 0;
}

void window_set_control_int_by_name(main__WindowInfo *info, const char *name, int value) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (view) {
    window_set_control_int(view, value);
    if ([view isKindOfClass:[NSTextField class]]) {
      NSView *parent = view.superview;
      if ([parent isKindOfClass:[NSStackView class]]) {
        NSStackView *row = (NSStackView *)parent;
        if (row.arrangedSubviews.count > 1 && [row.arrangedSubviews[1] isKindOfClass:[NSStepper class]]) {
          NSStepper *stepper = (NSStepper *)row.arrangedSubviews[1];
          [stepper setDoubleValue:(double)value];
        }
      }
    } else if ([view isKindOfClass:[NSSlider class]]) {
      NSView *parent = view.superview;
      if ([parent isKindOfClass:[NSStackView class]]) {
        NSStackView *row = (NSStackView *)parent;
        if (row.arrangedSubviews.count > 1 && [row.arrangedSubviews[1] isKindOfClass:[NSTextField class]]) {
          NSTextField *label = (NSTextField *)row.arrangedSubviews[1];
          [label setStringValue:[NSString stringWithFormat:@"Value: %d", value]];
        }
      }
    }
  }
}

int window_get_control_int_by_name(main__WindowInfo *info, const char *name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (view) {
    return window_get_control_int(view);
  }
  return 0;
}

void window_begin_row(main__WindowInfo *info, const char *name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  [delegate beginRowWithName:nsstring(name)];
}

void window_end_row(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  [delegate endRow];
}

void window_show_alert(main__WindowInfo *info, const char *title, const char *message) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  dispatch_async(dispatch_get_main_queue(), ^{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:nsstring(title)];
    [alert setInformativeText:nsstring(message)];
    [alert addButtonWithTitle:@"OK"];
    [alert setAlertStyle:NSAlertStyleInformational];
    [alert runModal];
  });
}

void window_show_alert_with_style(main__WindowInfo *info, const char *title, const char *message, const char *style) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSString *alertStyle = [[nsstring(style) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  dispatch_async(dispatch_get_main_queue(), ^{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:nsstring(title)];
    [alert setInformativeText:nsstring(message)];
    [alert addButtonWithTitle:@"OK"];
    
    if ([alertStyle isEqualToString:@"error"] || [alertStyle isEqualToString:@"critical"]) {
      [alert setAlertStyle:NSAlertStyleCritical];
    } else if ([alertStyle isEqualToString:@"warning"]) {
      [alert setAlertStyle:NSAlertStyleWarning];
    } else {
      [alert setAlertStyle:NSAlertStyleInformational];
    }
    
    [alert runModal];
  });
}

int window_show_confirm(main__WindowInfo *info, const char *title, const char *message) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSModalResponse response;
  if ([NSThread isMainThread]) {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:nsstring(title)];
    [alert setInformativeText:nsstring(message)];
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    [alert setAlertStyle:NSAlertStyleWarning];
    response = [alert runModal];
  } else {
    dispatch_sync(dispatch_get_main_queue(), ^{
      NSAlert *alert = [[NSAlert alloc] init];
      [alert setMessageText:nsstring(title)];
      [alert setInformativeText:nsstring(message)];
      [alert addButtonWithTitle:@"Yes"];
      [alert addButtonWithTitle:@"No"];
      [alert setAlertStyle:NSAlertStyleWarning];
      response = [alert runModal];
    });
  }
  return (response == NSAlertFirstButtonReturn) ? 1 : 0;
}

int window_show_choice_dialog(main__WindowInfo *info, const char *title, const char *message, const char **choices, int choices_count) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSModalResponse response;
  
  void (^runBlock)(void) = ^{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:nsstring(title)];
    [alert setInformativeText:nsstring(message)];
    [alert setAlertStyle:NSAlertStyleInformational];
    
    for (int i = 0; i < choices_count; i++) {
      [alert addButtonWithTitle:nsstring(choices[i])];
    }
    
    response = [alert runModal];
  };
  
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  
  return (int)(response - NSAlertFirstButtonReturn);
}

char *window_show_prompt(main__WindowInfo *info, const char *title, const char *message, const char *default_val) {
  __block NSString *inputString = nil;
  void (^runPrompt)(void) = ^{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:nsstring(title)];
    [alert setInformativeText:nsstring(message)];
    [alert addButtonWithTitle:@"OK"];
    [alert addButtonWithTitle:@"Cancel"];
    
    NSTextField *input = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 240, 24)];
    [input setStringValue:nsstring(default_val)];
    [alert setAccessoryView:input];
    
    NSModalResponse response = [alert runModal];
    if (response == NSAlertFirstButtonReturn) {
      [input validateEditing];
      inputString = [input stringValue];
    }
  };
  
  if ([NSThread isMainThread]) {
    runPrompt();
  } else {
    dispatch_sync(dispatch_get_main_queue(), ^{
      runPrompt();
    });
  }
  
  if (inputString) {
    return strdup([inputString UTF8String]);
  }
  return strdup("");
}

char *window_select_file(main__WindowInfo *info) {
  __block NSString *filePath = nil;
  void (^runPanel)(void) = ^{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:NO];
    
    if ([panel runModal] == NSModalResponseOK) {
      filePath = [[panel URL] path];
    }
  };
  
  if ([NSThread isMainThread]) {
    runPanel();
  } else {
    dispatch_sync(dispatch_get_main_queue(), ^{
      runPanel();
    });
  }
  
  if (filePath) {
    return strdup([filePath UTF8String]);
  }
  return strdup("");
}

char *window_select_file_with_extensions(main__WindowInfo *info, const char *extensions) {
  __block NSString *filePath = nil;
  NSString *extsString = nsstring(extensions);
  void (^runPanel)(void) = ^{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:NO];
    
    if (extsString.length > 0) {
      NSArray *exts = [extsString componentsSeparatedByString:@","];
      NSMutableArray *trimmedExts = [NSMutableArray array];
      for (NSString *ext in exts) {
        NSString *trimmed = [[ext stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByReplacingOccurrencesOfString:@"*" withString:@""];
        trimmed = [trimmed stringByReplacingOccurrencesOfString:@"." withString:@""];
        if (trimmed.length > 0) {
          [trimmedExts addObject:trimmed];
        }
      }
      if (trimmedExts.count > 0) {
        [panel setAllowedFileTypes:trimmedExts];
      }
    }
    
    if ([panel runModal] == NSModalResponseOK) {
      filePath = [[panel URL] path];
    }
  };
  
  if ([NSThread isMainThread]) {
    runPanel();
  } else {
    dispatch_sync(dispatch_get_main_queue(), ^{
      runPanel();
    });
  }
  
  if (filePath) {
    return strdup([filePath UTF8String]);
  }
  return strdup("");
}

char *window_select_folder(main__WindowInfo *info) {
  __block NSString *folderPath = nil;
  void (^runPanel)(void) = ^{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:NO];
    [panel setCanChooseDirectories:YES];
    [panel setAllowsMultipleSelection:NO];
    
    if ([panel runModal] == NSModalResponseOK) {
      folderPath = [[panel URL] path];
    }
  };
  
  if ([NSThread isMainThread]) {
    runPanel();
  } else {
    dispatch_sync(dispatch_get_main_queue(), ^{
      runPanel();
    });
  }
  
  if (folderPath) {
    return strdup([folderPath UTF8String]);
  }
  return strdup("");
}

char *window_save_file_picker(main__WindowInfo *info) {
  __block NSString *savePath = nil;
  void (^runPanel)(void) = ^{
    NSSavePanel *panel = [NSSavePanel savePanel];
    if ([panel runModal] == NSModalResponseOK) {
      savePath = [[panel URL] path];
    }
  };
  
  if ([NSThread isMainThread]) {
    runPanel();
  } else {
    dispatch_sync(dispatch_get_main_queue(), ^{
      runPanel();
    });
  }
  
  if (savePath) {
    return strdup([savePath UTF8String]);
  }
  return strdup("");
}

void window_set_control_visible_by_name(main__WindowInfo *info, const char *name, int visible) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (!view) return;
  
  NSView *targetView = view;
  if ([view.superview isKindOfClass:[NSStackView class]] && view.superview != delegate.mainStackView && view.superview != delegate.currentRowStack) {
    targetView = view.superview;
  }
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [targetView setHidden:!visible];
    [delegate.mainStackView setNeedsLayout:YES];
  });
}

int window_get_control_visible_by_name(main__WindowInfo *info, const char *name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (!view) return 0;
  
  NSView *targetView = view;
  if ([view.superview isKindOfClass:[NSStackView class]] && view.superview != delegate.mainStackView && view.superview != delegate.currentRowStack) {
    targetView = view.superview;
  }
  return [targetView isHidden] ? 0 : 1;
}

void window_set_control_enabled_by_name(main__WindowInfo *info, const char *name, int enabled) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (!view) return;
  
  dispatch_async(dispatch_get_main_queue(), ^{
    if ([view respondsToSelector:@selector(setEnabled:)]) {
      [(id)view setEnabled:enabled];
    }
  });
}

int window_get_control_enabled_by_name(main__WindowInfo *info, const char *name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSView *view = [delegate viewForControlName:nsstring(name)];
  if (!view) return 0;
  
  if ([view respondsToSelector:@selector(isEnabled)]) {
    return [(id)view isEnabled] ? 1 : 0;
  }
  return 1;
}

void window_set_interval(main__WindowInfo *info, int ms, const char *timer_name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  double seconds = (double)ms / 1000.0;
  NSString *timerName = nsstring(timer_name);
  
  dispatch_async(dispatch_get_main_queue(), ^{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:seconds repeats:YES block:^(NSTimer * _Nonnull t) {
      vlang_dispatch_event(delegate.win_ptr, [timerName UTF8String], "timer", "");
    }];
    
    NSString *key = [NSString stringWithFormat:@"timer_%@", timerName];
    delegate.controlsByName[key] = timer;
  });
}

void window_stop_interval(main__WindowInfo *info, const char *timer_name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSString *key = [NSString stringWithFormat:@"timer_%@", nsstring(timer_name)];
  
  dispatch_async(dispatch_get_main_queue(), ^{
    NSTimer *timer = delegate.controlsByName[key];
    if (timer) {
      [timer invalidate];
      [delegate.controlsByName removeObjectForKey:key];
    }
  });
}

void *window_add_list_box_control(main__WindowInfo *info, const char *name, const char **items, int items_count) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  
  __block NSScrollView *scrollView = nil;
  void (^runBlock)(void) = ^{
    scrollView = [[NSScrollView alloc] initWithFrame:NSZeroRect];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:NO];
    [scrollView setBorderType:NSNoBorder];
    [scrollView setWantsLayer:YES];
    scrollView.layer.cornerRadius = 8.0;
    scrollView.layer.borderWidth = 1.0;
    scrollView.layer.borderColor = [modernBorderColor() CGColor];
    
    // Add default Auto Layout sizing constraints
    [scrollView.widthAnchor constraintEqualToConstant:350].active = YES;
    [scrollView.heightAnchor constraintEqualToConstant:140].active = YES;
    
    NSTableView *tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, 350, 140)];
    [tableView setHeaderView:nil];
    [tableView setAllowsMultipleSelection:NO];
    [tableView setIdentifier:nsstring(name)];
    [tableView setBackgroundColor:[NSColor textBackgroundColor]];
    [tableView setRowSizeStyle:NSTableViewRowSizeStyleDefault];
    [tableView setIntercellSpacing:NSMakeSize(0, 0)];
    [tableView setRowHeight:26];
    [tableView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleRegular];
    [tableView setUsesAlternatingRowBackgroundColors:NO];
    
    if (@available(macOS 11.0, *)) {
      [tableView setStyle:NSTableViewStyleFullWidth];
    }
    
    NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"ListColumn"];
    [column setResizingMask:NSTableColumnAutoresizingMask];
    [column setWidth:330];
    [tableView addTableColumn:column];
    
    [tableView setDataSource:delegate];
    [tableView setDelegate:delegate];
    
    [scrollView setDocumentView:tableView];
    
    NSMutableArray *itemsArray = [NSMutableArray array];
    for (int i = 0; i < items_count; i++) {
      [itemsArray addObject:nsstring(items[i])];
    }
    
    if (!delegate.listItemsByName) {
      delegate.listItemsByName = [NSMutableDictionary dictionary];
    }
    NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    delegate.listItemsByName[key] = itemsArray;
    [tableView reloadData];
    
    applyStyleToView(scrollView, delegate.currentBackgroundColor, delegate.currentFontColor);
    
    [delegate addControlToLayout:scrollView];
    delegate.controlsByName[key] = scrollView;
  };
  
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)scrollView;
}

void window_update_list_items(main__WindowInfo *info, const char *name, const char **items, int items_count) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  dispatch_async(dispatch_get_main_queue(), ^{
    NSView *view = delegate.controlsByName[key];
    if ([view isKindOfClass:[NSScrollView class]]) {
      NSScrollView *scroll = (NSScrollView *)view;
      if ([scroll.documentView isKindOfClass:[NSTableView class]]) {
        NSTableView *tableView = (NSTableView *)scroll.documentView;
        NSMutableArray *itemsArray = [NSMutableArray array];
        for (int i = 0; i < items_count; i++) {
          [itemsArray addObject:nsstring(items[i])];
        }
        delegate.listItemsByName[key] = itemsArray;
        [tableView reloadData];
      }
    }
  });
}

void window_set_list_selected(main__WindowInfo *info, const char *name, int index) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  dispatch_async(dispatch_get_main_queue(), ^{
    NSView *view = delegate.controlsByName[key];
    if ([view isKindOfClass:[NSScrollView class]]) {
      NSScrollView *scroll = (NSScrollView *)view;
      if ([scroll.documentView isKindOfClass:[NSTableView class]]) {
        NSTableView *tableView = (NSTableView *)scroll.documentView;
        if (index >= 0 && index < [tableView numberOfRows]) {
          [tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:index] byExtendingSelection:NO];
          [tableView scrollRowToVisible:index];
        } else {
          [tableView deselectAll:nil];
        }
      }
    }
  });
}

int window_get_list_selected(main__WindowInfo *info, const char *name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  __block int result = -1;
  void (^runBlock)(void) = ^{
    NSView *view = delegate.controlsByName[key];
    if ([view isKindOfClass:[NSScrollView class]]) {
      NSScrollView *scroll = (NSScrollView *)view;
      if ([scroll.documentView isKindOfClass:[NSTableView class]]) {
        NSTableView *tableView = (NSTableView *)scroll.documentView;
        result = (int)[tableView selectedRow];
      }
    }
  };
  
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return result;
}

void *window_add_image_control(main__WindowInfo *info, const char *name, const char *file_path) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  
  __block NSImageView *imageView = nil;
  void (^runBlock)(void) = ^{
    imageView = [[NSImageView alloc] initWithFrame:NSZeroRect];
    [imageView setImageScaling:NSImageScaleProportionallyDown];
    [imageView setImageFrameStyle:NSImageFrameNone];
    
    // Add default Auto Layout constraints
    [imageView.widthAnchor constraintEqualToConstant:200].active = YES;
    [imageView.heightAnchor constraintEqualToConstant:200].active = YES;
    
    NSString *path = nsstring(file_path);
    if (path.length > 0) {
      NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
      if (image) {
        [imageView setImage:image];
      }
    }
    
    [delegate addControlToLayout:imageView];
    NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    delegate.controlsByName[key] = imageView;
  };
  
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)imageView;
}

void window_set_image_path(main__WindowInfo *info, const char *name, const char *file_path) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  dispatch_async(dispatch_get_main_queue(), ^{
    NSView *view = delegate.controlsByName[key];
    if ([view isKindOfClass:[NSImageView class]]) {
      NSImageView *imageView = (NSImageView *)view;
      NSString *path = nsstring(file_path);
      if (path.length > 0) {
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
        [imageView setImage:image];
      } else {
        [imageView setImage:nil];
      }
    }
  });
}

void window_enable_hover_events(main__WindowInfo *info, const char *name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  dispatch_async(dispatch_get_main_queue(), ^{
    NSView *view = delegate.controlsByName[key];
    if (!view) return;
    
    // Check if NSTrackingArea already exists to prevent duplicate area attachments
    for (NSTrackingArea *existingArea in view.trackingAreas) {
      if ([existingArea.userInfo[@"name"] isEqualToString:key]) {
        return; // Already registered
      }
    }
    
    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways | NSTrackingInVisibleRect;
    NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:view.bounds
                                                        options:options
                                                          owner:delegate
                                                       userInfo:@{@"name": key}];
    [view addTrackingArea:area];
  });
}

void window_add_vertical_spacer(main__WindowInfo *info, int height) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  dispatch_async(dispatch_get_main_queue(), ^{
    NSView *spacer = [[NSView alloc] initWithFrame:NSZeroRect];
    spacer.translatesAutoresizingMaskIntoConstraints = NO;
    [spacer.heightAnchor constraintEqualToConstant:height].active = YES;
    [delegate addControlToLayout:spacer];
  });
}

void window_add_horizontal_spacer(main__WindowInfo *info, int width) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  dispatch_async(dispatch_get_main_queue(), ^{
    NSView *spacer = [[NSView alloc] initWithFrame:NSZeroRect];
    spacer.translatesAutoresizingMaskIntoConstraints = NO;
    [spacer.widthAnchor constraintEqualToConstant:width].active = YES;
    [delegate addControlToLayout:spacer];
  });
}

void window_add_separator(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  dispatch_async(dispatch_get_main_queue(), ^{
    NSBox *separator = [[NSBox alloc] initWithFrame:NSZeroRect];
    [separator setBoxType:NSBoxSeparator];
    [delegate addControlToLayout:separator];
  });
}

void *window_add_table_control(main__WindowInfo *info, const char *name, const char **columns, int columns_count) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSScrollView *scrollView = nil;
  void (^runBlock)(void) = ^{
    scrollView = [[NSScrollView alloc] initWithFrame:NSZeroRect];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:YES];
    [scrollView setBorderType:NSNoBorder];
    [scrollView setWantsLayer:YES];
    scrollView.layer.cornerRadius = 8.0;
    scrollView.layer.borderWidth = 1.0;
    scrollView.layer.borderColor = [modernBorderColor() CGColor];
    
    [scrollView.widthAnchor constraintEqualToConstant:450].active = YES;
    [scrollView.heightAnchor constraintEqualToConstant:200].active = YES;
    
    NSTableView *tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, 450, 200)];
    [tableView setAllowsMultipleSelection:NO];
    [tableView setIdentifier:nsstring(name)];
    [tableView setGridStyleMask:NSTableViewSolidHorizontalGridLineMask | NSTableViewSolidVerticalGridLineMask];
    [tableView setRowHeight:26];
    
    if (@available(macOS 11.0, *)) {
      [tableView setStyle:NSTableViewStyleFullWidth];
    }
    
    for (int i = 0; i < columns_count; i++) {
      NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:[NSString stringWithFormat:@"Col_%d", i]];
      [column setTitle:nsstring(columns[i])];
      [column setWidth:100.0];
      [column setResizingMask:NSTableColumnAutoresizingMask];
      [tableView addTableColumn:column];
    }
    
    [tableView setDataSource:delegate];
    [tableView setDelegate:delegate];
    
    [scrollView setDocumentView:tableView];
    
    applyStyleToView(scrollView, delegate.currentBackgroundColor, delegate.currentFontColor);
    
    NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [delegate addControlToLayout:scrollView];
    delegate.controlsByName[key] = scrollView;
  };
  
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)scrollView;
}

void window_set_table_rows(main__WindowInfo *info, const char *name, const char **flat_items, int total_count, int columns_count) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *rowsArray = [NSMutableArray array];
    if (flat_items && total_count > 0 && columns_count > 0) {
      int row_count = total_count / columns_count;
      for (int r = 0; r < row_count; r++) {
        NSMutableArray *colsArray = [NSMutableArray array];
        for (int c = 0; c < columns_count; c++) {
          int idx = r * columns_count + c;
          [colsArray addObject:nsstring(flat_items[idx])];
        }
        [rowsArray addObject:colsArray];
      }
    }
    
    if (!delegate.tableItemsByName) {
      delegate.tableItemsByName = [NSMutableDictionary dictionary];
    }
    delegate.tableItemsByName[key] = rowsArray;
    
    NSView *view = delegate.controlsByName[key];
    if ([view isKindOfClass:[NSScrollView class]]) {
      NSScrollView *scroll = (NSScrollView *)view;
      if ([scroll.documentView isKindOfClass:[NSTableView class]]) {
        NSTableView *tableView = (NSTableView *)scroll.documentView;
        [tableView reloadData];
      }
    }
  });
}

void *window_add_tree_view_control(main__WindowInfo *info, const char *name, int height) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSScrollView *scrollView = nil;
  void (^runBlock)(void) = ^{
    scrollView = [[NSScrollView alloc] initWithFrame:NSZeroRect];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:YES];
    [scrollView setBorderType:NSNoBorder];
    [scrollView setWantsLayer:YES];
    scrollView.layer.cornerRadius = 8.0;
    scrollView.layer.borderWidth = 1.0;
    scrollView.layer.borderColor = [modernBorderColor() CGColor];
    
    [scrollView.widthAnchor constraintEqualToConstant:350].active = YES;
    [scrollView.heightAnchor constraintEqualToConstant:height].active = YES;
    
    NSOutlineView *outlineView = [[NSOutlineView alloc] initWithFrame:NSMakeRect(0, 0, 350, height)];
    [outlineView setAllowsMultipleSelection:NO];
    [outlineView setIdentifier:nsstring(name)];
    [outlineView setRowHeight:26];
    [outlineView setHeaderView:nil];
    
    if (@available(macOS 11.0, *)) {
      [outlineView setStyle:NSTableViewStyleFullWidth];
    }
    
    NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"OutlineColumn"];
    [column setResizingMask:NSTableColumnAutoresizingMask];
    [column setWidth:330.0];
    [outlineView addTableColumn:column];
    [outlineView setOutlineTableColumn:column];
    
    [outlineView setDataSource:delegate];
    [outlineView setDelegate:delegate];
    
    [scrollView setDocumentView:outlineView];
    
    applyStyleToView(scrollView, delegate.currentBackgroundColor, delegate.currentFontColor);
    
    NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [delegate addControlToLayout:scrollView];
    delegate.controlsByName[key] = scrollView;
  };
  
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)scrollView;
}

void window_set_tree_nodes(main__WindowInfo *info, const char *name, const char **flat_items, int total_count) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableDictionary<NSString *, TreeItem *> *nodesById = [NSMutableDictionary dictionary];
    NSMutableArray<TreeItem *> *roots = [NSMutableArray array];
    
    if (flat_items && total_count > 0) {
      int item_count = total_count / 3;
      // First pass: create all TreeItem instances
      for (int i = 0; i < item_count; i++) {
        NSString *itemId = nsstring(flat_items[i * 3]);
        NSString *parentId = nsstring(flat_items[i * 3 + 1]);
        NSString *text = nsstring(flat_items[i * 3 + 2]);
        
        TreeItem *item = [[[TreeItem alloc] init] autorelease];
        item.itemId = itemId;
        item.text = text;
        
        nodesById[itemId] = item;
      }
      
      // Second pass: establish hierarchy
      for (int i = 0; i < item_count; i++) {
        NSString *itemId = nsstring(flat_items[i * 3]);
        NSString *parentId = nsstring(flat_items[i * 3 + 1]);
        
        TreeItem *item = nodesById[itemId];
        if (parentId.length == 0) {
          [roots addObject:item];
        } else {
          TreeItem *parent = nodesById[parentId];
          if (parent) {
            item.parent = parent;
            [parent.children addObject:item];
          } else {
            [roots addObject:item];
          }
        }
      }
    }
    
    delegate.treeItemsByName[key] = roots;
    
    NSView *view = delegate.controlsByName[key];
    if ([view isKindOfClass:[NSScrollView class]]) {
      NSScrollView *scroll = (NSScrollView *)view;
      if ([scroll.documentView isKindOfClass:[NSOutlineView class]]) {
        NSOutlineView *outlineView = (NSOutlineView *)scroll.documentView;
        [outlineView reloadData];
        [outlineView expandItem:nil expandChildren:YES];
      }
    }
  });
}

char *window_get_tree_selected(main__WindowInfo *info, const char *name) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  __block NSString *result = nil;
  void (^runBlock)(void) = ^{
    NSView *view = delegate.controlsByName[key];
    if ([view isKindOfClass:[NSScrollView class]]) {
      NSScrollView *scroll = (NSScrollView *)view;
      if ([scroll.documentView isKindOfClass:[NSOutlineView class]]) {
        NSOutlineView *outlineView = (NSOutlineView *)scroll.documentView;
        NSInteger selectedRow = [outlineView selectedRow];
        if (selectedRow != -1) {
          TreeItem *item = [outlineView itemAtRow:selectedRow];
          if (item) {
            result = item.itemId;
          }
        }
      }
    }
  };
  
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return result ? strdup([result UTF8String]) : strdup("");
}

void window_set_tree_selected(main__WindowInfo *info, const char *name, const char *node_id) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  NSString *key = [[nsstring(name) lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  NSString *targetId = nsstring(node_id);
  
  dispatch_async(dispatch_get_main_queue(), ^{
    NSView *view = delegate.controlsByName[key];
    if ([view isKindOfClass:[NSScrollView class]]) {
      NSScrollView *scroll = (NSScrollView *)view;
      if ([scroll.documentView isKindOfClass:[NSOutlineView class]]) {
        NSOutlineView *outlineView = (NSOutlineView *)scroll.documentView;
        NSArray<TreeItem *> *roots = delegate.treeItemsByName[key];
        TreeItem *item = [delegate findTreeItemWithId:targetId inItems:roots];
        if (item) {
          TreeItem *parent = item.parent;
          NSMutableArray<TreeItem *> *parentsToExpand = [NSMutableArray array];
          while (parent) {
            [parentsToExpand insertObject:parent atIndex:0];
            parent = parent.parent;
          }
          for (TreeItem *p in parentsToExpand) {
            [outlineView expandItem:p];
          }
          
          NSInteger row = [outlineView rowForItem:item];
          if (row != -1) {
            [outlineView selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
            [outlineView scrollRowToVisible:row];
          }
        }
      }
    }
  });
}

void window_enable_status_bar(main__WindowInfo *info, const char *icon_path) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  dispatch_async(dispatch_get_main_queue(), ^{
    [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
    
    delegate.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    if (icon_path && strlen(icon_path) > 0) {
      NSImage *image = [[NSImage alloc] initWithContentsOfFile:nsstring(icon_path)];
      if (image) {
        [image setSize:NSMakeSize(18, 18)];
        [image setTemplate:YES];
        delegate.statusItem.button.image = image;
      } else {
        delegate.statusItem.button.title = delegate.window.title;
      }
    } else {
      delegate.statusItem.button.title = delegate.window.title;
    }
    
    delegate.statusBarMenu = [[NSMenu alloc] init];
    delegate.statusItem.menu = delegate.statusBarMenu;
    
    [delegate.window orderOut:nil];
  });
}

void window_show(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  dispatch_async(dispatch_get_main_queue(), ^{
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    [delegate.window makeKeyAndOrderFront:nil];
    [NSApp activateIgnoringOtherApps:YES];
  });
}

void window_run_on_main_thread(void *callback_fn, void *context) {
  void (*cb)(void *) = (void (*)(void *))callback_fn;
  dispatch_async(dispatch_get_main_queue(), ^{
    cb(context);
  });
}

void *window_add_dropdown_control(main__WindowInfo *info, const char *name, const char **items, int items_count, const char *selected) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSView *control = nil;
  void (^runBlock)(void) = ^{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < items_count; i++) {
      [arr addObject:nsstring(items[i])];
    }
    control = [delegate makeDropdownWithName:nsstring(name) items:arr selected:nsstring(selected)];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)control;
}

void *window_add_segmented_control_custom(main__WindowInfo *info, const char *name, const char **items, int items_count, const char *selected) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSView *control = nil;
  void (^runBlock)(void) = ^{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < items_count; i++) {
      [arr addObject:nsstring(items[i])];
    }
    control = [delegate makeSegmentedControlWithName:nsstring(name) items:arr selected:nsstring(selected)];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)control;
}

void *window_add_radio_group_control(main__WindowInfo *info, const char *name, const char **items, int items_count, const char *selected) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSView *control = nil;
  void (^runBlock)(void) = ^{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < items_count; i++) {
      [arr addObject:nsstring(items[i])];
    }
    control = [delegate makeRadioGroupWithName:nsstring(name) items:arr selected:nsstring(selected)];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)control;
}

void *window_add_switch_control(main__WindowInfo *info, const char *name, const char *label, int checked) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSView *control = nil;
  void (^runBlock)(void) = ^{
    control = [delegate makeSwitchWithName:nsstring(name) label:nsstring(label) checked:checked != 0];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)control;
}

void *window_add_search_field_control(main__WindowInfo *info, const char *name, const char *placeholder) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSView *control = nil;
  void (^runBlock)(void) = ^{
    control = [delegate makeSearchFieldWithName:nsstring(name) placeholder:nsstring(placeholder)];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)control;
}

void *window_add_combo_box_control(main__WindowInfo *info, const char *name, const char **items, int items_count, const char *selected) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSView *control = nil;
  void (^runBlock)(void) = ^{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < items_count; i++) {
      [arr addObject:nsstring(items[i])];
    }
    control = [delegate makeComboBoxWithName:nsstring(name) items:arr selected:nsstring(selected)];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)control;
}

void *window_add_level_indicator_control(main__WindowInfo *info, const char *name, int style, int min_val, int max_val, int value) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSView *control = nil;
  void (^runBlock)(void) = ^{
    control = [delegate makeLevelIndicatorWithName:nsstring(name) style:style minValue:(double)min_val maxValue:(double)max_val value:(double)value];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)control;
}

void *window_add_spinner_control(main__WindowInfo *info, const char *name, int active) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSView *control = nil;
  void (^runBlock)(void) = ^{
    control = [delegate makeSpinnerWithName:nsstring(name) active:active != 0];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)control;
}

void *window_add_path_control(main__WindowInfo *info, const char *name, const char *path) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSView *control = nil;
  void (^runBlock)(void) = ^{
    control = [delegate makePathControlWithName:nsstring(name) path:nsstring(path)];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)control;
}

void *window_add_token_field_control(main__WindowInfo *info, const char *name, const char *value) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block NSView *control = nil;
  void (^runBlock)(void) = ^{
    control = [delegate makeTokenFieldWithName:nsstring(name) value:nsstring(value)];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return (__bridge void *)control;
}

void window_set_min_size(main__WindowInfo *info, int width, int height) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    [delegate.window setMinSize:NSMakeSize(width, height)];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
}

void window_set_max_size(main__WindowInfo *info, int width, int height) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    [delegate.window setMaxSize:NSMakeSize(width, height)];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
}

void window_set_resizable(main__WindowInfo *info, int enabled) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    NSWindowStyleMask mask = [delegate.window styleMask];
    if (enabled) {
      mask |= NSWindowStyleMaskResizable;
    } else {
      mask &= ~NSWindowStyleMaskResizable;
    }
    [delegate.window setStyleMask:mask];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
}

void window_set_minimizable(main__WindowInfo *info, int enabled) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    NSWindowStyleMask mask = [delegate.window styleMask];
    if (enabled) {
      mask |= NSWindowStyleMaskMiniaturizable;
    } else {
      mask &= ~NSWindowStyleMaskMiniaturizable;
    }
    [delegate.window setStyleMask:mask];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
}

void window_set_maximizable(main__WindowInfo *info, int enabled) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    NSButton *zoomButton = [delegate.window standardWindowButton:NSWindowZoomButton];
    if (zoomButton) {
      [zoomButton setEnabled:enabled];
    }
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
}

void window_close(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    [delegate.window close];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_async(dispatch_get_main_queue(), runBlock);
  }
}

void window_hide(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    [delegate.window orderOut:nil];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_async(dispatch_get_main_queue(), runBlock);
  }
}

void window_center(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    [delegate.window center];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_async(dispatch_get_main_queue(), runBlock);
  }
}

void window_set_size(main__WindowInfo *info, int width, int height) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    [delegate.window setContentSize:NSMakeSize(width, height)];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
}

int window_get_width(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block int result = 0;
  void (^runBlock)(void) = ^{
    result = (int)delegate.window.frame.size.width;
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return result;
}

int window_get_height(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block int result = 0;
  void (^runBlock)(void) = ^{
    result = (int)delegate.window.frame.size.height;
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return result;
}

void window_set_position(main__WindowInfo *info, int x, int y) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    NSRect frame = delegate.window.frame;
    NSRect screenFrame = [[NSScreen mainScreen] frame];
    CGFloat flippedY = screenFrame.size.height - y - frame.size.height;
    [delegate.window setFrameOrigin:NSMakePoint(x, flippedY)];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_async(dispatch_get_main_queue(), runBlock);
  }
}

int window_get_x(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block int result = 0;
  void (^runBlock)(void) = ^{
    result = (int)delegate.window.frame.origin.x;
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return result;
}

int window_get_y(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block int result = 0;
  void (^runBlock)(void) = ^{
    NSRect screenFrame = [[NSScreen mainScreen] frame];
    result = (int)(screenFrame.size.height - delegate.window.frame.origin.y - delegate.window.frame.size.height);
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return result;
}

void window_set_opacity(main__WindowInfo *info, double opacity) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    [delegate.window setAlphaValue:opacity];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
}

double window_get_opacity(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block double result = 1.0;
  void (^runBlock)(void) = ^{
    result = (double)delegate.window.alphaValue;
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return result;
}

void window_toggle_fullscreen(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    [delegate.window toggleFullScreen:nil];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_async(dispatch_get_main_queue(), runBlock);
  }
}

void window_minimize(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    [delegate.window miniaturize:nil];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_async(dispatch_get_main_queue(), runBlock);
  }
}

void window_deminimize(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    [delegate.window deminiaturize:nil];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_async(dispatch_get_main_queue(), runBlock);
  }
}

void window_maximize(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    [delegate.window zoom:nil];
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_async(dispatch_get_main_queue(), runBlock);
  }
}

int window_is_minimized(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block int result = 0;
  void (^runBlock)(void) = ^{
    result = delegate.window.isMiniaturized ? 1 : 0;
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return result;
}

int window_is_maximized(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block int result = 0;
  void (^runBlock)(void) = ^{
    result = delegate.window.isZoomed ? 1 : 0;
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return result;
}

int window_is_fullscreen(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block int result = 0;
  void (^runBlock)(void) = ^{
    result = (delegate.window.styleMask & NSWindowStyleMaskFullScreen) ? 1 : 0;
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return result;
}

int window_is_active(main__WindowInfo *info) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  __block int result = 0;
  void (^runBlock)(void) = ^{
    result = delegate.window.isKeyWindow ? 1 : 0;
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_sync(dispatch_get_main_queue(), runBlock);
  }
  return result;
}

void window_set_titlebar_visible(main__WindowInfo *info, int visible) {
  AppDelegate *delegate = (AppDelegate *)info->app_delegate;
  void (^runBlock)(void) = ^{
    if (visible) {
      [delegate.window setTitlebarAppearsTransparent:NO];
      [delegate.window setTitleVisibility:NSWindowTitleVisible];
    } else {
      [delegate.window setTitlebarAppearsTransparent:YES];
      [delegate.window setTitleVisibility:NSWindowTitleHidden];
    }
  };
  if ([NSThread isMainThread]) {
    runBlock();
  } else {
    dispatch_async(dispatch_get_main_queue(), runBlock);
  }
}

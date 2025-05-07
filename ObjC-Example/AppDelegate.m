#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    self.window = [[NSWindow alloc]
        initWithContentRect:NSMakeRect(100, 100, 400, 300)
        styleMask:(NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable)
        backing:NSBackingStoreBuffered
        defer:NO];

    [self.window setTitle:@"Hello, World!"];

    // Add text inside the window
    NSTextField *label = [[NSTextField alloc] initWithFrame:NSMakeRect(100, 130, 200, 40)];
    [label setStringValue:@"Hello, World!"];
    [label setBezeled:NO];
    [label setDrawsBackground:NO];
    [label setEditable:NO];
    [label setSelectable:NO];
    [label setAlignment:NSTextAlignmentCenter];
    [[self.window contentView] addSubview:label];

    [self.window makeKeyAndOrderFront:nil];
}

@end

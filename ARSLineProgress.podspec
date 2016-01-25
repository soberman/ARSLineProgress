Pod::Spec.new do |s|

  s.name         = "ARSPopover"
  s.version      = "2.2.1"
  s.summary      = "Universal popover for iPhone and iPad."

  s.description  = <<-DESC
  # ARSPopover
  Universal popover for iPhone and iPad that you can use in your projects. No custom drawing, no custom elements - everything is purely native.

  |           iPhone             |           iPad           |
  | ---------------------------- | ------------------------ |
  | ![ARSPopover-iPhone][iPhone] | ![ARSPopover-iPad][iPad] |

  [iPhone]: http://git.arsenkin.com/ARSPopover-iPhone.gif
  [iPad]: http://git.arsenkin.com/ARSPopover-iPad.gif

  ## Installation

  ### CocoaPods
  To install with [CocoaPods](http://cocoapods.org/), copy and paste this in your *.pod* file:

      platform :ios, '8.3'
      pod 'ARSPopover', '~> 2.0'

  ### Non-CocoaPods way
  You can always to do the old way - just drag the source files into your projects and you are good to go.

      ## Usage
      Sample usage of the ARSPopover might look like this:

      ``` objective-c
      - (IBAction)showPopoverWithWebView:(id)sender {
          ARSPopover *popoverController = [ARSPopover new];
          popoverController.sourceView = self.buttonWithWebView;
          popoverController.sourceRect = CGRectMake(CGRectGetMidX(self.buttonWithWebView.bounds), CGRectGetMaxY(self.buttonWithWebView.bounds), 0, 0);
          popoverController.contentSize = CGSizeMake(400, 600);
          popoverController.arrowDirection = UIPopoverArrowDirectionUp;

          [self presentViewController:popoverController animated:YES completion:^{
              [popoverController insertContentIntoPopover:^(ARSPopover *popover, CGSize popoverPresentedSize, CGFloat popoverArrowHeight) {
                  CGFloat originX = 0;
                  CGFloat originY = 0;
                  CGFloat width = popoverPresentedSize.width;
                  CGFloat height = popoverPresentedSize.height - popoverArrowHeight;

                  CGRect frame = CGRectMake(originX, originY, width, height);
                  UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
                  webView.scalesPageToFit = YES;
                  [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]]];
                  [popover.view addSubview:webView];
              }];
          }];
      }
      ```
      ### Required properties' configurations

      In order to get a working popover, you need to specify next properties:

      * `popoverController.sourceView` - The view containing the anchor rectangle for the popover.

      ``` objective-c
      popoverController.sourceView = self.buttonWithWebView;
      ```

      * `popoverController.sourceRect` - The rectangle in the specified view in which to anchor the popover.

      ``` objective-c
      popoverController.sourceRect = CGRectMake(CGRectGetMidX(self.buttonWithWebView.bounds), CGRectGetMaxY(self.buttonWithWebView.bounds), 0, 0);
      ```

      * `popoverController.contentSize` - The preferred size for the popover’s view.

      ``` objective-c
      popoverController.contentSize = CGSizeMake(400, 600);
      ```

      * And the last, most important thing - you have to call method `insertContentIntoPopover` and pass a block of code, which should add subviews to popover's view you wish to see.

      _Be sure to call this method only after you have presented popup. Otherwise you might get wrong size in popoverPresentedSize._

      ``` objective-c
      [popoverController insertContentIntoPopover:^(ARSPopover *popover, CGSize popoverPresentedSize, CGFloat popoverArrowHeight) {
          CGFloat originX = 0;
          CGFloat originY = 0;
          CGFloat width = popoverPresentedSize.width;
          CGFloat height = popoverPresentedSize.height - popoverArrowHeight;

          CGRect frame = CGRectMake(originX, originY, width, height);
          UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
          webView.scalesPageToFit = YES;
          [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]]];
          [popover.view addSubview:webView];
      }];
      ```

  ## License
  ARSPopover is released under the [MIT license](http://opensource.org/licenses/MIT). See LICENSE for details.

                   DESC

  s.homepage     = "https://github.com/soberman/ARSPopover"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Yarik Arsenkin" => "info@arsenkin.com" }
  s.social_media_url   = "http://twitter.com/Soberman777"
  s.platform     = :ios, "8.3"
  s.source       = { :git => "https://github.com/soberman/ARSPopover.git", :tag => "2.2.1" }
  s.source_files  = "Source/ARSPopover.{h,m}"
  s.exclude_files = "Demo/*"
  s.public_header_files = "Source/ARSPopover.h"
  s.requires_arc = true

end

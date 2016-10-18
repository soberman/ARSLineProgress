Pod::Spec.new do |s|

  s.name         = "ARSLineProgress"
  s.version      = "2.0.2.1"
  s.summary      = "iOS progress bar, replacement for the default activity indicator."

  s.description  = <<-DESC
  ![ARSLineProgress](http://git.arsenkin.com/ARSLineProgress/ARSLineProgress.png)

  # ARSLineProgress
  iOS progress bar as a replacement for iOS activity indicator. This progress HUD will add some nice style touch to your application. Moreover, you can customize this progress loader through customization structure.

  |                Infinite               |               Success               |              Fail             |          No State Animation      |
  | ------------------------------------- | ----------------------------------- | ----------------------------- | -------------------------------- |
  | ![ARSLineProgress Infinite][Infinite] | ![ARSLineProgress Success][Success] | ![ARSLineProgress Fail][Fail] | ![ARSLineProgress NoState][NoState] |

  [Infinite]: http://git.arsenkin.com/ARSLineProgress/ARSLineProgress_infinite.gif
  [Success]: http://git.arsenkin.com/ARSLineProgress/ARSLineProgress_progress_with_success.gif
  [Fail]: http://git.arsenkin.com/ARSLineProgress/ARSLineProgress_progress_with_fail.gif
  [NoState]: http://git.arsenkin.com/ARSLineProgress/ARSLineProgress_without_final_animation.gif

  ## Installation

  ### Carthage
  To install with [Carthage](https://github.com/Carthage/Carthage), simply specify this on your `Cartfile`:

      github "soberman/ARSLineProgress" >= 1.0

  In case you don't Carthage installed yet, you could do this with [Homebrew](http://brew.sh/):

  ``` Bash
  $ brew update
  $ brew install carthage
  ```

  I would also advise to refer to this section of the Carthage description, for when [you're building for iOS, tvOS or WatchOS](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos)

  ### CocoaPods
  To install with [CocoaPods](http://cocoapods.org/), copy and paste this in your *Podfile* file:

      use_frameworks!
      platform :ios, '8.0'
      pod 'ARSLineProgress', '~> 1.0'

  ### Rookie way
  You can always to do the old way - just drag the source file into your projects and you are good to go.

  ## Usage
  ARSLineProgress makes it easy to use it - you have `ARSLineProgress` class, that offer you a wide range of class methods to show progress loader.

  ###### Showing
  You can show progress indicator in two modes: infinite and progress.
  Infinite progress will be shown until you hide it.
  ``` Swift
  class func show()
  class func showWithPresentCompetionBlock(block: () -> Void)
  class func showOnView(view: UIView)
  class func showOnView(view: UIView, completionBlock: () -> Void)

  class func hide()
  class func hideWithCompletionBlock(block: () -> Void)
  ```

  Progress indicator will be shown until the `NSProgress` object has the `fractionCompleted` value `1.0` or in case you have passed raw value - `100.0`.

  ``` Swift
  class func showWithProgressObject(progress: NSProgress)
  class func showWithProgressObject(progress: NSProgress, completionBlock: (() -> Void)?)
  class func showWithProgressObject(progress: NSProgress, onView: UIView)
  class func showWithProgressObject(progress: NSProgress, onView: UIView, completionBlock: (() -> Void)?)

  // Updating progress in case you are using on of the methods above:
  class func updateWithProgress(value: CGFloat)

  // initialValue should be from 0 to 100 in these methods
  class func showWithProgress(initialValue value: CGFloat)
  class func showWithProgress(initialValue value: CGFloat, completionBlock: (() -> Void)?)
  class func showWithProgress(initialValue value: CGFloat, onView: UIView)
  class func showWithProgress(initialValue value: CGFloat, onView: UIView, completionBlock: (() -> Void)?)
  ```

  You are able to show just the 'success' checkmark or fail with these methods:
  ``` Swift
  static func showSuccess()
  static func showFail()
  ```

  ###### Hiding
  Hiding progressHUD is can be similar to what you have done so far with the infinite loader, or you could use these dedicated methods:

  ``` Swift
  class func cancelPorgressWithFailAnimation(showFail: Bool)
  class func cancelPorgressWithFailAnimation(showFail: Bool, completionBlock: (() -> Void)?)
  ```

  ## Customization
  You can customize progressHUD through the `ARSLineProgressConfiguration` structure, that offers you a wide range of customization. Any changes are going to be visible only if you have set them before showing preloader, otherwise they are going to be visible during your next show of preloader.

  Once you changed your mind and you want to restore ARSLineProgressConfiguration to its default parameters - use `static func restoreDefaults()` method.

  ## Other
  ARSLineProgress automatically responds to orientation changes, so it always going to be centered on the screen.

  ## License
  ARSLineProgress is released under the [MIT license](http://opensource.org/licenses/MIT). See LICENSE for details.

                   DESC

  s.homepage     = "https://github.com/soberman/ARSLineProgress"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Yarik Arsenkin" => "info@arsenkin.com" }
  s.social_media_url   = "http://twitter.com/Soberman777"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/soberman/ARSLineProgress.git", :tag => "2.0.2.1" }
  s.source_files  = "Source/*"
  s.exclude_files = "Demo/*", "Carthage/*"
  # s.public_header_files = "Source/ARSLineProgress.swift"
  s.requires_arc = true
  s.xcconfig = { 'SWIFT_VERSION' => '3.0' }
end

# UBProgress

## Usage

Here are some examples to show you how the `UBProgress` can be configured:

**IN PROGRESS...**

## Installation

The recommended approach to use the UBProgress in your project is using the [CocoaPods](http://cocoapods.org/) package manager, as it provides flexible dependency management and dead simple installation.

#### CocoaPods

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```
Go to the directory of your Xcode project, and Create and Edit your Podfile and add UBProgress:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile

target 'MyProject' do
pod 'UBProgress', :git => 'https://github.com/Prouj/UBProgress.git'
end
```

Install into your project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file)

``` bash
$ open MyProject.xcworkspace
```

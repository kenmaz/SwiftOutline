# SwiftOutline

SwiftOutline is a tool to generate relationship graph of iOS ViewControllers.

## Install
```
$ brew install kenmaz/taps/swiftoutline
```

## Usage 
```
$ swiftoutline --dir <path/to/sources>
```

## Graph Examples
You can get a relationship graph of iOS ViewControllers like these:

### kickstarter/ios-oss
![kickstarter/ios-oss](https://github.com/kenmaz/SwiftOutline/blob/master/doc/kickstarter_ios-oss.png?raw=true)
https://github.com/kickstarter/ios-oss
```
swiftoutline --dir Kickstarter-iOS/Views/Controllers/ --exclude Tests.swift
```

### AnimeMaker (My Side Project 😁)
https://apps.apple.com/jp/app/animemaker/id405622194
![Sample Graph](https://github.com/kenmaz/SwiftOutline/blob/master/doc/sample.png?raw=true)


### Options
```
$ swiftoutline --help
Usage:

    $ swiftoutline

Options:
    --dir [default: ["."]] - Target sources directory
    --exclude [default: ["Debug"]] - Keyword to exclude target source path
    --output [default: /tmp/graph.png] - Graph image file output path
    --dotfile [default: /tmp/graph.dot] - Intermediate .dot file output path
```

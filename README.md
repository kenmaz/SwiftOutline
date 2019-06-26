# SwiftOutline

SwiftOutline is a tool to generate relationship graph of iOS ViewControllers.

## Install
```
$ brew install kenmaz/taps/swiftoutline
```

## Usage 
```
$ swiftoutline --dir <path/to/sources> --output out.dot
$ dot -Tpng -o out.png out.dot
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

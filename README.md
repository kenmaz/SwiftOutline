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
You can get ViewController relationship graph
![Sample Graph](https://github.com/kenmaz/SwiftOutline/blob/master/doc/sample.png?raw=true)

<p align="center" >
	<img src="https://dl.dropboxusercontent.com/u/1337202/linked%20stuff/CDKitt/CDKitt-readme-banner.png" alt="CDKitt" title="CDKitt">
</p>

# CDKitt
CDKitt is [my](http://aron.cedercrantz.com/) kit of shared Objective-C macros, functions and classes. There’s extensions to _Foundation_, _Cocoa Touch_ and regular _Cocoa_.

## Usage
1. Add CDKitt as a git submodule and bootstrap it.
	1. `git submodule add https://github.com/rastersize/CDKitt.git External/CDKitt`
	2. `./External/CDKitt/Scripts/bootstrap`
2. Add the CDKitt Xcode project as a subproject to yours.
	1. Drag `CDKitt.xcodeproj` from _Finder_ into your project.
3. Configure your build target.
	1. Under _Build Phases_ make sure to link with;
		* `CDKitt.framework`, if for an **OS X** target.
		* `libCDKitt.dylib`, if for an **iOS** target.
	2. If for an **OS X** target copy the framework to your bundle.
		1. Under _Build Phases_ add a “Copy Files Build Phase” if you don’t already have one.
		2. Set its _Destination_ to “Frameworks”.
		3. Add the `CDKitt.framework` product to this group.
	3. If for an **OS X** target set the runpath search path.
		1. Under _Build Settings_ search for `rpath`.
		2. Set _Runpath Search Paths_ to `@loader_path/../Frameworks $(inherited)` (i.e. the `LD_RUNPATH_SEARCH_PATHS` setting).

## License
The code is licensed under the MIT license, unless otherwise stated. See the _[LICENSE](https://github.com/rastersize/CDKitt/blob/master/LICENSE)_ file in the repository root for the full license text.

## Support
If you find an issue please feel free to fix it and submit a pull request, it will be greatly appreciated! If you can’t fix it yourself just create an [issue on GitHub](https://github.com/rastersize/CDKitt/issues).

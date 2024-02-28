[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

# FlexScaffold

This is a new experimental and reworked version of the original Flexfold package, 
that was never released publicly.

This **Flutter** package is a **work in progress**, and is not ready for general 
consumption. The intent is to publish this package on
[pub.dev](https://pub.dev/publishers/rydmike.com/packages) when it is ready for general use.

**The API and features of this public release may still change at any time!**

> [!CAUTION]
> Use this library at your own risk. It is not ready for production consumption.

## TODOs

These TODOs list features I want to have for a 1.0.0 release. This list is not
exhaustive, and I will add more items as I think of them.

The package will probably be released as a 0.1.0 version, before all these
TODOs are done, but I want to have a clear goal for a 1.0.0 release.

### General
- [ ] Clean up code and remove unused code.
- [ ] Review API naming.
- [ ] Review all doc comments.
- [ ] Add tests.
- [ ] Publish and build GitHub actions.

### Features
- [x] FlexScaffold state and props as an inherited widget with aspects.
- [x] Improve scroll hidden bottom bar.
- [x] Add support for GoRouter's tap back to branch root.
- [ ] Review the theme.
- [ ] Add support for destinations in different modules.
- [ ] Improve Drawer handling and fix its edge case issue.
- [ ] Change the way the FlexScaffold is laid out now using a composed `Row`, 
      to use a `CustomMultiChildLayout` for a more efficient layout and more
      control over the layout.
- [ ] Add support for interactive resize of the pinned menu and sidebar.
- [ ] Add a built-in master-detail view, that can be used in the body if you
      do not want to make your own version.

### Documentation
- [ ] Make a documentation site.
- [ ] Make content for the docs site.

### Samples
- [ ] Default simple example
- [ ] Example with custom bottom navigation bars.
- [ ] Example with custom top app bars using Slivers.
- [ ] The fancy live and advanced WEB demo example.


# flutter_flame_architecture

## Goal of the package

To support in the development of games using flutter and flame

Flame gives you the platform to develop games with flutter, but it doesn't feel like flutter anymore. The issue lies in the lack of widgets and existing structure.

This package should provide a way to fix this.

Redeveloping default flutter widgets (with basic functionality) like:
- Row
- Column
- Text

Extend flame functionality with quality of life improvements
- Support translations
- Navigation
- Scrollable screen
- Dialogs
- SpriteManager (Tocheck if not already in flame?)

## Basics

Game development has some differences from normal flutter development. A big difference is the build method is executed multiple times a second (fps). If you need to do calculations etc you can do this in the update function, that way if it takes longer, the UI is not interupted.

Another difference is the drawing on a canvas. Everything is drawn using a canvas with coordinates. Using the FlameWidget from this package you can use some helper methods like bounds, etc.

## Contribution

Obviously contribution is encouraged, even if it's just by adding issues with ideas to further expand this package
# flutter_flame_architecture

## Goal of the package

To support in the development of games using Flutter and Flame

Flame gives you the platform to develop games with Flutter, but it doesn't feel like Flutter anymore. The issue lies in the lack of widgets and existing structure.

This package attempts to fix this.

Redeveloping default Flutter widgets (with basic functionality) like:
- [x] Center
- [x] Column
- [x] Container
- [x] Expanded
- [x] GestureDetector
- [x] Padding
- [x] Positioned
- [x] Row
- [x] SizedBox
- [x] Spacer
- [x] Stack
- [x] Text
- [x] Image (FlameSprite)
- [x] SingleChildScrollView (**note** Both horizontal and vertical are supported at the same time!)
- [x] Button (For now a simplistic implementation is added)

Extend Flame functionality with quality of life improvements
- [x] Canvas widget (draw on the canvas)
- [x] Automate SpriteManager (Use the FlameSprite Widget with fileName)
- [x] Navigation
- [ ] Dialogs
- [ ] Sound

Documentation
- [ ] Center
- [ ] Column
- [ ] Container
- [ ] Expanded
- [ ] GestureDetector
- [ ] Padding
- [ ] Positioned
- [ ] Row
- [ ] SizedBox
- [ ] Spacer
- [ ] Stack
- [ ] Text
- [ ] Image (FlameSprite)
- [ ] Button
- [ ] Canvas widget (draw on the canvas)
- [ ] Automate SpriteManager (Use the FlameSprite Widget with fileName)
- [ ] Navigation
- [ ] SingleChildScrollView
- [ ] Dialogs
- [ ] Sound

Examples
- [ ] Build and put on GitHub pages?
- [x] Basic example (pong)
- [ ] Canvas widget (draw on the canvas)
- [ ] Automate SpriteManager (Use the FlameSprite Widget with fileName)
- [x] Navigation
- [x] SingleChildScrollView
- [ ] Dialogs
- [ ] Sound

## Basics

Game development has some differences from normal Flutter development. A big difference is the build method is executed multiple times a second (fps). If you need to do calculations etc you can do this in the update function, that way if it takes longer, the UI is not interupted.

Another difference is the drawing on a canvas. Everything is drawn using a canvas with coordinates. Using the FlameWidget from this package you can use some helper methods like bounds, etc.

## Contribution

Obviously contribution is encouraged, even if it's just by adding issues with ideas to further expand this package

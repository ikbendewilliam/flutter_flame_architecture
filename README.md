# flutter_flame_architecture

## Goal of the package

To support in the development of games using flutter and flame

Flame gives you the platform to develop games with flutter, but it doesn't feel like flutter anymore. The issue lies in the lack of widgets and existing structure.

This package should provide a way to fix this.

Redeveloping default flutter widgets (with basic functionality) like:
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
- [ ] Button

Extend flame functionality with quality of life improvements
- [x] Canvas widget (draw on the canvas)
- [x] Automate SpriteManager (Use the FlameSprite Widget with fileName)
- [x] Navigation
- [ ] Scrollable screen
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
- [ ] Scrollable screen
- [ ] Dialogs
- [ ] Sound

Example
- [x] Basic example (pong)
- [ ] Canvas widget (draw on the canvas)
- [ ] Automate SpriteManager (Use the FlameSprite Widget with fileName)
- [ ] Navigation
- [ ] Scrollable screen
- [ ] Dialogs
- [ ] Sound

## Basics

Game development has some differences from normal flutter development. A big difference is the build method is executed multiple times a second (fps). If you need to do calculations etc you can do this in the update function, that way if it takes longer, the UI is not interupted.

Another difference is the drawing on a canvas. Everything is drawn using a canvas with coordinates. Using the FlameWidget from this package you can use some helper methods like bounds, etc.

## Contribution

Obviously contribution is encouraged, even if it's just by adding issues with ideas to further expand this package
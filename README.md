# flutter_flame_architecture

Use flutter(like) widgets inside Flame

[Examples](https://ikbendewilliam.github.io/flutter_flame_architecture/example/build/web/#/)

## Basics

Game development has some differences from normal Flutter development. A big difference is the build method is executed multiple times a second (fps). If you need to do calculations etc you can do this in the update function, that way if it takes longer, the UI is not interupted.

Another difference is the drawing on a canvas. Everything is drawn using a canvas with coordinates. Using the FlameWidget from this package you can use some helper methods like bounds, etc.

## Contribution

Obviously contribution is encouraged, even if it's just by adding issues with ideas to further expand this package

## Goal of the package

To support in the development of games using Flutter and Flame

Flame gives you the platform to develop games with Flutter, but it doesn't feel like Flutter anymore. The issue lies in the lack of widgets and existing structure.

This package attempts to fix this.

## Next steps

To improve the game dev experience in Flutter/Flame, I'm planning on creating a template project. This would include admob, firebase, basic screens (main menu, etc), a clear folder structure, etc. The idea is to first develop a game with this package and then to strip the game to its essentials.

## Progress

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
- [x] GridView
- [x] IsometricGridView
- [x] SafeArea
- [x] Builder
- [x] ValueListenableBuilder
- [x] Wrap

Extend Flame functionality with quality of life improvements
- [x] Canvas widget (draw on the canvas)
- [x] Zoom widget (child is zoomable using gestures or programmatically)
- [x] Automate SpriteManager (Use the FlameSprite Widget with fileName)
- [x] Navigation
- [x] Dialogs

BackPress for navigator:
```
MaterialApp(
  home: WillPopScope(
    onWillPop: () async {
      FlameNavigator.pop();
      return false;
    },
    child: GameWidget(
      game: gameManager,
    ),
  ),
),
```

Examples
- [x] Build and put on GitHub pages
- [x] Basic example (pong)
- [x] Navigation
- [x] SingleChildScrollView
- [x] GridView
- [x] IsometricGridView
- [x] Button
- [x] Dialogs
- [x] Zoom
- [x] Wrap
- [x] FlameValueListenableBuilder
- [ ] FlameCanvas(that updates)

Code documentation
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
- [ ] ValueListenableBuilder
- [ ] Wrap

WikiDocs
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
- [ ] FlameValueListenableBuilder
- [ ] Wrap

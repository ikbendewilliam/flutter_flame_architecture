import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

class GameManager extends Game with MultiTouchDragDetector, MultiTouchTapDetector {
  FlameWidget home;
  FlameWidget currentScreen;

  GameManager({
    required this.home,
  }) : currentScreen = home;

  @override
  void onAttach() {
    super.onAttach();
    build();
  }

  void build({BuildContext? testContext}) {
    final context = testContext ?? buildContext;
    if (context == null) return;
    currentScreen.updateBounds(size);
    currentScreen.reBuildChild(context);
  }

  @override
  void render(Canvas canvas) {
    if (buildContext != null) {
      currentScreen.render(canvas, buildContext!);
    }
  }

  @override
  void update(double deltaTime) {
    currentScreen.update(deltaTime);
  }

  @override
  void onResize(Vector2 size) {
    super.onResize(size);
    build();
    currentScreen.updateBounds(size);
  }
}

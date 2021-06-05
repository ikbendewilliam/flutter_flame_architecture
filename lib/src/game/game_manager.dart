import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

class GameManager extends Game with MultiTouchDragDetector, MultiTouchTapDetector {
  FlameWidget home;
  FlameWidget currentScreen;
  var lastDragPosition = Vector2.all(0);

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
    currentScreen.reBuildChild(context, size);
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
  }

  @override
  void onTapDown(int pointerId, TapDownInfo event) {
    currentScreen.onTapDown(event.eventPosition.widget);
  }

  @override
  void onTapUp(int pointerId, TapUpInfo event) {
    currentScreen.onTapUp(event.eventPosition.widget);
  }

  @override
  void onDragStart(int pointerId, DragStartInfo event) {
    currentScreen.onDragStart(pointerId, event.eventPosition.widget);
  }

  @override
  void onDragUpdate(int pointerId, DragUpdateInfo event) {
    lastDragPosition = event.eventPosition.widget;
    currentScreen.onDragUpdate(pointerId, event.eventPosition.widget);
  }

  @override
  void onDragEnd(int pointerId, DragEndInfo event) {
    currentScreen.onDragEnd(pointerId, lastDragPosition);
  }
}

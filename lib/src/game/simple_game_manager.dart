import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/game/game_manager.dart';

class SimpleGameManager extends GameManager {
  var lastDragPosition = Vector2.all(0);
  final FlameWidget? Function(RouteSettings settings)? _onGenerateRoute;

  /// Creates a basic game manager, should be enough for most use cases
  /// Home or initialroute must be set
  /// if routing is used, you must set onGenerateRoute
  SimpleGameManager({
    FlameWidget? Function(RouteSettings settings)? onGenerateRoute,
    FlameWidget? home,
    String? initialRoute,
  })  : _onGenerateRoute = onGenerateRoute,
        super(
          home: home,
          initialRoute: initialRoute,
        );

  @override
  FlameWidget? onGenerateRoute(RouteSettings settings) => _onGenerateRoute?.call(settings);

  @override
  void build({BuildContext? testContext}) {
    final context = testContext ?? buildContext;
    if (context == null) return;
    currentScreen.reBuildChild(context, size);
  }

  @override
  Future<void> onLoad() async {
    FlameSpriteCollector.instance.setGameManager(this);
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
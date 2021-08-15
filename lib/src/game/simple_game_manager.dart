import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/game/game_manager.dart';

class SimpleGameManager extends GameManager with ScaleDetector, TapDetector {
  var lastDragPosition = Vector2.zero();
  var lastScalePosition = Vector2.zero();
  var lastScale = 0.0;
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
    if (currentDialog != null) {
      currentDialog!.reBuildChild(context, size);
      return;
    }
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
      currentDialog?.render(canvas, buildContext!);
    }
  }

  @override
  // ignore: avoid_renaming_method_parameters
  void update(double deltaTime) {
    if (deltaTime > 0.1) deltaTime = 0.1;
    if (currentDialog != null) {
      currentDialog!.update(deltaTime);
    } else {
      currentScreen.update(deltaTime);
    }
  }

  @override
  void onResize(Vector2 size) {
    super.onResize(size);
    build();
  }

  @override
  // ignore: avoid_renaming_method_parameters
  void onTapDown(TapDownInfo event) {
    if (currentDialog != null) {
      currentDialog!.onTapDown(event.eventPosition.widget);
    } else {
      currentScreen.onTapDown(event.eventPosition.widget);
    }
  }

  @override
  // ignore: avoid_renaming_method_parameters
  void onTapUp(TapUpInfo event) {
    if (currentDialog != null) {
      currentDialog!.onTapUp(event.eventPosition.widget);
    } else {
      currentScreen.onTapUp(event.eventPosition.widget);
    }
  }

  @override
  // ignore: avoid_renaming_method_parameters
  void onScaleStart(ScaleStartInfo event) {
    if (currentDialog != null) {
      currentDialog!.onDragStart(event.eventPosition.widget);
      currentDialog!.onScaleStart(event.eventPosition.widget);
    } else {
      currentScreen.onScaleStart(event.eventPosition.widget);
      currentScreen.onDragStart(event.eventPosition.widget);
    }
  }

  @override
  // ignore: avoid_renaming_method_parameters
  void onScaleUpdate(ScaleUpdateInfo event) {
    lastScalePosition = event.eventPosition.widget;
    lastScale = event.raw.scale;
    if (currentDialog != null) {
      currentDialog!.onDragUpdate(event.eventPosition.widget);
      currentDialog!.onScaleUpdate(event.eventPosition.widget, event.raw.scale);
    } else {
      currentScreen.onDragUpdate(event.eventPosition.widget);
      currentScreen.onScaleUpdate(event.eventPosition.widget, event.raw.scale);
    }
  }

  @override
  // ignore: avoid_renaming_method_parameters
  void onScaleEnd(ScaleEndInfo event) {
    if (currentDialog != null) {
      currentDialog!.onDragEnd(lastScalePosition);
      currentDialog!.onScaleEnd(lastScalePosition, lastScale);
    } else {
      currentScreen.onDragEnd(lastScalePosition);
      currentScreen.onScaleEnd(lastScalePosition, lastScale);
    }
  }
}

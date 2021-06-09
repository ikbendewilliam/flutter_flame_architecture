import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_navigator.dart';

import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

abstract class GameManager extends Game with MultiTouchDragDetector, MultiTouchTapDetector {
  late FlameWidget currentScreen;
  @protected
  List<FlameRoute> stack = [];

  /// Start the game manager, home or initialRoute is required
  GameManager({
    FlameWidget? home,
    String? initialRoute,
  }) : assert(home != null || initialRoute != null) {
    FlameNavigator.instance.setGameManager(this);
    final routeSettings = RouteSettings(name: initialRoute);
    final firstScreen = home ?? onGenerateRoute(routeSettings);
    if (firstScreen == null) throw Exception('Initial route doesn\'t generate a valid Widget, this is invalid!');
    currentScreen = firstScreen;
    stack.add(FlameRoute(routeSettings: routeSettings, widget: firstScreen));
  }

  @override
  void onAttach() {
    super.onAttach();
    build();
  }

  void build({BuildContext? testContext});

  /// Implement this function to use the navigator, ignore it to use a custom implementation inside the home widget
  FlameWidget? onGenerateRoute(RouteSettings settings) {}

  void push(FlameWidget screen) {
    currentScreen = screen;
    stack.add(FlameRoute(routeSettings: RouteSettings(name: 'dialog'), widget: currentScreen));
    build();
  }

  void pushNamed(String route, {dynamic arguments}) {
    final routeSettings = RouteSettings(name: route, arguments: arguments);
    final screen = onGenerateRoute(routeSettings);
    if (screen == null) {
      print('WARNING: Cannot navigate to null widget');
      return;
    }
    currentScreen = screen;
    stack.add(FlameRoute(routeSettings: routeSettings, widget: currentScreen));
    build();
  }

  void popAndPushNamed(String route, {dynamic arguments}) {
    final routeSettings = RouteSettings(name: route, arguments: arguments);
    final screen = onGenerateRoute(routeSettings);
    if (screen == null) {
      print('WARNING: Cannot navigate to null widget');
      return;
    }
    currentScreen = screen;
    stack.last = FlameRoute(routeSettings: routeSettings, widget: currentScreen);
    build();
  }

  void pop() {
    stack.removeLast();
    if (stack.isEmpty) return;
    currentScreen = stack.last.widget;
  }

  FlameRoute getCurrentRoute() => stack.last;
}

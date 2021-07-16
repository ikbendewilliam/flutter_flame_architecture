import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_navigator.dart';

import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

abstract class GameManager extends Game {
  late FlameWidget currentScreen;
  FlameWidget? currentDialog;
  Completer? currentDialogCompleter;
  FlameRoute? dialogRoute;
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

  Future<void> showDialog(FlameWidget dialog) {
    currentDialog = dialog;
    currentDialogCompleter = Completer();
    dialogRoute = FlameRoute(routeSettings: RouteSettings(), widget: dialog);
    build();
    return currentDialogCompleter!.future;
  }

  void push(FlameWidget screen, {RouteSettings? routeSettings}) {
    currentScreen = screen;
    if (currentDialog != null) {
      currentDialog = null;
      currentDialogCompleter?.complete();
      dialogRoute = null;
    }
    stack.add(FlameRoute(routeSettings: routeSettings ?? RouteSettings(), widget: currentScreen));
    build();
  }

  void pushNamed(String route, {dynamic arguments}) {
    final routeSettings = RouteSettings(name: route, arguments: arguments);
    final screen = onGenerateRoute(routeSettings);
    if (screen == null) {
      print('WARNING: Cannot navigate to null widget');
      return;
    }
    push(screen, routeSettings: routeSettings);
  }

  void popAndPushNamed(String route, {dynamic arguments}) {
    pop();
    pushNamed(route);
  }

  void popUntil(bool Function(FlameRoute route) check) {
    while (stack.length > 1 && !check(dialogRoute ?? stack.last)) pop();
  }

  void pop() {
    if (currentDialog != null) {
      currentDialog = null;
      dialogRoute = null;
      currentDialogCompleter?.complete();
      currentDialogCompleter = null;
      return;
    }
    stack.removeLast();
    if (stack.isEmpty) return;
    currentScreen = stack.last.widget;
  }

  FlameRoute getCurrentRoute() => stack.last;
}

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
    if (firstScreen == null)
      throw Exception(
          "Initial route doesn't generate a valid Widget, this is invalid!");
    currentScreen = firstScreen;
    stack.add(FlameRoute(
      routeSettings: routeSettings,
      widget: firstScreen,
    ));
  }

  @override
  void onAttach() {
    super.onAttach();
    build();
  }

  void build({BuildContext? testContext});

  /// Implement this function to use the navigator, ignore it to use a custom implementation inside the home widget
  FlameWidget? onGenerateRoute(RouteSettings settings) {
    return null;
  }

  Future<dynamic> showDialog(FlameWidget dialog) {
    currentDialog = dialog;
    currentDialogCompleter = Completer<dynamic>();
    dialogRoute =
        FlameRoute(routeSettings: const RouteSettings(), widget: dialog);
    build();
    return currentDialogCompleter!.future;
  }

  Future<dynamic> push(FlameWidget screen, {RouteSettings? routeSettings}) {
    currentScreen = screen;
    if (currentDialog != null) {
      currentDialog = null;
      currentDialogCompleter?.complete();
      dialogRoute = null;
    }
    stack.add(FlameRoute(
      routeSettings: routeSettings ?? const RouteSettings(),
      widget: currentScreen,
    ));
    build();
    return stack.last.currentDialogCompleter.future;
  }

  Future<dynamic> pushNamed(String route, {dynamic arguments}) async {
    final routeSettings = RouteSettings(name: route, arguments: arguments);
    final screen = onGenerateRoute(routeSettings);
    if (screen == null) {
      print('WARNING: Cannot navigate to null widget');
      return;
    }
    return push(screen, routeSettings: routeSettings);
  }

  Future<dynamic> popAndPushNamed(String route, {dynamic arguments}) async {
    pop();
    return pushNamed(route);
  }

  void popUntil(bool Function(FlameRoute route) check, {dynamic result}) {
    while (stack.length > 1 && !check(dialogRoute ?? stack.last))
      pop(result: result);
  }

  void pop({dynamic result}) {
    if (currentDialog != null) {
      currentDialog = null;
      dialogRoute = null;
      currentDialogCompleter?.complete(result);
      currentDialogCompleter = null;
      return;
    }
    if (stack.length <= 1) return;
    stack.last.currentDialogCompleter.complete(result);
    stack.removeLast();
    currentScreen = stack.last.widget;
  }

  FlameRoute getCurrentRoute() => stack.last;
}

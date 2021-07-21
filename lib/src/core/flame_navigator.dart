import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture/src/game/game_manager.dart';

class FlameNavigator {
  GameManager? _gameManager;

  static final FlameNavigator _instance = FlameNavigator._();

  static FlameNavigator get instance => _instance;

  FlameNavigator._();

  void setGameManager(GameManager gameManager) {
    _gameManager = gameManager;
  }

  static bool get isReady => instance._gameManager != null;

  static Future<dynamic> push(FlameWidget screen) => instance._gameManager!.push(screen);

  static Future<dynamic> pushNamed(String route, {dynamic arguments}) => instance._gameManager!.pushNamed(route, arguments: arguments);

  static Future<dynamic> popAndPushNamed(String route, {dynamic arguments}) => instance._gameManager!.popAndPushNamed(route, arguments: arguments);

  static void pop() => instance._gameManager!.pop();

  static void popUntil(bool Function(FlameRoute route) check) => instance._gameManager!.popUntil(check);

  static FlameRoute get currentRoute => instance._gameManager!.getCurrentRoute();

  static Future<void> showDialog(FlameWidget dialog) => instance._gameManager!.showDialog(dialog);
}

class FlameRoute {
  final FlameWidget widget;
  final RouteSettings routeSettings;
  late final Completer currentDialogCompleter;

  FlameRoute({
    required this.widget,
    required this.routeSettings,
  }) {
    this.currentDialogCompleter = Completer();
  }
}

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

  static void pushNamed(String route, {dynamic arguments}) => instance._gameManager!.pushNamed(route, arguments: arguments);

  static void popAndPushNamed(String route, {dynamic arguments}) => instance._gameManager!.popAndPushNamed(route, arguments: arguments);

  static void pop() => instance._gameManager!.pop();

  static FlameRoute get currentRoute => instance._gameManager!.getCurrentRoute();
}

class FlameRoute {
  final FlameWidget widget;
  final RouteSettings routeSettings;

  FlameRoute({
    required this.widget,
    required this.routeSettings,
  });
}

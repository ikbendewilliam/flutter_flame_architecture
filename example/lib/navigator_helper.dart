import 'package:example/example_widgets/grid_view_example.dart';
import 'package:example/example_widgets/single_child_scroll_view_example.dart';
import 'package:example/main.dart';
import 'package:example/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class NavigatorHelper {
  static FlameWidget? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Menu.routeName:
        return Menu();
      case GridViewExample.routeName:
        return GridViewExample();
      case Pong.routeName:
        return Pong();
      case SingleChildScrollViewExample.routeName:
        return SingleChildScrollViewExample();
    }
  }
}

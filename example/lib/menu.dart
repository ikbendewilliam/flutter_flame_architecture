import 'package:example/example_widgets/grid_view_example.dart';
import 'package:example/example_widgets/isometric_grid_view_example.dart';
import 'package:example/example_widgets/single_child_scroll_view_example.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class Menu extends FlameWidget {
  static const routeName = 'Menu';

  static FlameWidget? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Menu.routeName:
        return Menu();
      case GridViewExample.routeName:
        return GridViewExample();
      case IsometricGridViewExample.routeName:
        return IsometricGridViewExample();
      case Pong.routeName:
        return Pong();
      case SingleChildScrollViewExample.routeName:
        return SingleChildScrollViewExample();
    }
  }

  @override
  FlameWidget build(BuildContext context) {
    return FlameColumn(
      children: [
        FlameButton(
          text: 'SingleChildScrollView',
          onTap: () => FlameNavigator.pushNamed(SingleChildScrollViewExample.routeName),
        ),
        FlameButton(
          text: 'GridView',
          onTap: () => FlameNavigator.pushNamed(GridViewExample.routeName),
        ),
        FlameButton(
          text: 'IsometricGridView',
          onTap: () => FlameNavigator.pushNamed(IsometricGridViewExample.routeName),
        ),
        FlameButton(
          text: 'pong',
          onTap: () => FlameNavigator.pushNamed(Pong.routeName),
        ),
        FlameButton(
          text: 'Dialog',
          onTap: () => FlameNavigator.showDialog(
            FlameColumn(
              children: [
                FlameText(
                  'This is a dialog',
                  color: Colors.black,
                ),
                FlameSpacer(),
                FlameButton(
                  text: 'close',
                  onTap: () => FlameNavigator.pop(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:example/example_widgets/grid_view_example.dart';
import 'package:example/example_widgets/isometric_grid_view_example.dart';
import 'package:example/example_widgets/single_child_scroll_view_example.dart';
import 'package:example/example_widgets/wrap_example.dart';
import 'package:example/example_widgets/zoom_example.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class Menu extends FlameWidget {
  static const routeName = 'Menu';

  static FlameWidget? onGenerateRoute(RouteSettings settings) {
    final child = _onGenerateRouteChild(settings);
    if (child == null) return null;
    return FlameSafeArea(
      child: child,
    );
  }

  static FlameWidget? _onGenerateRouteChild(RouteSettings settings) {
    switch (settings.name) {
      case Menu.routeName:
        return Menu();
      case GridViewExample.routeName:
        return GridViewExample();
      case WrapExample.routeName:
        return WrapExample();
      case IsometricGridViewExample.routeName:
        return IsometricGridViewExample();
      case Pong.routeName:
        return Pong();
      case SingleChildScrollViewExample.routeName:
        return SingleChildScrollViewExample();
      case ZoomExample.routeName:
        return ZoomExample();
    }
    return null;
  }

  @override
  FlameWidget build(BuildContext context) {
    return FlameCenter(
      child: FlameColumn(
        children: [
          FlameButton(
            text: 'Zoom',
            onTap: () => FlameNavigator.pushNamed(ZoomExample.routeName),
          ),
          FlameButton(
            text: 'SingleChildScrollView',
            onTap: () => FlameNavigator.pushNamed(
                SingleChildScrollViewExample.routeName),
          ),
          FlameButton(
            text: 'GridView',
            onTap: () => FlameNavigator.pushNamed(GridViewExample.routeName),
          ),
          FlameButton(
            text: 'Wrap + FlameValueListenableBuilder',
            onTap: () => FlameNavigator.pushNamed(WrapExample.routeName),
          ),
          FlameButton(
            text: 'IsometricGridView',
            onTap: () =>
                FlameNavigator.pushNamed(IsometricGridViewExample.routeName),
          ),
          FlameButton(
            text: 'pong',
            onTap: () => FlameNavigator.pushNamed(Pong.routeName),
          ),
          FlameButton(
            text: 'Dialog',
            onTap: () => FlameNavigator.showDialog(
              FlameDialog(
                child: FlameColumn(
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
          ),
        ],
      ),
    );
  }
}

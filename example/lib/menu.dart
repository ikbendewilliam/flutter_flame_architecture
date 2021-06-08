import 'package:example/example_widgets/single_child_scroll_view_example.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class Menu extends FlameWidget {
  static const routeName = 'Menu';

  @override
  FlameWidget build(BuildContext context) {
    return FlameColumn(
      children: [
        FlameButton(
          text: 'singleChildScrollView',
          onTap: () => FlameNavigator.pushNamed(SingleChildScrollViewExample.routeName),
        ),
        FlameButton(
          text: 'pong',
          onTap: () => FlameNavigator.pushNamed(Pong.routeName),
        ),
      ],
    );
  }
}

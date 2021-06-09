import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class GridViewExample extends FlameWidget {
  static const routeName = 'GridViewExample';

  List<List<FlameWidget>> _buildMap() {
    return [
      [0, 0, 0, 0, 1, 1, 1, 1, 2, 2],
      [0, 0, 0, 1, 1, 1, 1, 1, 2, 2],
      [0, 0, 0, 1, 1, 1, 1, 1, 2, 2],
      [0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
      [1, 1, 1, 1, 0, 0, 0, 0, 0, 0],
      [1, 1, 1, 0, 0, 1, 1, 1, 2, 2],
      [0, 0, 0, 0, 1, 1, 2, 2, 2, 2],
      [0, 0, 0, 1, 1, 2, 2, 2, 2, 2],
    ]
        .map((row) => row
            .map((i) => FlameContainer(
                  color: i == 0 ? Colors.blue : (i == 1 ? Colors.green : Colors.grey),
                ))
            .toList())
        .toList();
  }

  @override
  FlameWidget build(BuildContext context) {
    return FlameColumn(
      children: [
        FlameButton(
          text: 'back',
          onTap: FlameNavigator.pop,
        ),
        FlameExpanded(
          child: FlameGridView(children: _buildMap(), childSize: Vector2(100, 100)),
        ),
      ],
    );
  }
}

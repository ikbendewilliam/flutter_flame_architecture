import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class ZoomExample extends FlameWidget {
  static const routeName = 'ZoomExample';

  List<List<FlameWidget>> _buildMap() {
    final random = Random();
    return List.filled(
      100,
      List.filled(
        100,
        () => random.nextInt(3),
      ),
    )
        .map((row) => row
            .map((i) => FlameContainer(
                  color: i() == 0 ? Colors.blue : (i() == 1 ? Colors.grey : Colors.green),
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
          child: FlameZoom(
            child: FlameSingleChildScrollView(
              child: FlameGridView(children: _buildMap(), childSize: Vector2(50, 50)),
            ),
          ),
        ),
      ],
    );
  }
}

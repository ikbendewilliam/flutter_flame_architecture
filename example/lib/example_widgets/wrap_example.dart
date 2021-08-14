import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class WrapExample extends FlameWidget {
  static const routeName = 'WrapExample';
  final isHorizontal = ValueNotifier(true);

  @override
  FlameWidget build(BuildContext context) {
    return FlameColumn(
      children: [
        FlameButton(
          text: 'back',
          onTap: FlameNavigator.pop,
        ),
        FlameButton(
          text: 'Switch direction',
          onTap: () => isHorizontal.value = !isHorizontal.value,
        ),
        FlameExpanded(
          child: FlameValueListenableBuilder<bool>(
            valueListenable: isHorizontal,
            builder: (context, value, child) => FlameSingleChildScrollView(
              child: FlameWrap(
                direction: value ? Axis.horizontal : Axis.vertical,
                children: _buildMap(),
                childSize: Vector2(100, 100),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<FlameWidget> _buildMap() {
    final random = Random();
    return List.generate(
      100,
      (i) => FlameContainer(
        color: Colors.primaries[random.nextInt(Colors.primaries.length)],
        child: FlameCenter(
          child: FlameText(
            i.toString(),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

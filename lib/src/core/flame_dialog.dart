import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlameDialog extends FlameWidget {
  final FlameWidget child;
  final Color background;
  final bool closeOnPressOutside;

  FlameDialog({
    required this.child,
    this.background = Colors.black54,
    this.closeOnPressOutside = true,
  });

  @override
  FlameWidget build(BuildContext context) {
    var hasPressedInside = false;
    if (closeOnPressOutside) {
      return FlameStack(
        children: [
          FlameGestureDetector(
            child: FlameContainer(color: background),
            onTapUp: (tapPosition) {
              if (!hasPressedInside) FlameNavigator.pop();
              hasPressedInside = false;
            },
          ),
          FlameCenter(
            child: FlameExpanded(
              child: FlameGestureDetector(
                child: child,
                onTapDown: (tapPosition) => hasPressedInside = true,
                passThrough: true,
              ),
            ),
          ),
        ],
      );
    }
    return FlameStack(
      children: [
        FlameContainer(color: background),
        FlameCenter(
          child: child,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlameDialog extends FlameWidget {
  FlameWidget? child;
  final Color background;
  final Color dialogBackground;
  final bool closeOnPressOutside;
  final EdgeInsets padding;
  final double width;
  final double height;

  FlameDialog({
    required this.child,
    this.background = Colors.black54,
    this.dialogBackground = Colors.white,
    this.closeOnPressOutside = true,
    this.padding = const EdgeInsets.all(8),
    this.width = 256,
    this.height = 160,
  });

  @override
  void dispose() {
    child = null;
    super.dispose();
  }

  @override
  FlameWidget build(BuildContext context) {
    var hasPressedInside = false;
    return FlameStack(
      children: [
        if (closeOnPressOutside) ...[
          FlameGestureDetector(
            child: FlameContainer(color: background),
            onTapUp: (tapPosition) {
              if (!hasPressedInside) FlameNavigator.pop();
              hasPressedInside = false;
            },
          ),
        ] else ...[
          FlameContainer(color: background),
        ],
        FlameCenter(
          child: FlameContainer(
            height: height,
            width: width + padding.horizontal,
            padding: padding,
            color: dialogBackground,
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
}

import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlamePositioned extends FlameWidget {
  final double x;
  final double y;
  // The width, if not set, child must have a width
  final double? width;
  // The height, if not set, child must have a height
  final double? height;
  // Wheter the given x and y are at the center of the child
  final bool isCentered;
  final FlameWidget child;

  FlamePositioned({
    required this.child,
    this.x = 0,
    this.y = 0,
    this.width,
    this.height,
  }) : isCentered = false;

  FlamePositioned.center({
    required this.child,
    this.x = 0,
    this.y = 0,
    this.width,
    this.height,
  }) : isCentered = true;

  @override
  FlameWidget build(BuildContext context) {
    final actualWidth = width ?? child.bounds.x;
    final actualHeight = height ?? child.bounds.y;
    EdgeInsets padding;
    if (isCentered) {
      padding = EdgeInsets.fromLTRB(
        x - actualWidth / 2,
        y - actualHeight / 2,
        bounds.x - (x + actualWidth / 2),
        bounds.y - (y + actualHeight / 2),
      );
    } else {
      padding = EdgeInsets.fromLTRB(
        x,
        y,
        bounds.x - (x + actualWidth),
        bounds.y - (y + actualHeight),
      );
    }
    return FlamePadding(
      child: child,
      padding: padding,
    );
  }
}

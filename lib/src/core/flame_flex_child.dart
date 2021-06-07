import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

abstract class FlameFlexibleChild extends SingleChildFlameWidget {
  int flex;

  FlameFlexibleChild({
    required this.flex,
    FlameWidget? child,
  }) : super(child);
}

abstract class FlameSizedChild extends SingleChildFlameWidget {
  double? width;
  double? height;

  FlameSizedChild({
    required this.width,
    required this.height,
    FlameWidget? child,
  }) : super(child);

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) {
    return Vector2(width ?? parentBounds.x, height ?? parentBounds.y);
  }

  @override
  void render(canvas, context) {
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, bounds.x, bounds.y));
    childBuild?.render(canvas, context);
    canvas.restore();
  }

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    final newBounds = Vector2(width ?? bounds.x, height ?? bounds.y);
    updateBounds(newBounds);
    childPreBuild?.updateBounds(newBounds);
    childBuild = childPreBuild?.build(context);
    childBuild?.reBuildChild(context, newBounds);
  }
}

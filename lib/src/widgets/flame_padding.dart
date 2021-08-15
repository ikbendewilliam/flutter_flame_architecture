import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/core/mixins/single_child_mixins.dart';
import 'package:flutter_flame_architecture/src/extensions/vector2_extension.dart';

class FlamePadding extends SingleChildFlameWidget with SingleChildUpdateMixin {
  final EdgeInsets padding;

  FlamePadding({
    required FlameWidget child,
    required this.padding,
  }) : super(child);

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) {
    final childMaxBounds = parentBounds - Vector2(padding.horizontal, padding.vertical);
    return childPreBuild!.determinePrefferedSize(childMaxBounds) + Vector2(padding.horizontal, padding.vertical);
  }

  @override
  void render(canvas, context) {
    canvas.save();
    canvas.translate(padding.left, padding.top);
    canvas.clipRect(Rect.fromLTWH(0, 0, bounds.x - padding.horizontal, bounds.y - padding.vertical));
    childBuild?.render(canvas, context);
    canvas.restore();
  }

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    updateData(bounds, context, null);
    final childBounds = bounds - Vector2(padding.horizontal, padding.vertical);
    childPreBuild?.updateData(childBounds, context, this);
    if (childBuild != this && childBuild != childPreBuild) childBuild?.dispose();
    childBuild = childPreBuild?.build(context);
    childBuild?.reBuildChild(context, childBounds);
  }

  @override
  Vector2 transformPoint(Vector2 point) => point - Vector2(padding.left, padding.top);

  @override
  bool isInsideBounds(Vector2 point) => point >= 0 && point < bounds - Vector2(padding.horizontal, padding.vertical);
}

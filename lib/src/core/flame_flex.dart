import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_flex_child.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/core/mixins/multiple_children_mixins.dart';

abstract class FlameFlex extends MultipleChildrenFlameWidget with MultipleChildrenUpdateMixin {
  Axis direction;

  bool get isHorizontal => direction == Axis.horizontal;

  FlameFlex({
    required List<FlameWidget> children,
    required this.direction,
  }) : super(children);

  @override
  void render(canvas, context) {
    canvas.save();
    childrenBuild.forEach((child) {
      child.render(canvas, context);
      if (isHorizontal) {
        canvas.translate(child.bounds.x, 0);
      } else {
        canvas.translate(0, child.bounds.y);
      }
    });
    canvas.restore();
  }

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    childrenBuild.clear();
    childrenBuild.addAll(childrenPreBuild.map((child) => child.build(context)));
    updateBounds(bounds);
    childrenBuild.forEach((child) => child.reBuildChild(context, child.bounds));
  }

  @override
  void updateBounds(newBounds) {
    super.updateBounds(newBounds);
    var totalChildSize = 0.0;
    var totalFlex = 0;
    childrenBuild.forEach((child) {
      if (child is FlameFlexibleChild) {
        totalFlex += child.flex;
      } else if (child is FlameSizedChild) {
        final size = (isHorizontal) ? child.width : child.height;
        if (size == null) {
          totalFlex += 1;
        } else {
          totalChildSize += size;
        }
      } else {
        totalFlex += 1;
      }
    });
    final totalSize = (isHorizontal) ? bounds.x : bounds.y;
    final flexibleSize = max(totalSize - totalChildSize, 0.0);
    final flexSize = flexibleSize / totalFlex;
    childrenBuild.forEach((child) {
      if (child is FlameFlexibleChild) {
        child.updateBounds(childBounds(child.flex * flexSize));
      } else if (child is FlameSizedChild) {
        if (child.width == null && child.height == null) {
          child.updateBounds(childBounds(flexSize));
        } else if (child.width == null) {
          if (isHorizontal) {
            child.updateBounds(Vector2(flexSize, child.height!));
          } else {
            child.updateBounds(childBounds(child.height!));
          }
        } else {
          if (isHorizontal) {
            child.updateBounds(childBounds(child.width!));
          } else {
            child.updateBounds(Vector2(child.width!, flexSize));
          }
        }
      } else {
        child.updateBounds(childBounds(flexSize));
      }
    });
  }

  Vector2 childBounds(double size) {
    switch (direction) {
      case Axis.horizontal:
        return Vector2(size, bounds.y);
      case Axis.vertical:
        return Vector2(bounds.x, size);
    }
  }
}

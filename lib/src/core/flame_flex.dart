import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_empty.dart';
import 'package:flutter_flame_architecture/src/core/flame_flex_child.dart';
import 'package:flutter_flame_architecture/src/core/flame_render_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/core/mixins/multiple_children_mixins.dart';
import 'package:flutter_flame_architecture/src/extensions/vector2_extension.dart';

abstract class FlameFlex extends MultipleChildrenFlameWidget with MultipleChildrenUpdateMixin {
  final Axis direction;
  final childrenBounds = <FlameWidget, Vector2>{};

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
    childrenBuild.addAll(childrenPreBuild.map((child) => _buildFlameWidget(child, context)));
    updateBounds(bounds);
    childrenBuild.forEach((child) => child.reBuildChild(context, child.bounds));
  }

  FlameWidget _buildFlameWidget(FlameWidget prebuildWidget, BuildContext context) {
    var buildWidget = prebuildWidget;
    var c = 0;
    while (c++ < 1000) {
      if (buildWidget is FlameRenderWidget) {
        return buildWidget.build(context);
      } else if (buildWidget is FlameEmpty) {
        return buildWidget;
      } else {
        buildWidget = buildWidget.build(context);
      }
    }
    throw Exception(
        'Max widget limit reached of 1000. Did you build recursive? If this is an issue please open an issue with a sample of your code on GitHub https://github.com/ikbendewilliam/flutter_flame_architecture');
  }

  @override
  void updateBounds(newBounds) {
    super.updateBounds(newBounds);
    var totalChildSize = 0.0;
    var totalFlex = 0;
    childrenBounds.clear();
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
      Vector2 childNewBounds;
      if (child is FlameFlexibleChild) {
        childNewBounds = childBounds(child.flex * flexSize);
      } else if (child is FlameSizedChild) {
        if (child.width == null && child.height == null) {
          childNewBounds = childBounds(flexSize);
        } else if (child.width == null) {
          if (isHorizontal) {
            childNewBounds = Vector2(flexSize, child.height!);
          } else {
            childNewBounds = childBounds(child.height!);
          }
        } else {
          if (isHorizontal) {
            childNewBounds = childBounds(child.width!);
          } else {
            childNewBounds = Vector2(child.width!, flexSize);
          }
        }
      } else {
        childNewBounds = childBounds(flexSize);
      }
      child.updateBounds(childNewBounds);
      childrenBounds[child] = childNewBounds;
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

  void _onAction(Vector2 position, Function(FlameWidget child, Vector2 transformedPosition) childMethod) {
    if (!isInsideBounds(position)) return;
    var transformedPosition = position;
    childrenBuild.forEach((child) {
      final childToBounds = childrenBounds[child];
      if (childToBounds == null || transformedPosition < 0) return; // Skip
      if (transformedPosition << childToBounds) {
        childMethod(child, transformedPosition);
      }
      switch (direction) {
        case Axis.horizontal:
          transformedPosition -= Vector2(childToBounds.x, 0);
          break;
        case Axis.vertical:
          transformedPosition -= Vector2(0, childToBounds.y);
          break;
      }
    });
  }

  void onTapDown(Vector2 tapPosition) => _onAction(tapPosition, (child, transformedPosition) => child.onTapDown(transformedPosition));

  void onTapUp(Vector2 tapPosition) => _onAction(tapPosition, (child, transformedPosition) => child.onTapUp(transformedPosition));

  void onDragStart(int pointerId, Vector2 position) => _onAction(position, (child, transformedPosition) => child.onDragStart(pointerId, transformedPosition));

  void onDragUpdate(int pointerId, Vector2 position) => _onAction(position, (child, transformedPosition) => child.onDragUpdate(pointerId, transformedPosition));

  void onDragEnd(int pointerId, Vector2 position) => _onAction(position, (child, transformedPosition) => child.onDragEnd(pointerId, transformedPosition));
}

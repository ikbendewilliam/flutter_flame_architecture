import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlameIsometricGridView extends FlameRenderWidget {
  final List<List<FlameWidget>> children;
  final List<List<FlameWidget>> childrenBuild = [];
  final Vector2 childSize;
  final bool clipChildBorder;

  FlameIsometricGridView({
    required this.children,
    required this.childSize,
    this.clipChildBorder = true,
  });

  @override
  void update(double delta) {
    super.update(delta);
    childrenBuild.forEach((row) => row.forEach((child) => child.update(delta)));
  }

  @override
  void render(Canvas canvas, BuildContext context) {
    final clipPath = Path()
      ..moveTo(childSize.x / sqrt2, 0)
      ..lineTo(childSize.x * sqrt2, childSize.y / sqrt2)
      ..lineTo(childSize.x / sqrt2, childSize.y * sqrt2)
      ..lineTo(0, childSize.y / sqrt2)
      ..close();
    final yStart = determinePrefferedSize(bounds).y * (childrenBuild.length / (childrenBuild.length + childrenBuild.first.length));
    childrenBuild.asMap().forEach((index, row) {
      canvas.save();
      canvas.translate(index * (childSize.x / sqrt2 - 0.5), yStart + (index + 1) * (childSize.y / sqrt2 - 0.5));
      row.forEach((child) {
        if (clipChildBorder) {
          canvas.save();
          canvas.clipPath(clipPath);
        }
        child.render(canvas, context);
        if (clipChildBorder) canvas.restore();
        canvas.translate(childSize.x / sqrt2 - 0.5, -childSize.y / sqrt2 + 0.5);
      });
      canvas.restore();
    });
  }

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    updateData(bounds, context, null);
    childrenBuild.clear();
    children.forEach((row) => row.forEach((child) => child.updateData(childSize, context, this)));
    childrenBuild.addAll(children.map((row) => row.map((child) => child.build(context)).toList()));
    childrenBuild.forEach((row) => row.forEach((child) => child.reBuildChild(context, childSize)));
  }

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) {
    final width = childSize.x / sqrt2 * (children.length + children.first.length);
    final height = childSize.y / sqrt2 * (children.length + children.first.length);
    return Vector2(width, height);
  }

  void _onAction(Vector2 position, Function(FlameWidget child, Vector2 transformedPosition) childMethod) {
    if (!isInsideBounds(position)) return;
    var transformedPosition = position;
    childrenBuild.forEach((row) {
      transformedPosition.x = 0;
      if (transformedPosition < 0) return; // Skip
      row.forEach((child) {
        if (transformedPosition < 0) return; // Skip
        if (transformedPosition << childSize) {
          childMethod(child, transformedPosition);
        }
        transformedPosition.x -= childSize.x;
      });
      transformedPosition.y -= childSize.y;
    });
  }

  @override
  void onTapDown(Vector2 tapPosition) => _onAction(tapPosition, (child, transformedPosition) => child.onTapDown(transformedPosition));

  @override
  void onTapUp(Vector2 tapPosition) => _onAction(tapPosition, (child, transformedPosition) => child.onTapUp(transformedPosition));

  @override
  void onDragStart(Vector2 position) => _onAction(position, (child, transformedPosition) => child.onDragStart(transformedPosition));

  @override
  void onDragUpdate(Vector2 position) => _onAction(position, (child, transformedPosition) => child.onDragUpdate(transformedPosition));

  @override
  void onDragEnd(Vector2 position) => _onAction(position, (child, transformedPosition) => child.onDragEnd(transformedPosition));

  @override
  void onScaleStart(Vector2 position) => _onAction(position, (child, transformedPosition) => child.onScaleStart(transformedPosition));

  @override
  void onScaleUpdate(Vector2 position, double scale) => _onAction(position, (child, transformedPosition) => child.onScaleUpdate(transformedPosition, scale));

  @override
  void onScaleEnd(Vector2 position, double scale) => _onAction(position, (child, transformedPosition) => child.onScaleEnd(transformedPosition, scale));
}

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
  void render(Canvas canvas, BuildContext context) {
    final clipPath = Path()
      ..moveTo(childSize.x / sqrt2, 0)
      ..lineTo(childSize.x * sqrt2, childSize.y / sqrt2)
      ..lineTo(childSize.x / sqrt2, childSize.y * sqrt2)
      ..lineTo(0, childSize.y / sqrt2)
      ..close();
    final yStart = determinePrefferedSize(bounds).y / 2;
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
    updateBounds(bounds);
    childrenBuild.clear();
    children.forEach((row) => row.forEach((child) => child.updateBounds(childSize)));
    childrenBuild.addAll(children.map((row) => row.map((child) => child.build(context)).toList()));
    childrenBuild.forEach((row) => row.forEach((child) => child.reBuildChild(context, childSize)));
  }

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) => Vector2(childSize.x * children.first.length / sqrt2 * 2, childSize.y * children.length / sqrt2 * 2);

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

  void onTapDown(Vector2 tapPosition) => _onAction(tapPosition, (child, transformedPosition) => child.onTapDown(transformedPosition));

  void onTapUp(Vector2 tapPosition) => _onAction(tapPosition, (child, transformedPosition) => child.onTapUp(transformedPosition));

  void onDragStart(int pointerId, Vector2 position) => _onAction(position, (child, transformedPosition) => child.onDragStart(pointerId, transformedPosition));

  void onDragUpdate(int pointerId, Vector2 position) => _onAction(position, (child, transformedPosition) => child.onDragUpdate(pointerId, transformedPosition));

  void onDragEnd(int pointerId, Vector2 position) => _onAction(position, (child, transformedPosition) => child.onDragEnd(pointerId, transformedPosition));
}

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlameGridView extends FlameRenderWidget {
  final List<List<FlameWidget>> children;
  final List<List<FlameWidget>> childrenBuild = [];
  final Vector2 childSize;

  FlameGridView({
    required this.children,
    required this.childSize,
  });

  @override
  void render(Canvas canvas, BuildContext context) {
    var dy = 0.0;
    childrenBuild.forEach((row) {
      canvas.save();
      canvas.translate(0, dy);
      row.forEach((child) {
        child.render(canvas, context);
        canvas.translate(childSize.x, 0);
      });
      canvas.restore();
      dy += childSize.y;
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
  Vector2 determinePrefferedSize(Vector2 parentBounds) => Vector2(childSize.x * children.length, childSize.y * children.first.length);

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

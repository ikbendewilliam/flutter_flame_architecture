import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlameGridView extends FlameRenderWidget {
  final List<List<FlameWidget>> children;
  final List<List<FlameWidget>> childrenBuild = [];
  final Vector2 childSize;
  final bool clipChildBorder;

  FlameGridView({
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
    var dy = 0.0;
    final clipRect = Rect.fromLTWH(0, 0, childSize.x, childSize.y);
    childrenBuild.forEach((row) {
      canvas.save();
      canvas.translate(0, dy);
      row.forEach((child) {
        if (clipChildBorder) {
          canvas.save();
          canvas.clipRect(clipRect);
        }
        child.render(canvas, context);
        if (clipChildBorder) canvas.restore();
        canvas.translate(childSize.x - 1, 0);
      });
      canvas.restore();
      dy += childSize.y - 1;
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
  Vector2 determinePrefferedSize(Vector2 parentBounds) => Vector2(childSize.x * children.first.length, childSize.y * children.length);

  void _onAction(Vector2 position, Function(FlameWidget child, Vector2 transformedPosition) childMethod) {
    if (!isInsideBounds(position)) return;
    final transformedPosition = Vector2(position.x, position.y);
    childrenBuild.forEach((row) {
      transformedPosition.x = position.x.toDouble();
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

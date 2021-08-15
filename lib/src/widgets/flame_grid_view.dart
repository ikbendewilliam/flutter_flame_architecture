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
  void dispose() {
    children
      ..forEach((row) {
        row
          ..forEach((element) {
            if (element != this) element.dispose();
          })
          ..clear();
      })
      ..clear();
    childrenBuild
      ..forEach((row) {
        row
          ..forEach((element) {
            if (element != this) element.dispose();
          })
          ..clear();
      })
      ..clear();
    super.dispose();
  }

  @override
  void update(double delta) {
    super.update(delta);
    childrenBuild.forEach((row) => row.forEach((child) => child.update(delta)));
  }

  @override
  void render(Canvas canvas, BuildContext context) {
    var dy = 0.0;
    final clipRect = Rect.fromLTWH(0, 0, childSize.x + 0.2, childSize.y + 0.2);
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
        canvas.translate(childSize.x, 0);
      });
      canvas.restore();
      dy += childSize.y;
    });
  }

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    updateData(bounds, context, null);
    final List<FlameWidget> flatChildren = children.expand((element) => element).toList();
    childrenBuild
      ..forEach((row) => row
        ..forEach((element) => flatChildren.contains(element) ? null : element.dispose())
        ..clear())
      ..clear();
    children.forEach((row) => row.forEach((child) => child.updateData(childSize + Vector2.all(0.2), context, this)));
    childrenBuild.addAll(children.map((row) => row.map((child) => child.build(context)).toList()));
    childrenBuild.forEach((row) => row.forEach((child) => child.reBuildChild(context, childSize + Vector2.all(0.2))));
  }

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) => Vector2(childSize.x * children.first.length, childSize.y * children.length);

  void _onAction(Vector2 position, Function(FlameWidget child, Vector2 transformedPosition) childMethod) {
    if (!isInsideBounds(position)) return;
    final transformedPosition = Vector2(position.x, position.y);
    for (final row in childrenBuild) {
      transformedPosition.x = position.x.toDouble();
      if (transformedPosition < 0) continue;
      for (final child in row) {
        if (transformedPosition < 0) continue;
        if (transformedPosition << childSize) {
          childMethod(child, transformedPosition);
          return;
        }
        transformedPosition.x -= childSize.x;
      }
      transformedPosition.y -= childSize.y;
    }
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

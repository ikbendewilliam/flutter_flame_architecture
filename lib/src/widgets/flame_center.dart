import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlameCenter extends SingleChildFlameWidget with SingleChildUpdateMixin {
  Vector2 _childDeterminedPrefferedSize = Vector2.zero();

  FlameCenter({
    required FlameWidget child,
  }) : super(child);

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) {
    _determineChildPrefferedSize(parentBounds);
    return parentBounds;
  }

  Vector2 _determineChildPrefferedSize(Vector2 parentBounds) {
    _childDeterminedPrefferedSize = childBuild?.determinePrefferedSize(parentBounds) ?? Vector2.zero();
    if (_childDeterminedPrefferedSize > bounds) {
      _childDeterminedPrefferedSize = Vector2(
        min(_childDeterminedPrefferedSize.x, bounds.x),
        min(_childDeterminedPrefferedSize.y, bounds.y),
      );
    }
    return _childDeterminedPrefferedSize;
  }

  @override
  void render(canvas, context) {
    canvas.save();
    if (_childDeterminedPrefferedSize == Vector2.zero()) _determineChildPrefferedSize(bounds);
    canvas.translate(bounds.x / 2 - _childDeterminedPrefferedSize.x / 2, bounds.y / 2 - _childDeterminedPrefferedSize.y / 2);
    canvas.clipRect(Rect.fromLTWH(0, 0, _childDeterminedPrefferedSize.x, _childDeterminedPrefferedSize.y));
    childBuild?.render(canvas, context);
    canvas.restore();
  }

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    updateData(bounds, context, null);
    var childBounds = _determineChildPrefferedSize(bounds);
    if (childBounds == Vector2.zero()) {
      childBounds = bounds;
    }
    childBuild?.dispose();
    childPreBuild?.updateData(childBounds, context, this);
    childBuild = childPreBuild?.build(context);
    childBuild?.reBuildChild(context, childBounds);
  }

  @override
  Vector2 transformPoint(Vector2 point) => point - (bounds - _childDeterminedPrefferedSize) / 2;

  @override
  bool isInsideBounds(Vector2 point) => point >= 0 && point < _childDeterminedPrefferedSize;
}

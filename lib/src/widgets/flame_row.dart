import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

class FlameRow extends MultipleChildrenFlameWidget {
  double childWidth = 0;

  FlameRow({
    required List<FlameWidget> children,
  }) : super(children);

  @override
  void render(canvas, context) {
    childrenBuild.asMap().forEach((index, child) {
      canvas.save();
      canvas.translate(childWidth * index, 0);
      canvas.clipRect(Rect.fromLTWH(0, 0, childWidth, bounds.y));
      child.render(canvas, context);
      canvas.restore();
    });
  }

  @override
  void updateBounds(newBounds) {
    super.updateBounds(newBounds);
    childWidth = newBounds.x / childrenBuild.length;
    // TODO: Make flexible childs (flex/size/...)
    final childBounds = Vector2(childWidth, bounds.y);
    childrenBuild.forEach((child) => child.updateBounds(childBounds));
  }

  @override
  void update(double delta) {
    super.update(delta);
    childrenBuild.forEach((child) => child.update(delta));
  }
}

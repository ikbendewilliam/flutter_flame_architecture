import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

class FlameColumn extends MultipleChildrenFlameWidget {
  double childHeight = 0;

  FlameColumn({
    required List<FlameWidget> children,
  }) : super(children);

  @override
  void render(canvas, context) {
    childrenBuild.asMap().forEach((index, child) {
      canvas.save();
      canvas.translate(0, childHeight * index);
      canvas.clipRect(Rect.fromLTWH(0, 0, bounds.x, childHeight));
      child.render(canvas, context);
      canvas.restore();
    });
  }

  @override
  void updateBounds(newBounds) {
    super.updateBounds(newBounds);
    childHeight = newBounds.y / childrenBuild.length;
    // TODO: Make flexible childs (flex/size/...)
    final childBounds = Vector2(newBounds.x, childHeight);
    childrenBuild.forEach((child) => child.updateBounds(childBounds));
  }

  @override
  void update(double delta) {
    super.update(delta);
    childrenBuild.forEach((child) => child.update(delta));
  }
}

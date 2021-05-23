import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

class FlamePadding extends SingleChildFlameWidget {
  final EdgeInsets padding;

  FlamePadding({
    required FlameWidget child,
    required this.padding,
  }) : super(child);

  @override
  void render(canvas, context) {
    canvas.save();
    canvas.translate(padding.left, padding.top);
    canvas.clipRect(Rect.fromLTWH(0, 0, padding.right - padding.left, padding.bottom - padding.top));
    childBuild!.render(canvas, context);
    canvas.restore();
  }

  @override
  void updateBounds(newBounds) {
    super.updateBounds(newBounds);
    final childBounds = newBounds - Vector2(padding.horizontal, padding.vertical);
    childBuild!.updateBounds(childBounds);
  }

  @override
  void update(double delta) {
    super.update(delta);
    childBuild!.update(delta);
  }
}

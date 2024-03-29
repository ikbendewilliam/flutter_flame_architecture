import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

class FlameCanvas extends SingleChildFlameWidget {
  final void Function(Canvas canvas, Vector2 bounds, BuildContext context) draw;
  final void Function(double delta)? onUpdate;

  FlameCanvas({
    required this.draw,
    this.onUpdate,
    FlameWidget? child,
  }) : super(child);

  @override
  void render(canvas, context) {
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, bounds.x, bounds.y));
    draw(canvas, bounds, context);
    childBuild?.render(canvas, context);
    canvas.restore();
  }

  @override
  void update(double delta) {
    super.update(delta);
    onUpdate?.call(delta);
    childBuild?.update(delta);
  }
}

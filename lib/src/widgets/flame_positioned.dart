import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlamePositioned extends SingleChildFlameWidget {
  final double? x;
  final double? y;
  final double? width;
  final double? height;
  final double Function()? xFunction;
  final double Function()? yFunction;
  final double? Function()? widthFunction;
  final double? Function()? heightFunction;
  // Wheter the given x and y are at the center of the child
  final bool isCentered;
  EdgeInsets padding = EdgeInsets.all(0);

  FlamePositioned({
    required FlameWidget child,
    this.x,
    this.y,
    this.width,
    this.height,
    this.xFunction,
    this.yFunction,
    this.widthFunction,
    this.heightFunction,
  })  : isCentered = false,
        super(child) {
    calculatePadding();
  }

  FlamePositioned.center({
    required FlameWidget child,
    this.x,
    this.y,
    this.width,
    this.height,
    this.xFunction,
    this.yFunction,
    this.widthFunction,
    this.heightFunction,
  })  : isCentered = true,
        super(child) {
    calculatePadding();
  }

  @override
  void update(double delta) {
    super.update(delta);
    calculatePadding();
    childBuild?.update(delta);
  }

  void calculatePadding() {
    final actualX = x ?? xFunction?.call() ?? 0;
    final actualY = y ?? yFunction?.call() ?? 0;
    final actualWidth = width ?? widthFunction?.call() ?? childBuild?.bounds.x ?? 0;
    final actualHeight = height ?? heightFunction?.call() ?? childBuild?.bounds.y ?? 0;
    if (isCentered) {
      padding = EdgeInsets.fromLTRB(
        actualX - actualWidth / 2,
        actualY - actualHeight / 2,
        bounds.x - (actualX + actualWidth / 2),
        bounds.y - (actualY + actualHeight / 2),
      );
    } else {
      padding = EdgeInsets.fromLTRB(
        actualX,
        actualY,
        bounds.x - (actualX + actualWidth),
        bounds.y - (actualY + actualHeight),
      );
    }
  }

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) {
    return childBuild!.determinePrefferedSize(parentBounds) + Vector2(padding.horizontal, padding.vertical);
  }

  @override
  void render(canvas, context) {
    canvas.save();
    canvas.translate(padding.left, padding.top);
    canvas.clipRect(Rect.fromLTWH(0, 0, bounds.x - padding.horizontal, bounds.y - padding.vertical));
    childBuild?.render(canvas, context);
    canvas.restore();
  }

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    updateBounds(bounds);
    final childBounds = bounds - Vector2(padding.horizontal, padding.vertical);
    childPreBuild?.updateBounds(childBounds);
    childBuild = childPreBuild?.build(context);
    childBuild?.reBuildChild(context, childBounds);
  }

  @override
  Vector2 transformPoint(Vector2 point) => point + Vector2(padding.left, padding.top);

  @override
  bool isInsideBounds(Vector2 point) => point >= 0 && point < bounds - Vector2(padding.horizontal, padding.vertical);
}

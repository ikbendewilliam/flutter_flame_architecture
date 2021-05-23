import 'package:flame/game.dart';
import 'package:flutter/material.dart';

abstract class FlameWidget {
  FlameWidget? childBuild;

  // The bounds of this widget, you cannot draw outside of these
  // This variable is initially set to 1, 1 only after being added
  // to the UI this might change, so don't use it only in the
  // constructor, but incorporate it in the render/update functions
  @protected
  Vector2 bounds = Vector2.all(1);

  // Update the bounds of this widget, note that if you have any children, you should call their updateBounds
  // Must call super first when overriding this
  @mustCallSuper
  void updateBounds(Vector2 newBounds) {
    this.bounds = newBounds;
    childBuild?.updateBounds(newBounds);
  }

  // You must call super if you override this *and* override build
  // Don't call super if you use this widget as a renderingWidget
  void render(Canvas canvas, BuildContext context) {
    childBuild?.render(canvas, context);
  }

  // You must call super if you override this *and* override build
  // Don't call super if you use this widget as a renderingWidget
  void update(double delta) {
    childBuild?.update(delta);
  }

  // Return widgets here that should be drawn as child(ren) of this widget
  // You should also update the child(ren) and call the render of the child(ren)
  FlameWidget build(BuildContext context);

  // Used to build this child, override to disable if you don't require build
  void reBuildChild(BuildContext context) {
    childBuild = build(context);
    childBuild?.reBuildChild(context);
  }
}

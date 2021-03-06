import 'package:flame/game.dart';
import 'package:flutter/material.dart';

abstract class FlameWidget {
  FlameWidget? childBuild;
  @protected
  BuildContext? context;
  FlameWidget? _parent;
  bool _disposed = false;
  bool get disposed => _disposed;

  /// The bounds of this widget, you cannot draw outside of these
  /// This variable is initially set to 1, 1 only after being added
  /// to the UI this might change, so don't use it only in the
  /// constructor, but incorporate it in the render/update functions
  @protected
  Vector2 bounds = Vector2.all(1);

  /// Update the bounds of this widget
  /// Must call super first when overriding this
  /// Note that your child(ren) should be updated during build
  @mustCallSuper
  void updateData(
      Vector2 newBounds, BuildContext context, FlameWidget? parent) {
    bounds = newBounds;
    this.context = context;
    if (parent != null) {
      _parent = parent;
    }
  }

  /// Marks for rebuild, similar to setState in Flutter
  void markForRebuild() {
    if (context != null && _parent != null)
      _parent!.reBuildChild(context!, _parent!.bounds);
  }

  /// You must call super if you override this *and* override build
  /// Don't call super if you use this widget as a renderingWidget
  void render(Canvas canvas, BuildContext context) {
    this.context = context;
    childBuild?.render(canvas, context);
  }

  /// Overwrite to dispose when this object is removed from the tree
  @mustCallSuper
  void dispose() {
    if (childBuild != this) childBuild?.dispose();
    childBuild = null;
    context = null;
    _parent = null;
    _disposed = true;
  }

  /// Determine how large this widget wants to be, based on constraints
  /// like child, width, height, fontSize, ...
  /// use parentBounds for unpreffered sizes
  Vector2 determinePrefferedSize(Vector2 parentBounds) => parentBounds;

  void onTapDown(Vector2 tapPosition) => childBuild?.onTapDown(tapPosition);

  void onTapUp(Vector2 tapPosition) => childBuild?.onTapUp(tapPosition);

  void onDragStart(Vector2 position) => childBuild?.onDragStart(position);

  void onDragUpdate(Vector2 position) => childBuild?.onDragUpdate(position);

  void onDragEnd(Vector2 position) => childBuild?.onDragEnd(position);

  void onScaleStart(Vector2 position) => childBuild?.onScaleStart(position);

  void onScaleUpdate(Vector2 position, double scale) =>
      childBuild?.onScaleUpdate(position, scale);

  void onScaleEnd(Vector2 position, double scale) =>
      childBuild?.onScaleEnd(position, scale);

  /// Only used in [FlameRenderWidgets] for now, FlameWidgets are not
  /// being updated correctly. If you want to update your state, use
  /// a [FlameCanvas] with onUpdate
  /// Don't call super if you use this widget as a renderingWidget
  void update(double delta) {
    childBuild?.update(delta);
  }

  /// Return widgets here that should be drawn as child(ren) of this widget
  /// You should also update the child(ren) and call the render of the child(ren)
  FlameWidget build(BuildContext context);

  /// Used to build this child, override to disable if you don't require (re)build
  void reBuildChild(BuildContext context, Vector2 bounds) {
    if (childBuild != this) childBuild?.dispose();
    updateData(bounds, context, null);
    childBuild = build(context);
    childBuild?.updateData(bounds, context, this);
    childBuild?.reBuildChild(context, bounds);
  }
}

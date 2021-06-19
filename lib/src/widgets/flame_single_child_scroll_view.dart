import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/core/mixins/single_child_mixins.dart';

class FlameSingleChildScrollView extends SingleChildFlameWidget with SingleChildUpdateMixin {
  final bool horizontalScrollEnabled;
  final bool verticalScrollEnabled;
  var _scroll = Vector2.zero();
  var _dragStartPosition = Vector2.zero();
  var _scrollStart = Vector2.zero();
  @protected
  var childPrefferedSize = Vector2.zero();
  var _isScrolling = false;

  FlameSingleChildScrollView({
    required FlameWidget child,
    this.horizontalScrollEnabled = true,
    this.verticalScrollEnabled = true,
  }) : super(child);

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) => parentBounds;

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    updateData(bounds, context, null);
    childPreBuild!.updateData(bounds, context, this);
    childBuild = childPreBuild!.build(context);
    childBuild!.reBuildChild(context, bounds);
    // We first build the child, then we know for sure that the child is ready to determine its size.
    // For now I don't see a better way, this is ofcourse not preferable if we want many rebuilds a second
    // but a flex only knows its renderable children after a build.
    childPrefferedSize = childBuild!.determinePrefferedSize(bounds);
    childBuild!.updateData(childPrefferedSize, context, this);
    childBuild = childPreBuild!.build(context);
    childBuild!.reBuildChild(context, childPrefferedSize);
    childPrefferedSize = childBuild!.determinePrefferedSize(bounds);
  }

  @override
  void render(Canvas canvas, BuildContext context) {
    canvas.save();
    canvas.translate(horizontalScrollEnabled ? _scroll.x : 0, verticalScrollEnabled ? _scroll.y : 0);
    childBuild?.render(canvas, context);
    canvas.restore();
  }

  @override
  Vector2 transformPoint(Vector2 point) {
    return point - Vector2(horizontalScrollEnabled ? _scroll.x : 0, verticalScrollEnabled ? _scroll.y : 0);
  }

  @override
  void onDragStart(Vector2 position) {
    if (!isInsideBounds(position)) return;
    _isScrolling = true;
    _scrollStart = _scroll;
    _dragStartPosition = position;
    super.onDragStart(position);
  }

  @override
  void onDragUpdate(Vector2 position) {
    if (!_isScrolling || !isInsideBounds(position)) {
      _isScrolling = false;
      return;
    }
    _scroll = this._scrollStart + position - this._dragStartPosition;
    if (!horizontalScrollEnabled) _scroll.x = 0;
    if (!verticalScrollEnabled) _scroll.y = 0;
    _checkBounds();
  }

  void _checkBounds() {
    if (_scroll.x < -childPrefferedSize.x + bounds.x) {
      _scroll.x = -childPrefferedSize.x + bounds.x;
    }
    if (_scroll.y < -childPrefferedSize.y + bounds.y) {
      _scroll.y = -childPrefferedSize.y + bounds.y;
    }
    if (_scroll.x > 0) {
      _scroll.x = 0;
    }
    if (_scroll.y > 0) {
      _scroll.y = 0;
    }
  }

  @override
  void onDragEnd(Vector2 position) {
    _isScrolling = false;
  }
}

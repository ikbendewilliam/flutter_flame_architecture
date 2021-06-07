import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/extensions/vector2_extension.dart';

class FlameSingleChildScrollView extends SingleChildFlameWidget {
  final bool horizontalScrollEnabled;
  final bool verticalScrollEnabled;
  var _scroll = Vector2.zero();
  var _dragStartPosition = Vector2.zero();
  var _scrollStart = Vector2.zero();
  var _childPrefferedSize = Vector2.zero();

  FlameSingleChildScrollView({
    required FlameWidget child,
    this.horizontalScrollEnabled = true,
    this.verticalScrollEnabled = true,
  }) : super(child);

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    updateBounds(bounds);
    childPreBuild!.updateBounds(bounds);
    childBuild = childPreBuild!.build(context);
    // We first build the child, then we know for sure that the child is ready to determine its size.
    // For now I don't see a better way, this is ofcourse not preferable if we want many rebuilds a second
    // but a flex only knows its renderable children after a build.
    _childPrefferedSize = childBuild!.determinePrefferedSize(bounds);
    childBuild!.updateBounds(_childPrefferedSize);
    childBuild = childPreBuild!.build(context);
    childBuild!.reBuildChild(context, _childPrefferedSize);
  }

  @override
  void render(Canvas canvas, BuildContext context) {
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, bounds.x, bounds.y));
    canvas.translate(horizontalScrollEnabled ? _scroll.x : 0, verticalScrollEnabled ? _scroll.y : 0);
    childBuild?.render(canvas, context);
    canvas.restore();
  }

  @override
  Vector2 transformPoint(Vector2 point) {
    return point - Vector2(horizontalScrollEnabled ? _scroll.x : 0, verticalScrollEnabled ? _scroll.y : 0);
  }

  @override
  void onDragStart(int pointerId, Vector2 position) {
    if (!isInsideBounds(position)) return;
    _scrollStart = _scroll;
    _dragStartPosition = position;
    super.onDragStart(pointerId, position);
  }

  @override
  void onDragUpdate(int pointerId, Vector2 position) {
    if (!isInsideBounds(position)) return;
    _scroll = this._scrollStart + position - this._dragStartPosition;
    _scroll.clampMax(_childPrefferedSize);
  }
}

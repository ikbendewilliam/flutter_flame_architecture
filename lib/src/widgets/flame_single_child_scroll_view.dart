import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/controllers/flame_scroll_controller.dart';
import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/core/mixins/single_child_mixins.dart';
import 'package:flutter_flame_architecture/src/extensions/vector2_extension.dart';

class FlameSingleChildScrollView extends SingleChildFlameWidget
    with SingleChildUpdateMixin, FlameScrollControllerListener {
  final bool horizontalScrollEnabled;
  final bool verticalScrollEnabled;
  final Alignment alingment;
  var _scroll = Vector2.zero();
  var _dragStartPosition = Vector2.zero();
  var _scrollStart = Vector2.zero();
  @protected
  var childPrefferedSize = Vector2.zero();
  var _isScrolling = false;
  final FlameScrollController? controller;

  FlameSingleChildScrollView({
    required FlameWidget child,
    this.horizontalScrollEnabled = true,
    this.verticalScrollEnabled = true,
    this.controller,
    this.alingment = Alignment.center,
  }) : super(child) {
    controller?.addListener(this);
  }

  @override
  void dispose() {
    controller?.removeListener(this);
    super.dispose();
  }

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) => parentBounds;

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    updateData(bounds, context, null);
    final childBounds = Vector2(
      horizontalScrollEnabled ? double.maxFinite : bounds.x,
      verticalScrollEnabled ? double.maxFinite : bounds.y,
    );
    childPreBuild!.updateData(childBounds, context, this);
    childBuild = childPreBuild!.build(context);
    childBuild!.reBuildChild(context, childBounds);
    childBuild!.updateData(childBounds, context, this);
    childPrefferedSize = childBuild!.determinePrefferedSize(childBounds);
    childBuild!.updateData(childPrefferedSize, context, this);
    childBuild!.reBuildChild(context, childPrefferedSize);
    if (controller != null && controller!.lastPosition != Vector2.zero()) {
      jumpTo(controller!.lastPosition);
    }
  }

  @override
  void render(Canvas canvas, BuildContext context) {
    canvas.save();
    if (childPrefferedSize.x < bounds.x) {
      canvas.translate(
          (alingment.x + 1) / 2 * (bounds.x - childPrefferedSize.x), 0);
    }
    if (childPrefferedSize.y < bounds.y) {
      canvas.translate(
          0, (alingment.y + 1) / 2 * (bounds.y - childPrefferedSize.y));
    }
    canvas.translate(horizontalScrollEnabled ? _scroll.x : 0,
        verticalScrollEnabled ? _scroll.y : 0);
    childBuild?.render(canvas, context);
    canvas.restore();
  }

  @override
  Vector2 transformPoint(Vector2 point) {
    final transformedPoint = Vector2.copy(point);
    if (childPrefferedSize.x < bounds.x) {
      transformedPoint.x -=
          (alingment.x + 1) / 2 * (bounds.x - childPrefferedSize.x);
    }
    if (childPrefferedSize.y < bounds.y) {
      transformedPoint.y -=
          (alingment.y + 1) / 2 * (bounds.y - childPrefferedSize.y);
    }
    return transformedPoint -
        Vector2(horizontalScrollEnabled ? _scroll.x : 0,
            verticalScrollEnabled ? _scroll.y : 0);
  }

  @override
  bool isInsideBounds(Vector2 point) =>
      !(point < 0) && point << childPrefferedSize;

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
    _scroll = _scrollStart + position - _dragStartPosition;
    if (!horizontalScrollEnabled) _scroll.x = 0;
    if (!verticalScrollEnabled) _scroll.y = 0;
    _checkBounds();
    controller?.updatePosition(_scroll);
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

  @override
  void jumpTo(Vector2 position) {
    _scroll = position;
    _checkBounds();
  }
}

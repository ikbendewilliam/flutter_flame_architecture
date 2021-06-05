import 'package:flame/components.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture/src/core/mixins/single_child_mixins.dart';

class FlameGestureDetector extends SingleChildFlameWidget with SingleChildRenderMixin, SingleChildUpdateMixin {
  final Function(Vector2 tapPosition)? _onTapDown;
  final Function(Vector2 tapPosition)? _onTapUp;
  final Function(int pointerId, Vector2 position)? _onDragStart;
  final Function(int pointerId, Vector2 position)? _onDragUpdate;
  final Function(int pointerId, Vector2 position)? _onDragEnd;
  final bool passThrough;

  FlameGestureDetector({
    FlameWidget? child,
    Function(Vector2 tapPosition)? onTapDown,
    Function(Vector2 tapPosition)? onTapUp,
    Function(int pointerId, Vector2 position)? onDragStart,
    Function(int pointerId, Vector2 position)? onDragUpdate,
    Function(int pointerId, Vector2 position)? onDragEnd,
    this.passThrough = false,
  })  : _onTapDown = onTapDown,
        _onTapUp = onTapUp,
        _onDragStart = onDragStart,
        _onDragUpdate = onDragUpdate,
        _onDragEnd = onDragEnd,
        super(child);

  @override
  void onTapDown(Vector2 tapPosition) {
    _onTapDown?.call(tapPosition);
    if (passThrough) super.onTapDown(tapPosition);
  }

  @override
  void onTapUp(Vector2 tapPosition) {
    _onTapUp?.call(tapPosition);
    if (passThrough) super.onTapUp(tapPosition);
  }

  @override
  void onDragStart(int pointerId, Vector2 position) {
    _onDragStart?.call(pointerId, position);
    if (passThrough) super.onDragStart(pointerId, position);
  }

  @override
  void onDragUpdate(int pointerId, Vector2 position) {
    _onDragUpdate?.call(pointerId, position);
    if (passThrough) super.onDragUpdate(pointerId, position);
  }

  @override
  void onDragEnd(int pointerId, Vector2 position) {
    _onDragEnd?.call(pointerId, position);
    if (passThrough) super.onDragEnd(pointerId, position);
  }
}

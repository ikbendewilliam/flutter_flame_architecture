import 'package:flame/components.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture/src/core/mixins/single_child_mixins.dart';

class FlameGestureDetector extends SingleChildFlameWidget with SingleChildRenderMixin, SingleChildUpdateMixin {
  final Function(Vector2 tapPosition)? _onTapDown;
  final Function(Vector2 tapPosition)? _onTapUp;
  final Function(Vector2 position)? _onDragStart;
  final Function(Vector2 position)? _onDragUpdate;
  final Function(Vector2 position)? _onDragEnd;
  final Function(Vector2 position)? _onScaleStart;
  final Function(Vector2 position, double scale)? _onScaleUpdate;
  final Function(Vector2 position, double scale)? _onScaleEnd;
  final bool passThrough;

  FlameGestureDetector({
    FlameWidget? child,
    Function(Vector2 tapPosition)? onTapDown,
    Function(Vector2 tapPosition)? onTapUp,
    Function(Vector2 position)? onDragStart,
    Function(Vector2 position)? onDragUpdate,
    Function(Vector2 position)? onDragEnd,
    Function(Vector2 position)? onScaleStart,
    Function(Vector2 position, double scale)? onScaleUpdate,
    Function(Vector2 position, double scale)? onScaleEnd,
    this.passThrough = false,
  })  : _onTapDown = onTapDown,
        _onTapUp = onTapUp,
        _onDragStart = onDragStart,
        _onDragUpdate = onDragUpdate,
        _onDragEnd = onDragEnd,
        _onScaleStart = onScaleStart,
        _onScaleUpdate = onScaleUpdate,
        _onScaleEnd = onScaleEnd,
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
  void onDragStart(Vector2 position) {
    _onDragStart?.call(position);
    if (passThrough) super.onDragStart(position);
  }

  @override
  void onDragUpdate(Vector2 position) {
    _onDragUpdate?.call(position);
    if (passThrough) super.onDragUpdate(position);
  }

  @override
  void onDragEnd(Vector2 position) {
    _onDragEnd?.call(position);
    if (passThrough) super.onDragEnd(position);
  }

  @override
  void onScaleStart(Vector2 position) {
    _onScaleStart?.call(position);
    if (passThrough) super.onScaleStart(position);
  }

  @override
  void onScaleUpdate(Vector2 position, double scale) {
    _onScaleUpdate?.call(position, scale);
    if (passThrough) super.onScaleUpdate(position, scale);
  }

  @override
  void onScaleEnd(Vector2 position, double scale) {
    _onScaleEnd?.call(position, scale);
    if (passThrough) super.onScaleEnd(position, scale);
  }
}

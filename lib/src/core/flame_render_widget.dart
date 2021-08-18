import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/extensions/vector2_extension.dart';

abstract class FlameRenderWidget extends FlameWidget {
  /// How to draw this widget on the canvas
  @override
  void render(Canvas canvas, BuildContext context) {}

  /// Implement this method to update the game state, given the time [delta] that has passed since the last update.
  /// Keep the updates as short as possible. [delta] is in seconds, with microseconds precision.
  @override
  void update(double delta) {}

  @override
  FlameWidget build(BuildContext context) => this;

  /// transform a point for child tap/drag
  Vector2 transformPoint(Vector2 point) => point;

  /// Check if a transformed point is inside your bounds (for child tap/drag)
  bool isInsideBounds(Vector2 point) =>
      !(point < 0) &&
      point <<
          bounds; // Note: !< is not the same as >> or >=, but is >>= which is not a valid operator unfortunately
}

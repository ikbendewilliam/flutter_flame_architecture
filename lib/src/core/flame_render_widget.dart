import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

abstract class FlameRenderWidget extends FlameWidget {
  // How to draw this widget on the canvas
  @override
  void render(Canvas canvas, BuildContext context) {}

  // Implement this method to update the game state, given the time [delta] that has passed since the last update.
  // Keep the updates as short as possible. [delta] is in seconds, with microseconds precision.
  @override
  void update(double delta) {}

  FlameWidget build(BuildContext context) => this;
}

import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

mixin NoChildMixin on FlameWidget {
  @override
  void render(Canvas canvas, BuildContext context) {}

  @override
  void reBuildChild(context, bounds) {
    updateData(bounds, context, null);
  }
}

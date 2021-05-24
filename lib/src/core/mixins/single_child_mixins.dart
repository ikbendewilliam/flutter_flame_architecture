import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';

mixin SingleChildUpdateMixin on SingleChildFlameWidget {
  @override
  void update(double delta) {
    super.update(delta);
    childBuild?.update(delta);
  }
}

mixin SingleChildRenderMixin on SingleChildFlameWidget {
  @override
  void render(canvas, context) {
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, bounds.x, bounds.y));
    childBuild?.render(canvas, context);
    canvas.restore();
  }
}

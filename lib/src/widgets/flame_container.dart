import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/src/core/flame_empty.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/widgets/flame_canvas.dart';
import 'package:flutter_flame_architecture/src/widgets/flame_padding.dart';

class FlameContainer extends FlameWidget {
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final FlameWidget? child;

  FlameContainer({
    this.backgroundColor,
    this.padding,
    this.child,
  }) : assert(padding == null || child != null);

  @override
  FlameWidget build(BuildContext context) {
    final paddingChild = (padding == null)
        ? child ?? FlameEmpty()
        : FlamePadding(
            child: child!,
            padding: padding!,
          );
    final backgroundChild = (backgroundColor == null)
        ? paddingChild
        : FlameCanvas(
            child: paddingChild,
            draw: (canvas, bounds, _) {
              final backgroundPaint = Paint()
                ..color = backgroundColor!
                ..style = PaintingStyle.fill;
              canvas.drawRect(Rect.fromLTWH(0, 0, bounds.x, bounds.y), backgroundPaint);
            },
          );
    return backgroundChild;
  }
}

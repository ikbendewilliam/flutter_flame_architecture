import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/src/core/flame_empty.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/widgets/flame_canvas.dart';
import 'package:flutter_flame_architecture/src/widgets/flame_padding.dart';
import 'package:flutter_flame_architecture/src/widgets/flame_sized_box.dart';

class FlameContainer extends FlameWidget {
  final Color? color;
  final EdgeInsets? padding;
  final FlameWidget? child;
  final double? width;
  final double? height;

  FlameContainer({
    this.color,
    this.padding,
    this.child,
    this.width,
    this.height,
  }) : assert(padding == null || child != null);

  @override
  FlameWidget build(BuildContext context) {
    final paddingChild = (padding == null)
        ? child ?? FlameEmpty()
        : FlamePadding(
            child: child!,
            padding: padding!,
          );
    final colorChild = (color == null)
        ? paddingChild
        : FlameCanvas(
            child: paddingChild,
            draw: (canvas, bounds, _) {
              final colorPaint = Paint()
                ..color = color!
                ..style = PaintingStyle.fill;
              canvas.drawRect(Rect.fromLTWH(0, 0, bounds.x, bounds.y), colorPaint);
            },
          );
    final sizedChild = (width == null && height == null)
        ? colorChild
        : FlameSizedBox(
            width: width,
            height: height,
            child: colorChild,
          );
    return sizedChild;
  }
}

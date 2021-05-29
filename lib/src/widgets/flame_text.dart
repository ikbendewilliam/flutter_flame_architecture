import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_render_widget.dart';
import 'package:flutter_flame_architecture/src/core/mixins/no_child_mixins.dart';

class FlameText extends FlameRenderWidget with NoChildMixin {
  TextPainter textPainter;
  TextAlign textAlign;

  FlameText(
    String text, {
    TextStyle? textStyle,
    Color color = Colors.black,
    this.textAlign = TextAlign.center,
  }) : textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: textStyle ??
                TextStyle(
                  color: color,
                ),
          ),
          textDirection: TextDirection.ltr,
          textAlign: textAlign,
        );

  @override
  void render(Canvas canvas, BuildContext context) {
    textPainter.layout(minWidth: bounds.x, maxWidth: bounds.x);
    textPainter.paint(canvas, Offset(0, 0));
  }
}

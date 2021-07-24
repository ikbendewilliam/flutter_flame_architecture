import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_render_widget.dart';
import 'package:flutter_flame_architecture/src/core/mixins/no_child_mixins.dart';

class FlameText extends FlameRenderWidget with NoChildMixin {
  TextPainter? textPainter;
  TextAlign textAlign;
  bool hasLayout = false;

  FlameText(
    String text, {
    TextStyle? textStyle,
    Color? color,
    this.textAlign = TextAlign.center,
  })  : textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: textStyle ??
                TextStyle(
                  color: color ?? Colors.black,
                ),
          ),
          textDirection: TextDirection.ltr,
          textAlign: textAlign,
        ),
        assert(textStyle == null || color == null);

  @override
  void dispose() {
    textPainter = null;
    super.dispose();
  }

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) {
    if (!hasLayout) {
      hasLayout = true;
      textPainter?.layout(minWidth: parentBounds.x, maxWidth: parentBounds.x);
    }
    return Vector2(parentBounds.x, textPainter?.height ?? 0);
  }

  @override
  void render(Canvas canvas, BuildContext context) {
    if (!hasLayout) {
      hasLayout = true;
      textPainter?.layout(minWidth: bounds.x, maxWidth: bounds.x);
    }
    textPainter?.paint(canvas, Offset(0, 0));
  }
}

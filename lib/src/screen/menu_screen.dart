import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlameMenuScreen extends FlameWidget {
  FlameWidget? background;
  Color backgroundColor;
  FlameWidget? title;
  String? titleText;
  List<FlameWidget> buttons;
  double paddingBottom;

  FlameMenuScreen({
    required this.buttons,
    this.backgroundColor = Colors.white,
    this.background,
    this.paddingBottom = 16,
    this.titleText,
    this.title,
  });

  @override
  FlameWidget build(BuildContext context) {
    return FlameContainer(
      color: backgroundColor,
      child: FlameColumn(
        children: [
          FlameSpacer(),
          if (title != null) ...[
            title!,
            FlameSpacer(),
          ] else if (titleText != null) ...[
            FlameSizedBox(
              height: 40,
              child: FlameText(titleText!),
            ),
            FlameSpacer(),
          ] else ...[
            FlameSpacer(),
          ],
          ...buttons,
          FlameSpacer(),
          FlameSizedBox(height: paddingBottom),
        ],
      ),
    );
  }
}

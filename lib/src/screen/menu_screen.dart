import 'package:flutter/material.dart';

import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/widgets/flame_container.dart';
import 'package:flutter_flame_architecture/src/widgets/flame_text.dart';

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
            FlameText(titleText!),
            FlameSpacer(),
          ],
          ...buttons.map(
            (button) => FlamePadding(
              child: button,
              padding: const EdgeInsets.all(4),
            ),
          ),
          FlameSizedBox(height: paddingBottom),
        ],
      ),
    );
  }
}

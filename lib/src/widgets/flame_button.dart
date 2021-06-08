import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlameButton extends FlameWidget {
  final String text;
  final VoidCallback onTap;
  final Color borderColor;
  final Color backgroundColor;

  FlameButton({
    required this.text,
    required this.onTap,
    this.borderColor = Colors.white,
    this.backgroundColor = Colors.black,
  });

  @override
  FlameWidget build(BuildContext context) {
    return FlameContainer(
      width: 256,
      height: 32,
      padding: const EdgeInsets.all(2),
      child: FlameGestureDetector(
        onTapUp: (_) => onTap(),
        child: FlameContainer(
          padding: const EdgeInsets.all(2),
          color: borderColor,
          child: FlameContainer(
            color: backgroundColor,
            child: FlameColumn(
              children: [
                FlameSpacer(),
                FlameText(
                  text,
                  color: Colors.white,
                ),
                FlameSpacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

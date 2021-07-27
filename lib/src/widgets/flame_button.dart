import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlameButton extends FlameWidget {
  final String? text;
  final VoidCallback onTap;
  final Color borderColor;
  final Color backgroundColor;
  final double width;
  final double height;
  FlameWidget? child;

  FlameButton({
    required this.onTap,
    this.text,
    this.child,
    this.borderColor = Colors.white,
    this.backgroundColor = Colors.black,
    this.width = 256,
    this.height = 32,
  }) : assert(text != null || child != null);

  @override
  FlameWidget build(BuildContext context) {
    return FlameContainer(
      width: width,
      height: height,
      padding: const EdgeInsets.all(2),
      child: FlameGestureDetector(
        onTapUp: (_) => onTap(),
        child: FlameContainer(
          padding: const EdgeInsets.all(2),
          color: borderColor,
          child: FlameContainer(
            color: backgroundColor,
            child: (child != null)
                ? child
                : FlameColumn(
                    children: [
                      FlameSpacer(),
                      if (text != null)
                        FlameText(
                          text!,
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

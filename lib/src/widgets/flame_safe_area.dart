import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlameSafeArea extends FlameWidget {
  final FlameWidget child;
  final bool top;
  final bool left;
  final bool right;
  final bool bottom;

  FlameSafeArea({
    required this.child,
    this.top = true,
    this.left = true,
    this.right = true,
    this.bottom = true,
  });

  @override
  FlameWidget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return FlamePadding(
      child: child,
      padding: EdgeInsets.only(
        top: top ? mediaQuery.padding.top : 0,
        left: left ? mediaQuery.padding.left : 0,
        right: right ? mediaQuery.padding.right : 0,
        bottom: bottom ? mediaQuery.padding.bottom : 0,
      ),
    );
  }
}

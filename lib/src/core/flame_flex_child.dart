import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

abstract class FlameFlexibleChild extends SingleChildFlameWidget {
  int flex;

  FlameFlexibleChild({
    required this.flex,
    FlameWidget? child,
  }) : super(child);
}

abstract class FlameSizedChild extends SingleChildFlameWidget {
  double? width;
  double? height;

  FlameSizedChild({
    required this.width,
    required this.height,
    FlameWidget? child,
  }) : super(child);
}

import 'package:flutter_flame_architecture/src/core/flame_flex_child.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/core/mixins/single_child_mixins.dart';

class FlameSizedBox extends FlameSizedChild
    with SingleChildUpdateMixin, SingleChildRenderMixin {
  FlameSizedBox({
    FlameWidget? child,
    double? width,
    double? height,
  }) : super(child: child, width: width, height: height);
}

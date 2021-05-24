import 'package:flutter_flame_architecture/src/core/flame_flex_child.dart';
import 'package:flutter_flame_architecture/src/core/mixins/no_child_mixins.dart';

class FlameSpacer extends FlameFlexibleChild with NoChildMixin {
  FlameSpacer({
    int flex = 1,
  }) : super(child: null, flex: flex);
}

import 'package:flutter_flame_architecture/src/core/flame_flex_child.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/core/mixins/single_child_mixins.dart';

class FlameExpanded extends FlameFlexibleChild with SingleChildUpdateMixin, SingleChildRenderMixin {
  FlameExpanded({
    required FlameWidget child,
    int flex = 1,
  }) : super(child: child, flex: flex);
}

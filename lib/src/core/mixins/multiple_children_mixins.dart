import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';

mixin MultipleChildrenUpdateMixin on MultipleChildrenFlameWidget {
  @override
  void update(double delta) {
    super.update(delta);
    childrenBuild.forEach((child) => child.update(delta));
  }
}

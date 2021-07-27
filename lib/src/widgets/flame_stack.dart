import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/core/mixins/multiple_children_mixins.dart';

class FlameStack extends MultipleChildrenFlameWidget with MultipleChildrenUpdateMixin {
  FlameStack({
    required List<FlameWidget> children,
  }) : super(children);

  @override
  void dispose() {
    childrenPreBuild.clear();
    childrenBuild.clear();
    super.dispose();
  }

  @override
  void render(canvas, context) {
    childrenBuild.forEach((child) => child.render(canvas, context));
  }

  @override
  void reBuildChild(context, bounds, {bool disposeUnusedWidgets = false}) {
    updateData(bounds, context, null);
    childrenBuild.clear();
    childrenPreBuild.forEach((child) => child.updateData(bounds, context, this));
    childrenBuild.addAll(childrenPreBuild.map((child) => child.build(context)));
    childrenBuild.forEach((child) => child.reBuildChild(context, bounds));
  }
}

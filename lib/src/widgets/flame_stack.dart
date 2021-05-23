import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

class FlameStack extends MultipleChildrenFlameWidget {
  FlameStack({
    required List<FlameWidget> children,
  }) : super(children);

  @override
  void render(canvas, context) {
    childrenBuild.forEach((child) => child.render(canvas, context));
  }

  @override
  void updateBounds(newBounds) {
    super.updateBounds(newBounds);
    childrenBuild.forEach((child) => child.updateBounds(newBounds));
  }

  @override
  void update(double delta) {
    super.update(delta);
    childrenBuild.forEach((child) => child.update(delta));
  }
}

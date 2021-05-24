import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_render_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

abstract class SingleChildFlameWidget extends FlameRenderWidget {
  final FlameWidget? childPreBuild;

  SingleChildFlameWidget(this.childPreBuild);

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    updateBounds(bounds);
    childPreBuild?.updateBounds(bounds);
    childBuild = childPreBuild?.build(context);
    childBuild?.reBuildChild(context, bounds);
  }
}

abstract class MultipleChildrenFlameWidget extends FlameRenderWidget {
  final List<FlameWidget> childrenPreBuild;
  final List<FlameWidget> childrenBuild = [];

  MultipleChildrenFlameWidget(this.childrenPreBuild);

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    updateBounds(bounds);
    childrenBuild.clear();
    childrenPreBuild.forEach((child) => child.updateBounds(bounds));
    childrenBuild.addAll(childrenPreBuild.map((child) => child.build(context)));
    childrenBuild.forEach((child) => child.reBuildChild(context, bounds));
  }
}

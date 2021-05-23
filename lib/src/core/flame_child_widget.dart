import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_render_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

abstract class SingleChildFlameWidget extends FlameRenderWidget {
  final FlameWidget? _child;

  SingleChildFlameWidget(this._child);

  @override
  void reBuildChild(BuildContext context) {
    childBuild = _child?.build(context);
    childBuild?.reBuildChild(context);
  }
}

abstract class MultipleChildrenFlameWidget extends FlameRenderWidget {
  final List<FlameWidget> _children;
  final List<FlameWidget> childrenBuild = [];

  MultipleChildrenFlameWidget(this._children);

  @override
  void reBuildChild(BuildContext context) {
    childrenBuild.clear();
    childrenBuild.addAll(_children.map((child) => child.build(context)));
    childrenBuild.forEach((child) => child.reBuildChild(context));
  }
}

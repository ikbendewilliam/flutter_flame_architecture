import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture/src/core/mixins/no_child_mixins.dart';

class FlameEmpty extends FlameWidget with NoChildMixin {
  @override
  FlameWidget build(BuildContext context) => this;

  @override
  void reBuildChild(_, __) {}
}

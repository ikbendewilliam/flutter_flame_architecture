import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlameEmpty extends FlameWidget with NoChildMixin {
  @override
  FlameWidget build(BuildContext context) => this;

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {}
}

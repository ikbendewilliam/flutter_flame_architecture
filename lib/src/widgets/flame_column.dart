import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_flex.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

class FlameColumn extends FlameFlex {
  FlameColumn({
    required List<FlameWidget> children,
  }) : super(children: children, direction: Axis.vertical);
}

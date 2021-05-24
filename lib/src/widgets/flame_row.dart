import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/src/core/flame_flex.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

class FlameRow extends FlameFlex {
  FlameRow({
    required List<FlameWidget> children,
  }) : super(children: children, direction: Axis.horizontal);
}

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/widgets/flame_center.dart';
import 'package:flutter_flame_architecture/src/widgets/flame_grid_view.dart';

class FlameWrap extends FlameWidget {
  final List<FlameWidget> children;
  final Vector2 childSize;
  final Axis direction;

  FlameWrap({
    required this.children,
    required this.childSize,
    this.direction = Axis.horizontal,
  });

  @override
  FlameWidget build(BuildContext context) {
    List<List<FlameWidget>> childrenGrid = [];
    int fitOnWidth;
    if (direction == Axis.horizontal) {
      fitOnWidth = (bounds.x / childSize.x).floor();
    } else {
      final fitOnHeight = (bounds.y / childSize.y).floor();
      fitOnWidth = (children.length / fitOnHeight).ceil();
    }
    var i = 0;
    children.forEach((element) {
      i++;
      if (i > fitOnWidth) {
        i = 1;
      }
      if (i == 1) {
        childrenGrid.add([]);
      }
      childrenGrid.last.add(element);
    });
    return FlameCenter(
      child: FlameGridView(
        children: childrenGrid,
        childSize: childSize,
      ),
    );
  }
}

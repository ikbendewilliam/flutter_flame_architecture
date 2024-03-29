import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_empty.dart';
import 'package:flutter_flame_architecture/src/core/flame_flex_child.dart';
import 'package:flutter_flame_architecture/src/core/flame_render_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/core/mixins/multiple_children_mixins.dart';
import 'package:flutter_flame_architecture/src/extensions/vector2_extension.dart';

abstract class FlameFlex extends MultipleChildrenFlameWidget
    with MultipleChildrenUpdateMixin {
  final Axis direction;
  final childrenBounds = <FlameWidget, Vector2>{};
  var _totalChildSize = 0.0;
  var _flexSize = 0.0;

  bool get isHorizontal => direction == Axis.horizontal;

  double get _maxChildSize => childrenBounds.values.isEmpty
      ? 0
      : childrenBounds.values
          .map((element) => isHorizontal ? element.y : element.x)
          .reduce((value, element) => value > element ? value : element);

  FlameFlex({
    required List<FlameWidget> children,
    required this.direction,
  }) : super(children);

  @override
  void render(canvas, context) {
    canvas.save();
    childrenBuild.forEach((child) {
      child.render(canvas, context);
      if (isHorizontal) {
        canvas.translate(child.bounds.x, 0);
      } else {
        canvas.translate(0, child.bounds.y);
      }
    });
    canvas.restore();
  }

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    childrenBuild
      ..clear()
      ..addAll(
          childrenPreBuild.map((child) => _buildFlameWidget(child, context)));
    updateData(bounds, context, null);
    childrenBuild.forEach(
        (child) => child.reBuildChild(context, childrenBounds[child]!));
  }

  FlameWidget _buildFlameWidget(
      FlameWidget prebuildWidget, BuildContext context) {
    var buildWidget = prebuildWidget;
    var c = 0;
    while (c++ < 1000) {
      if (buildWidget is FlameRenderWidget) {
        return buildWidget.build(context);
      } else if (buildWidget is FlameEmpty) {
        return buildWidget;
      } else {
        buildWidget = buildWidget.build(context);
      }
    }
    throw Exception(
        'Max widget limit reached of 1000. Did you build recursive? If this is an issue please open an issue with a sample of your code on GitHub https://github.com/ikbendewilliam/flutter_flame_architecture');
  }

  @override
  void updateData(
      Vector2 newBounds, BuildContext context, FlameWidget? parent) {
    super.updateData(newBounds, context, parent);
    _totalChildSize = 0.0;
    var totalFlex = 0;
    // This is done so these children can mark for rebuild
    childrenPreBuild
        .forEach((element) => element.updateData(newBounds, context, this));
    childrenBounds.clear();
    for (final child in childrenBuild) {
      if (child is FlameFlexibleChild) {
        totalFlex += child.flex;
      } else if (child is FlameSizedChild) {
        final size = isHorizontal ? child.width : child.height;
        if (size == null) {
          totalFlex += 1;
        } else {
          _totalChildSize += size;
        }
      } else {
        final childSize = child.determinePrefferedSize(bounds);
        final size = isHorizontal ? childSize.x : childSize.y;
        _totalChildSize += size;
      }
    }
    final availableSize = isHorizontal ? bounds.x : bounds.y;
    final flexibleSize = max(availableSize - _totalChildSize, 0.0);
    _flexSize = totalFlex > 0 ? flexibleSize / totalFlex : 0.0;
    for (final child in childrenBuild) {
      Vector2 childNewBounds;
      if (child is FlameFlexibleChild) {
        childNewBounds = _childBounds(child.flex * _flexSize);
      } else if (child is FlameSizedChild) {
        if (child.width == null && child.height == null) {
          childNewBounds = _childBounds(_flexSize);
        } else if (child.width == null) {
          if (isHorizontal) {
            childNewBounds = Vector2(_flexSize, child.height!);
          } else {
            childNewBounds = _childBounds(child.height!);
          }
        } else if (child.height == null) {
          if (isHorizontal) {
            childNewBounds = _childBounds(child.width!);
          } else {
            childNewBounds = Vector2(child.width!, _flexSize);
          }
        } else {
          childNewBounds = Vector2(child.width!, child.height!);
        }
      } else {
        final childSize = child.determinePrefferedSize(bounds);
        childNewBounds = childSize;
      }
      child.updateData(childNewBounds, context, this);
      childrenBounds[child] = childNewBounds;
    }
  }

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) {
    if (_flexSize > 0) {
      // use of flexible children is currently not supported in scrollable widgets
      return parentBounds;
    }
    switch (direction) {
      case Axis.horizontal:
        return Vector2(min(_totalChildSize, parentBounds.x), _maxChildSize);
      case Axis.vertical:
        return Vector2(_maxChildSize, min(_totalChildSize, parentBounds.y));
    }
  }

  Vector2 _childBounds(double size) {
    switch (direction) {
      case Axis.horizontal:
        return Vector2(size, bounds.y);
      case Axis.vertical:
        return Vector2(bounds.x, size);
    }
  }

  void _onAction(Vector2 position,
      Function(FlameWidget child, Vector2 transformedPosition) childMethod) {
    if (!isInsideBounds(position)) return;
    final actions = _childrenToActions(position, childMethod);
    for (final action in actions) {
      action();
    }
  }

  List<Function()> _childrenToActions(Vector2 transformedPosition,
      Function(FlameWidget child, Vector2 transformedPosition) childMethod) {
    final childFunctions = <Function()>[];
    for (final child in childrenBuild) {
      final childToBounds = childrenBounds[child];
      if (childToBounds == null || transformedPosition < 0)
        return childFunctions; // Skip
      if (transformedPosition << childToBounds) {
        final tp = Vector2.copy(transformedPosition);
        childFunctions.add(() => childMethod(child, tp));
      }
      switch (direction) {
        case Axis.horizontal:
          transformedPosition -= Vector2(childToBounds.x, 0);
          break;
        case Axis.vertical:
          transformedPosition -= Vector2(0, childToBounds.y);
          break;
      }
    }
    return childFunctions;
  }

  @override
  void onTapDown(Vector2 tapPosition) => _onAction(tapPosition,
      (child, transformedPosition) => child.onTapDown(transformedPosition));

  @override
  void onTapUp(Vector2 tapPosition) => _onAction(tapPosition,
      (child, transformedPosition) => child.onTapUp(transformedPosition));

  @override
  void onDragStart(Vector2 position) => _onAction(position,
      (child, transformedPosition) => child.onDragStart(transformedPosition));

  @override
  void onDragUpdate(Vector2 position) => _onAction(position,
      (child, transformedPosition) => child.onDragUpdate(transformedPosition));

  @override
  void onDragEnd(Vector2 position) => _onAction(position,
      (child, transformedPosition) => child.onDragEnd(transformedPosition));

  @override
  void onScaleStart(Vector2 position) => _onAction(position,
      (child, transformedPosition) => child.onScaleStart(transformedPosition));

  @override
  void onScaleUpdate(Vector2 position, double scale) => _onAction(
      position,
      (child, transformedPosition) =>
          child.onScaleUpdate(transformedPosition, scale));

  @override
  void onScaleEnd(Vector2 position, double scale) => _onAction(
      position,
      (child, transformedPosition) =>
          child.onScaleEnd(transformedPosition, scale));
}

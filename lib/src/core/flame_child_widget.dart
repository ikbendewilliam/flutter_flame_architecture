import 'dart:math';

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

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) => childPreBuild?.determinePrefferedSize(parentBounds) ?? parentBounds;

  void onTapDown(Vector2 tapPosition) {
    final transformedPoint = transformPoint(tapPosition);
    if (isInsideBounds(transformedPoint)) {
      childBuild?.onTapDown(transformedPoint);
    }
  }

  void onTapUp(Vector2 tapPosition) {
    final transformedPoint = transformPoint(tapPosition);
    if (isInsideBounds(transformedPoint)) {
      childBuild?.onTapUp(transformedPoint);
    }
  }

  void onDragStart(int pointerId, Vector2 position) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childBuild?.onDragStart(pointerId, transformedPoint);
    }
  }

  void onDragUpdate(int pointerId, Vector2 position) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childBuild?.onDragUpdate(pointerId, transformedPoint);
    }
  }

  void onDragEnd(int pointerId, Vector2 position) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childBuild?.onDragEnd(pointerId, transformedPoint);
    }
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

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) => childrenPreBuild.map((e) => e.determinePrefferedSize(parentBounds)).reduce(
        (value, element) => Vector2(max(value.x, element.x), max(value.y, element.y)),
      );

  void onTapDown(Vector2 tapPosition) {
    final transformedPoint = transformPoint(tapPosition);
    if (isInsideBounds(transformedPoint)) {
      childrenBuild.forEach((child) => child.onTapDown(transformedPoint));
    }
  }

  void onTapUp(Vector2 tapPosition) {
    final transformedPoint = transformPoint(tapPosition);
    if (isInsideBounds(transformedPoint)) {
      childrenBuild.forEach((child) => child.onTapUp(transformedPoint));
    }
  }

  void onDragStart(int pointerId, Vector2 position) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childrenBuild.forEach((child) => child.onDragStart(pointerId, transformedPoint));
    }
  }

  void onDragUpdate(int pointerId, Vector2 position) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childrenBuild.forEach((child) => child.onDragUpdate(pointerId, transformedPoint));
    }
  }

  void onDragEnd(int pointerId, Vector2 position) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childrenBuild.forEach((child) => child.onDragEnd(pointerId, transformedPoint));
    }
  }
}

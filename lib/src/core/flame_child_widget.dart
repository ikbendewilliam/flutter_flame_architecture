import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_render_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

abstract class SingleChildFlameWidget extends FlameRenderWidget {
  FlameWidget? childPreBuild;

  SingleChildFlameWidget(this.childPreBuild);

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    if (childBuild != this && childBuild != childPreBuild)
      childBuild?.dispose();
    updateData(bounds, context, null);
    childPreBuild?.updateData(bounds, context, this);
    childBuild = childPreBuild?.build(context);
    childBuild?.reBuildChild(context, bounds);
  }

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) =>
      childPreBuild?.determinePrefferedSize(parentBounds) ?? parentBounds;

  @override
  void dispose() {
    if (childPreBuild != this) childPreBuild?.dispose();
    childPreBuild = null;
    super.dispose();
  }

  @override
  void onTapDown(Vector2 tapPosition) {
    final transformedPoint = transformPoint(tapPosition);
    if (isInsideBounds(transformedPoint)) {
      childBuild?.onTapDown(transformedPoint);
    }
  }

  @override
  void onTapUp(Vector2 tapPosition) {
    final transformedPoint = transformPoint(tapPosition);
    if (isInsideBounds(transformedPoint)) {
      childBuild?.onTapUp(transformedPoint);
    }
  }

  @override
  void onDragStart(Vector2 position) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childBuild?.onDragStart(transformedPoint);
    }
  }

  @override
  void onDragUpdate(Vector2 position) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childBuild?.onDragUpdate(transformedPoint);
    }
  }

  @override
  void onDragEnd(Vector2 position) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childBuild?.onDragEnd(transformedPoint);
    }
  }

  @override
  void onScaleStart(Vector2 position) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childBuild?.onScaleStart(transformedPoint);
    }
  }

  @override
  void onScaleUpdate(Vector2 position, double scale) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childBuild?.onScaleUpdate(transformedPoint, scale);
    }
  }

  @override
  void onScaleEnd(Vector2 position, double scale) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childBuild?.onScaleEnd(transformedPoint, scale);
    }
  }
}

abstract class MultipleChildrenFlameWidget extends FlameRenderWidget {
  final List<FlameWidget> childrenPreBuild;
  final List<FlameWidget> childrenBuild = [];

  MultipleChildrenFlameWidget(this.childrenPreBuild);

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    childrenBuild
      ..forEach((element) {
        if (element != this) element.dispose();
      })
      ..clear();
    updateData(bounds, context, null);
    childrenPreBuild
        .forEach((child) => child.updateData(bounds, context, this));
    childrenBuild.addAll(childrenPreBuild.map((child) => child.build(context)));
    childrenBuild.forEach((child) => child.reBuildChild(context, bounds));
  }

  @override
  void dispose() {
    childrenPreBuild
      ..forEach((element) {
        if (element != this) element.dispose();
      })
      ..clear();
    childrenBuild
      ..forEach((element) {
        if (element != this) element.dispose();
      })
      ..clear();
    super.dispose();
  }

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) =>
      childrenBuild.map((e) => e.determinePrefferedSize(parentBounds)).reduce(
            (value, element) =>
                Vector2(max(value.x, element.x), max(value.y, element.y)),
          );

  @override
  void onTapDown(Vector2 tapPosition) {
    final transformedPoint = transformPoint(tapPosition);
    if (isInsideBounds(transformedPoint)) {
      childrenBuild.forEach((child) => child.onTapDown(transformedPoint));
    }
  }

  @override
  void onTapUp(Vector2 tapPosition) {
    final transformedPoint = transformPoint(tapPosition);
    if (isInsideBounds(transformedPoint)) {
      childrenBuild.forEach((child) => child.onTapUp(transformedPoint));
    }
  }

  @override
  void onDragStart(Vector2 position) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childrenBuild.forEach((child) => child.onDragStart(transformedPoint));
    }
  }

  @override
  void onDragUpdate(Vector2 position) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childrenBuild.forEach((child) => child.onDragUpdate(transformedPoint));
    }
  }

  @override
  void onDragEnd(Vector2 position) {
    final transformedPoint = transformPoint(position);
    if (isInsideBounds(transformedPoint)) {
      childrenBuild.forEach((child) => child.onDragEnd(transformedPoint));
    }
  }
}

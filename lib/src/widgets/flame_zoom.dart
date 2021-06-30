import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/src/core/flame_child_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/extensions/vector2_extension.dart';

class FlameZoom extends SingleChildFlameWidget {
  final double initialZoom;
  final double Function()? setZoom;
  final double maxZoom;
  final double minZoom;
  final ZoomAlignment zoomAlignment;
  double zoom;
  double? _zoomStart;
  Vector2 _childDeterminedPrefferedSize = Vector2.zero();

  FlameZoom({
    required FlameWidget child,
    this.initialZoom = 1,
    this.setZoom,
    this.minZoom = 0.5,
    this.maxZoom = 2,
    this.zoomAlignment = ZoomAlignment.center,
  })  : zoom = initialZoom,
        super(child);

  @override
  Vector2 determinePrefferedSize(Vector2 parentBounds) => parentBounds;

  Vector2 _determineChildPrefferedSize(Vector2 parentBounds) {
    _childDeterminedPrefferedSize = childBuild?.determinePrefferedSize(parentBounds) ?? Vector2.zero();
    return _childDeterminedPrefferedSize;
  }

  @override
  void render(canvas, context) {
    canvas.save();
    canvas.scale(zoom, zoom);
    if (zoomAlignment == ZoomAlignment.center) {
      if (_childDeterminedPrefferedSize == Vector2.zero()) _determineChildPrefferedSize(bounds);
      if (bounds.x > _childDeterminedPrefferedSize.x * zoom) {
        canvas.translate((bounds.x - _childDeterminedPrefferedSize.x * zoom) / 2, 0);
      }
      if (bounds.y > _childDeterminedPrefferedSize.y * zoom) {
        canvas.translate(0, (bounds.y - _childDeterminedPrefferedSize.y * zoom) / 2);
      }
    }
    childBuild?.render(canvas, context);
    canvas.restore();
  }

  @override
  void reBuildChild(BuildContext context, Vector2 bounds) {
    updateData(bounds, context, null);
    final childBounds = bounds / zoom;
    childPreBuild?.updateData(childBounds, context, this);
    childBuild = childPreBuild?.build(context);
    childBuild?.reBuildChild(context, childBounds);
  }

  @override
  Vector2 transformPoint(Vector2 point) => point / zoom;

  @override
  bool isInsideBounds(Vector2 point) => point >= 0 && point < bounds / zoom;

  @override
  void update(double delta) {
    super.update(delta);
    if (setZoom != null) {
      zoom = setZoom!();
    }
    childBuild?.update(delta);
  }

  @override
  void onScaleStart(Vector2 position) {
    if (setZoom == null && isInsideBounds(position)) {
      _zoomStart = zoom;
    }
  }

  @override
  void onScaleUpdate(Vector2 position, double scale) {
    if (setZoom == null && isInsideBounds(position)) {
      zoom = _zoomStart! * scale;
      zoom = zoom.clamp(minZoom, maxZoom);
      childPreBuild?.updateData(bounds / zoom, context!, this);
    }
  }
}

enum ZoomAlignment {
  center,
  topLeft,
}

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_render_widget.dart';
import 'package:flutter_flame_architecture/src/core/flame_sprite_collector.dart';
import 'package:flutter_flame_architecture/src/core/mixins/no_child_mixins.dart';

class FlameSprite extends FlameRenderWidget with NoChildMixin {
  final String? spriteFileName;
  Sprite? sprite;
  final Vector2? position;
  final Vector2? size;
  final Anchor anchor;
  final Paint? overridePaint;

  /// Load and render a sprite, sprite or spriteFileName must not be null
  ///
  /// **Note** Flame requires you to put the assets in a folder **assets/images/** or below
  /// When providing the fileName, this assets/images/ should not be added
  FlameSprite({
    this.spriteFileName,
    this.sprite,
    this.position,
    this.size,
    this.anchor = Anchor.topLeft,
    this.overridePaint,
  }) : assert(sprite != null || spriteFileName != null) {
    if (sprite == null && spriteFileName != null) _loadSprite();
  }

  Future<void> _loadSprite() async {
    sprite = await FlameSpriteCollector.instance.getSprite(spriteFileName!);
  }

  @override
  void render(Canvas canvas, BuildContext context) {
    sprite?.render(
      canvas,
      overridePaint: overridePaint,
      anchor: anchor,
      position: position,
      size: size ?? bounds,
    );
  }
}

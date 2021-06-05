import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';

abstract class GameManager extends Game with MultiTouchDragDetector, MultiTouchTapDetector {
  @override
  void onAttach() {
    super.onAttach();
    build();
  }

  void build({BuildContext? testContext});
}

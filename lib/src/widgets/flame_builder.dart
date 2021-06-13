import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

class FlameBuilder extends FlameWidget {
  final FlameWidget Function(BuildContext context) _build;

  FlameBuilder({
    required FlameWidget Function(BuildContext context) build,
  }) : _build = build;

  @override
  FlameWidget build(BuildContext context) => _build(context);
}

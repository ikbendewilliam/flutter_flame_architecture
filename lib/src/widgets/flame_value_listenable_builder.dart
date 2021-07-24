import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlameValueListenableBuilder<T> extends FlameWidget {
  final FlameWidget Function(BuildContext context, T value, FlameWidget? child) builder;
  ValueNotifier<T>? valueListenable;
  FlameWidget? child;

  FlameValueListenableBuilder({
    required this.builder,
    required this.valueListenable,
    this.child,
  }) {
    valueListenable?.addListener(markForRebuild);
  }

  @override
  void dispose() {
    valueListenable?.removeListener(markForRebuild);
    valueListenable = null;
    child?.dispose();
    child = null;
    super.dispose();
  }

  @override
  FlameWidget build(BuildContext context) {
    if (valueListenable == null) return FlameEmpty();
    return builder(context, valueListenable!.value, child);
  }
}

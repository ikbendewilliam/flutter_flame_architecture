import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlameValueListenableBuilder<T> extends FlameWidget {
  final FlameWidget Function(BuildContext context, T? value, FlameWidget? child) builder;
  final bool Function(T? oldValue, T newValue)? shouldRebuild;
  ValueNotifier<T>? valueListenable;
  FlameWidget? child;
  T? _oldValue;

  FlameValueListenableBuilder({
    required this.builder,
    required this.valueListenable,
    this.shouldRebuild,
    this.child,
  }) {
    valueListenable?.addListener(_maybeRebuild);
  }

  @override
  void dispose() {
    valueListenable?.removeListener(_maybeRebuild);
    valueListenable = null;
    super.dispose();
  }

  void _maybeRebuild() {
    if (valueListenable == null) return;
    if (shouldRebuild?.call(_oldValue, valueListenable!.value) ?? true) markForRebuild();
    _oldValue = valueListenable!.value;
  }

  @override
  FlameWidget build(BuildContext context) {
    return builder(context, valueListenable?.value, child);
  }
}

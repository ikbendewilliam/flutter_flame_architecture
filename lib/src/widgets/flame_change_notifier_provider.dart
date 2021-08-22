import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/src/core/flame_widget.dart';
import 'package:flutter_flame_architecture/src/widgets/flame_value_listenable_builder.dart';

class FlameChangeNotifierProvider<T extends ChangeNotifier> extends FlameWidget {
  final T Function() create;
  final FlameWidget? child;
  final FlameWidget Function(BuildContext context, T viewModel)? builder;
  final FlameWidget Function(BuildContext context, T viewModel, FlameWidget? child)? builderWithChild;
  late final T changeNotifier;
  ValueNotifier<FlameWidget>? valueListenable;

  /// Listens to a ChangeNotifier and dispose it automatically
  FlameChangeNotifierProvider({
    required this.create,
    this.child,
    this.builder,
    this.builderWithChild,
  })  : assert(child == null || builder == null, 'either use child or builder, to use both, use builderWithChild'),
        assert(child != null || builder != null || builderWithChild != null, 'either child, builder or builderWithChild should be provided') {
    changeNotifier = create();
    changeNotifier.addListener(updateChild);
  }

  @override
  void dispose() {
    changeNotifier.removeListener(updateChild);
    changeNotifier.dispose();
    super.dispose();
  }

  void updateChild() {
    if (context == null) return;
    final newBuild = buildChild(context!);
    if (newBuild != valueListenable?.value) valueListenable?.value.dispose();
    valueListenable?.value = newBuild;
  }

  FlameWidget buildChild(BuildContext context) {
    if (builderWithChild != null) return builderWithChild!(context, changeNotifier, child);
    if (builder != null) return builder!(context, changeNotifier);
    if (child != null) return child!;
    throw Exception('no builder or child provided');
  }

  @override
  FlameWidget build(BuildContext context) {
    valueListenable ??= ValueNotifier(buildChild(context));
    return FlameValueListenableBuilder<FlameWidget>(
      builder: (context, value, _) => value,
      valueListenable: valueListenable,
    );
  }
}

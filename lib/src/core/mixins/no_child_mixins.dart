import 'package:flutter_flame_architecture/src/core/flame_widget.dart';

mixin NoChildMixin on FlameWidget {
  @override
  void render(_, __) {}

  @override
  void reBuildChild(context, bounds, {bool disposeUnusedWidgets = false}) {
    updateData(bounds, context, null);
  }
}

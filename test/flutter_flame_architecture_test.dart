import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  test('test build tree', () {
    final canvas = FlameCanvas(draw: (_, __, ___) {});
    final customChild = CustomWidget(canvas);
    final stack = FlameStack(
      children: [customChild],
    );
    final container = FlameContainer(
      color: Colors.black,
      child: stack,
    );
    final gameManager = SimpleGameManager(home: container);
    gameManager.build(testContext: MockBuildContext());
    print(gameManager.currentScreen);
  });
}

class CustomWidget extends FlameWidget {
  final FlameWidget _child;

  CustomWidget(this._child);

  @override
  FlameWidget build(BuildContext context) {
    return _child;
  }
}

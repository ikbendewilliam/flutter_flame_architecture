import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class SingleChildScrollViewExample extends FlameWidget {
  static const routeName = 'SingleChildScrollViewExample';

  @override
  FlameWidget build(BuildContext context) {
    return FlameSizedBox(
      width: 100,
      height: 100,
      child: FlameSingleChildScrollView(
        horizontalScrollEnabled: false,
        child: FlameColumn(
          children: [
            FlameContainer(color: Colors.red, height: 50),
            FlameContainer(color: Colors.orange, height: 50),
            FlameContainer(color: Colors.yellow, height: 50),
            FlameContainer(color: Colors.green, height: 50),
            FlameContainer(color: Colors.blue, height: 50),
            FlameContainer(color: Colors.indigo, height: 50),
            FlameContainer(color: Colors.purple, height: 50),
          ],
        ),
      ),
    );
  }
}

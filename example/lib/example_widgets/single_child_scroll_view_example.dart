import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class SingleChildScrollViewExample extends FlameWidget {
  static const routeName = 'SingleChildScrollViewExample';

  FlameWidget _generateRainbowRow(int startIndex) {
    var rainbow = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];
    rainbow.addAll(rainbow.toList());
    rainbow = rainbow.getRange(startIndex, startIndex + 7).toList();
    return FlameRow(
      children: rainbow.map((color) => FlameContainer(color: color, width: 150, height: 150)).toList(),
    );
  }

  @override
  FlameWidget build(BuildContext context) {
    var i = 0;
    return FlameColumn(
      children: [
        FlameButton(
          text: 'back',
          onTap: FlameNavigator.pop,
        ),
        FlameSizedBox(
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
        ),
        FlameSizedBox(
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
        ),
        FlameSizedBox(
          height: 100,
          child: FlameSingleChildScrollView(
            verticalScrollEnabled: false,
            child: FlameRow(
              children: [
                FlameContainer(color: Colors.red, width: 200),
                FlameContainer(color: Colors.orange, width: 200),
                FlameContainer(color: Colors.yellow, width: 200),
                FlameContainer(color: Colors.green, width: 200),
                FlameContainer(color: Colors.blue, width: 200),
                FlameContainer(color: Colors.indigo, width: 200),
                FlameContainer(color: Colors.purple, width: 200),
              ],
            ),
          ),
        ),
        FlameExpanded(
          child: FlameSingleChildScrollView(
            child: FlameColumn(
              children: [
                _generateRainbowRow(i++),
                _generateRainbowRow(i++),
                _generateRainbowRow(i++),
                _generateRainbowRow(i++),
                _generateRainbowRow(i++),
                _generateRainbowRow(i++),
                _generateRainbowRow(i++),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

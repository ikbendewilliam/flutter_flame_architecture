import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class FlameCenter extends FlameWidget {
  final FlameWidget child;

  FlameCenter({
    required this.child,
  });

  @override
  FlameWidget build(BuildContext context) {
    return FlameColumn(
      children: [
        FlameSpacer(),
        FlameExpanded(
          child: FlameRow(
            children: [
              FlameSpacer(),
              child,
              FlameSpacer(),
            ],
          ),
        ),
        FlameSpacer(),
      ],
    );
  }
}

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

void main() {
  final gameManager = GameManager(
    home: Pong(),
  );
  runApp(
    MaterialApp(
      home: GameWidget(
        game: gameManager,
      ),
    ),
  );
}

class Pong extends FlameWidget {
  @override
  FlameWidget build(BuildContext context) {
    return FlameContainer(
      color: Colors.black,
      child: FlameStack(
        children: [
          Borders(),
          Ball(),
          Paddle(x: 15),
          Paddle(x: bounds.x - 15),
        ],
      ),
    );
  }
}

class Borders extends FlameWidget {
  @override
  FlameWidget build(BuildContext context) {
    return FlameColumn(
      children: [
        FlameContainer(
          color: Colors.white,
          height: 10,
        ),
        FlameExpanded(
          child: FlameRow(
            children: [
              FlameSpacer(),
              FlameSizedBox(
                width: 10,
                child: DottedLine(),
              ),
              FlameSpacer(),
            ],
          ),
        ),
        FlameContainer(
          color: Colors.white,
          height: 10,
        ),
      ],
    );
  }
}

class Paddle extends FlameWidget {
  final double x;

  Paddle({required this.x});

  @override
  FlameWidget build(BuildContext context) {
    return FlamePositioned.center(
      x: x,
      y: bounds.y / 2,
      width: 10,
      height: 100,
      child: FlameContainer(
        color: Colors.white,
      ),
    );
  }
}

class DottedLine extends FlameWidget {
  @override
  FlameWidget build(BuildContext context) {
    return FlameCanvas(
      draw: (canvas, bounds, context) {
        final paint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;
        var y = 0.0;
        final dy = 10.0;
        while (y < bounds.y) {
          canvas.drawRect(Rect.fromLTWH(0, y, bounds.x, dy), paint);
          y += dy * 2;
        }
      },
    );
  }
}

class Ball extends FlameWidget {
  double x = 0;

  @override
  void update(double delta) {
    super.update(delta);
    x = (x + 1) % bounds.x;
  }

  @override
  FlameWidget build(BuildContext context) {
    return FlameCanvas(
      draw: (canvas, bounds, context) {
        final paint = Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.white;
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset(x, bounds.y / 2),
            width: 10,
            height: 10,
          ),
          paint,
        );
      },
    );
  }
}

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
      backgroundColor: Colors.black,
      child: FlameStack(
        children: [
          Borders(),
          Ball(),
        ],
      ),
    );
  }
}

class Borders extends FlameWidget {
  @override
  FlameWidget build(BuildContext context) {
    return FlameCanvas(
      draw: (canvas, bounds, context) {
        final paint = Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.white
          ..strokeWidth = 10;
        canvas.drawRect(
          Rect.fromLTRB(0, 0, bounds.x, bounds.y),
          paint,
        );
      },
    );
  }
}

class Ball extends FlameWidget {
  @override
  FlameWidget build(BuildContext context) {
    return FlameCanvas(
      draw: (canvas, bounds, context) {
        final paint = Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.white;
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset(100, 100),
            width: 10,
            height: 10,
          ),
          paint,
        );
      },
    );
  }
}

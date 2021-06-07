import 'dart:math';

import 'package:example/helper.dart';
import 'package:example/single_child_scroll_view/single_child_scroll_view_example.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

void main() {
  final gameManager = SimpleGameManager(
    initialRoute: Pong.routeName,
    onGenerateRoute: (settings) {
      switch (settings.name) {
        case Pong.routeName:
          return Pong();
        case SingleChildScrollViewExample.routeName:
          return SingleChildScrollViewExample();
      }
    },
  );
  runApp(
    MaterialApp(
      home: GameWidget(
        game: gameManager,
      ),
    ),
  );
}

class PongManager {
  static const BALL_SPEED = 120.0;
  static const PADDLE_HEIGHT = 100.0;
  Offset ballPosition = Offset.zero;
  Offset playerPaddlePosition = Offset.zero;
  Offset pcPaddlePosition = Offset.zero;
  Offset ballVelocity = Offset.zero;
  Vector2 bounds = Vector2.all(0);
  int playerScore = 0;
  int pcScore = 0;

  void init(Vector2 bounds) {
    this.bounds = bounds;
    resetBall();
    playerPaddlePosition = Offset(15, bounds.y / 2);
    pcPaddlePosition = Offset(bounds.x - 15, bounds.y / 2);
    playerScore = 0;
    pcScore = 0;
  }

  void resetBall() {
    final random = Random();
    ballPosition = (bounds / 2).toOffset();
    ballVelocity = Offset(random.nextInt(2) * 2 - 1, random.nextInt(2) * 2 - 1);
  }

  void update(double delta) {
    if (delta > 1) delta = 1; // This prevents jumping if the game is offscreen or hanging for some unforseen reason
    updateBallPosition(delta);
    updatePaddlePosition(delta);
    updatePlayerPaddlePosition(delta);
  }

  void updateBallPosition(double delta) {
    ballPosition = ballPosition + ballVelocity * delta * BALL_SPEED;
    if (ballPosition.dx <= 20 && ballPosition.dy <= playerPaddlePosition.dy + PADDLE_HEIGHT / 2 && ballPosition.dy >= playerPaddlePosition.dy - PADDLE_HEIGHT / 2) {
      final y = (ballPosition.dy - playerPaddlePosition.dy) / (PADDLE_HEIGHT / 4);
      ballVelocity = Vector2(1, y).normalized().toOffset() * sqrt2;
    } else if (ballPosition.dx >= bounds.x - 20 && ballPosition.dy <= pcPaddlePosition.dy + PADDLE_HEIGHT / 2 && ballPosition.dy >= pcPaddlePosition.dy - PADDLE_HEIGHT / 2) {
      final y = (ballPosition.dy - pcPaddlePosition.dy) / (PADDLE_HEIGHT / 4);
      ballVelocity = Vector2(-1, y).normalized().toOffset() * sqrt2;
    }
    if (ballPosition.dx <= 10) {
      pcScore += 1;
      if (pcScore > 9) {
        init(bounds);
      }
      resetBall();
    } else if (ballPosition.dx >= bounds.x - 10) {
      playerScore += 1;
      if (playerScore > 9) {
        init(bounds);
      }
      resetBall();
    }
    if (ballPosition.dy <= 15) {
      ballVelocity = Offset(ballVelocity.dx, 1);
    } else if (ballPosition.dy >= bounds.y - 15) {
      ballVelocity = Offset(ballVelocity.dx, -1);
    }
  }

  void updatePaddlePosition(double delta) {
    final goal = ballPosition.dy;
    var velocity = 0.0;
    if (pcPaddlePosition.dy > goal + PADDLE_HEIGHT / 3) {
      velocity = -1;
    } else if (pcPaddlePosition.dy < goal - PADDLE_HEIGHT / 3) {
      velocity = 1;
    }
    pcPaddlePosition = pcPaddlePosition + Offset(0, velocity) * delta * BALL_SPEED * 0.9;
  }

  void updatePlayerPaddlePosition(double delta) {
    final goal = ballPosition.dy;
    var velocity = 0.0;
    if (playerPaddlePosition.dy > goal + 1) {
      velocity = -1;
    } else if (playerPaddlePosition.dy < goal - 1) {
      velocity = 1;
    }
    playerPaddlePosition = playerPaddlePosition + Offset(0, velocity) * delta * BALL_SPEED * 0.9;
  }
}

class Pong extends FlameWidget {
  static const routeName = 'pong';
  final manager = PongManager();

  @override
  void update(double delta) {
    super.update(delta);
    manager.update(delta);
  }

  @override
  FlameWidget build(BuildContext context) {
    manager.init(bounds);
    return FlameContainer(
      color: Colors.black,
      child: FlameStack(
        children: [
          Borders(),
          Ball(manager: manager),
          Paddle(manager: manager, isPlayer: true),
          Paddle(manager: manager, isPlayer: false),
          Score(manager: manager),
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
  final PongManager manager;
  final bool isPlayer;

  Paddle({
    required this.manager,
    required this.isPlayer,
  });

  @override
  FlameWidget build(BuildContext context) {
    return FlamePositioned.center(
      xFunction: () => isPlayer ? manager.playerPaddlePosition.dx : manager.pcPaddlePosition.dx,
      yFunction: () => isPlayer ? manager.playerPaddlePosition.dy : manager.pcPaddlePosition.dy,
      width: 10,
      height: PongManager.PADDLE_HEIGHT,
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
  final PongManager manager;

  Ball({
    required this.manager,
  });

  @override
  FlameWidget build(BuildContext context) {
    return FlameCanvas(
      draw: (canvas, bounds, context) {
        final paint = Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.white;
        canvas.drawRect(
          Rect.fromCenter(
            center: manager.ballPosition,
            width: 10,
            height: 10,
          ),
          paint,
        );
      },
    );
  }
}

class Score extends FlameWidget {
  PongManager manager;

  Score({
    required this.manager,
  });

  @override
  FlameWidget build(BuildContext context) {
    return FlameCanvas(
      draw: (canvas, bounds, context) {
        canvas.save();
        canvas.translate(bounds.x / 2 - HelperExample.SCORE_HEIGHT, HelperExample.SCORE_HEIGHT / 2);
        HelperExample.drawScore(canvas, manager.playerScore);
        canvas.restore();
        canvas.save();
        canvas.translate(bounds.x / 2 + HelperExample.SCORE_HEIGHT / 2, HelperExample.SCORE_HEIGHT / 2);
        HelperExample.drawScore(canvas, manager.pcScore);
        canvas.restore();
      },
    );
  }
}

import 'package:flame/components.dart';

class FlameScrollController {
  var _position = Vector2.zero();

  final listeners = <FlameScrollControllerListener>[];

  Vector2 get lastPosition => _position;

  void addListener(FlameScrollControllerListener listener) =>
      listeners.add(listener);

  void removeListener(FlameScrollControllerListener listener) =>
      listeners.remove(listener);

  void updatePosition(Vector2 position) {
    _position = position;
  }

  void jumpTo(Vector2 position) {
    _position = position;
    listeners.forEach((listener) => listener.jumpTo(position));
  }
}

mixin FlameScrollControllerListener {
  void jumpTo(Vector2 position);
}

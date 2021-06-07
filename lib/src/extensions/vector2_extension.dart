import 'package:flame/components.dart';

extension Vector2Extension on Vector2 {
  bool operator <=(dynamic other) {
    if (other is Vector2) {
      return x <= other.x || y <= other.y;
    } else if (other is double || other is int) {
      return x <= other || y <= other;
    }
    throw Exception('Cannot compare vector2 to unknown type, only int, double and Vector2 are accepted');
  }

  bool operator <(dynamic other) {
    if (other is Vector2) {
      return x < other.x || y < other.y;
    } else if (other is double || other is int) {
      return x < other || y < other;
    }
    throw Exception('Cannot compare vector2 to unknown type, only int, double and Vector2 are accepted');
  }

  bool operator <<(dynamic other) {
    if (other is Vector2) {
      return x < other.x && y < other.y;
    } else if (other is double || other is int) {
      return x < other && y < other;
    }
    throw Exception('Cannot compare vector2 to unknown type, only int, double and Vector2 are accepted');
  }

  bool operator >(dynamic other) {
    if (other is Vector2) {
      return x > other.x || y > other.y;
    } else if (other is double || other is int) {
      return x > other || y > other;
    }
    throw Exception('Cannot compare vector2 to unknown type, only int, double and Vector2 are accepted');
  }

  bool operator >=(dynamic other) {
    if (other is Vector2) {
      return x >= other.x || y >= other.y;
    } else if (other is double || other is int) {
      return x >= other || y >= other;
    }
    throw Exception('Cannot compare vector2 to unknown type, only int, double and Vector2 are accepted');
  }

  bool operator >>(dynamic other) {
    if (other is Vector2) {
      return x > other.x && y > other.y;
    } else if (other is double || other is int) {
      return x > other && y > other;
    }
    throw Exception('Cannot compare vector2 to unknown type, only int, double and Vector2 are accepted');
  }

  bool equals(dynamic other) {
    if (other is Vector2) {
      return x == other.x && y == other.y;
    } else if (other is double || other is int) {
      return x == other && y == other;
    }
    throw Exception('Cannot compare vector2 to unknown type, only int, double and Vector2 are accepted');
  }

  void clampMax(Vector2 max) {
    x.clamp(0, max.x);
    y.clamp(0, max.y);
  }
}

import 'package:flame/components.dart';
import 'package:flutter_flame_architecture/src/game/game_manager.dart';

class FlameSpriteCollector {
  final _sprites = <String, Sprite?>{};

  GameManager? _gameManager;

  static final FlameSpriteCollector _instance = FlameSpriteCollector._();

  static FlameSpriteCollector get instance => _instance;

  FlameSpriteCollector._();

  void setGameManager(GameManager gameManager) {
    _gameManager = gameManager;
    _sprites.forEach((fileName, sprite) => addSprite(fileName));
  }

  Future<void> addSprite(String fileName) async {
    if ((_sprites.containsKey(fileName) && _sprites[fileName] != null) ||
        _gameManager == null) return;
    final image = await _gameManager!.images.load(fileName);
    if (_sprites.containsKey(fileName) && _sprites[fileName] != null)
      return; // If aleady registered in the mean time
    _sprites[fileName] = Sprite(image);
  }

  Future<Sprite> getSprite(String fileName) async {
    if (_sprites.containsKey(fileName) && _sprites[fileName] != null)
      return _sprites[fileName]!;
    await addSprite(fileName);
    return _sprites[fileName]!;
  }

  Sprite? getSpriteSync(String fileName) => _sprites[fileName];
}

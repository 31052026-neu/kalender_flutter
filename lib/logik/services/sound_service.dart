import 'package:audioplayers/audioplayers.dart';

class SoundService {
  final AudioPlayer _ambientPlayer = AudioPlayer();

  Future<void> startAmbient() async {
    _ambientPlayer.audioCache.prefix = '';

    await _ambientPlayer.setVolume(0.5);

    await _ambientPlayer.setReleaseMode(ReleaseMode.loop);

    await _ambientPlayer.play(AssetSource('lib/sounds/ambient.wav'));
  }
}

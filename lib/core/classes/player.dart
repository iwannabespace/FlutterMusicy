import 'package:just_audio/just_audio.dart';

class GlobalMusicPlayer {
  final AudioPlayer player = AudioPlayer();
  String file = "";

  Future<void> setFile({required String file}) async {
    await player.setFilePath(file);
    this.file = file;
  }

  Future<void> play() async {
    if (!player.playing) {
      await player.play();
    }
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> stop() async {
    await player.stop();
  }
}

import 'package:hive/hive.dart';

import '../../domain/entities/music.dart';

abstract class MusicLocalDataSource {
  Future<void> putMusic({required Music music});
  Future<Music?> getMusic({required String id});
  Future<List<Music>> getAllMusics();
  Future<bool> isMusicDownloaded({required String id});
}

class MusicLocalDataSourceImpl implements MusicLocalDataSource {
  @override
  Future<void> putMusic({required Music music}) async {
    final box = await getMusicBox();
    await box.put(music.id, music);
  }

  @override
  Future<Music?> getMusic({required String id}) async {
    final box = await getMusicBox();
    return box.get(id);
  }

  @override
  Future<List<Music>> getAllMusics() async {
    final box = await getMusicBox();
    return box.values.toList();
  }

  @override
  Future<bool> isMusicDownloaded({required String id}) async {
    final box = await getMusicBox();

    for (final music in box.values) {
      if (music.id == id) {
        return true;
      }
    }

    return false;
  }

  Future<Box<Music>> getMusicBox() async {
    if (Hive.isBoxOpen('musics')) {
      return Hive.box<Music>('musics');
    } else {
      return await Hive.openBox<Music>('musics');
    }
  }
}

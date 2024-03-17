import 'package:hive/hive.dart';

import '../../domain/entities/music.dart';

abstract class MusicLocalDataSource {
  Future<void> putMusic({required Music music});
  Future<Music?> getMusic({required String id});
  Future<List<Music>> getAllMusics();
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

  Future<Box<Music>> getMusicBox() async {
    if (Hive.isBoxOpen('musics')) {
      return Hive.box<Music>('musics');
    } else {
      return await Hive.openBox<Music>('musics');
    }
  }
}

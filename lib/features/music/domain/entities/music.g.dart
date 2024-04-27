// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MusicAdapter extends TypeAdapter<Music> {
  @override
  final int typeId = 0;

  @override
  Music read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Music(
      id: fields[0] as String,
      name: fields[1] as String,
      author: fields[2] as String,
      defaultThumbnailUrl: fields[3] as String,
      mediumThumbnailUrl: fields[4] as String,
      highThumbnailUrl: fields[5] as String,
      path: fields[6] as String,
      liked: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Music obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.defaultThumbnailUrl)
      ..writeByte(4)
      ..write(obj.mediumThumbnailUrl)
      ..writeByte(5)
      ..write(obj.highThumbnailUrl)
      ..writeByte(6)
      ..write(obj.path)
      ..writeByte(7)
      ..write(obj.liked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

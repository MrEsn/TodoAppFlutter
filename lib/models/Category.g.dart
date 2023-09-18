// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryNaderAdapter extends TypeAdapter<CategoryNader> {
  @override
  final int typeId = 1;

  @override
  CategoryNader read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryNader(
      title: fields[1] as String,
      note: fields[2] as String,
      id: fields[3] as int,
      level: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryNader obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.level);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryNaderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

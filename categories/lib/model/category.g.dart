// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 1;

  @override
  Category read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Category.music;
      case 1:
        return Category.films;
      case 2:
        return Category.games;
      case 3:
        return Category.books;
      case 4:
        return Category.common;
      default:
        return Category.common;
    }
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    switch (obj) {
      case Category.music:
        writer.writeByte(0);
        break;
      case Category.films:
        writer.writeByte(1);
        break;
      case Category.games:
        writer.writeByte(2);
        break;
      case Category.books:
        writer.writeByte(3);
        break;
      case Category.common:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

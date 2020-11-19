// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item_cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductItemCartAdapter extends TypeAdapter<ProductItemCart> {
  @override
  final int typeId = 1;

  @override
  ProductItemCart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductItemCart(
      productTitle: fields[0] as String,
      productImage: fields[1] as String,
      productAmount: fields[2] as int,
      productPrice: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ProductItemCart obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.productTitle)
      ..writeByte(1)
      ..write(obj.productImage)
      ..writeByte(2)
      ..write(obj.productAmount)
      ..writeByte(3)
      ..write(obj.productPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductItemCartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

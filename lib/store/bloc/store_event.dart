part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class LoadCartEvent extends StoreEvent {}

class AddToCartEvent extends StoreEvent {
  final Product product;

  AddToCartEvent({@required this.product});
  @override
  List<Object> get props => [product];
}

class UpdateCartEvent extends StoreEvent {
  final Product product;
  final int productIndex;

  UpdateCartEvent({@required this.product, this.productIndex});
  @override
  List<Object> get props => [product, productIndex];
}

class RemoveFromCartEvent extends StoreEvent {
  final int productIndex;

  RemoveFromCartEvent({@required this.productIndex});
  @override
  List<Object> get props => [productIndex];
}

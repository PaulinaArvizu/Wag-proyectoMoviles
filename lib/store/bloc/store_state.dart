part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}

class CartLoadedState extends StoreState {
  final List<ProductItemCart> productsList;

  CartLoadedState({@required this.productsList});
  @override
  List<Object> get props => [productsList];
}

class ProductAddedState extends StoreState {}

class ProductRemovedState extends StoreState {}

class CartUpdatedState extends StoreState {}

class EmptyCartState extends StoreState {}

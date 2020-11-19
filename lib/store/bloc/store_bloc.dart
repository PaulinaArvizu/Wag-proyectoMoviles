import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wag_proyecto_moviles/store/product.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  //referencia a la box previamente abierta (en el main)
  Box _cartBox = Hive.box("Cart");
  List<dynamic> _cartElements = List();

  StoreBloc() : super(StoreInitial());

  @override
  Stream<StoreState> mapEventToState(
    StoreEvent event,
  ) async* {
    if (event is LoadCartEvent) {
      if (_cartBox.isNotEmpty)
        _cartElements = List<Product>.from(_cartBox.get("products"));
      yield CartLoadedState(productsList: _cartElements);
    } else if (event is AddToCartEvent) {
      // guardar en la local DB
      if (_cartBox.isNotEmpty) _cartElements = _cartBox.get("products");
      _cartElements.add(event.product);
      _cartBox.put("products", _cartElements);
      yield ProductAddedState();
    } else if (event is RemoveFromCartEvent) {
      _cartElements.removeAt(event.productIndex);
      _cartBox.put("products", _cartElements);
      yield ProductRemovedState();
    } else if (event is UpdateCartEvent) {
      _cartElements[event.productIndex] = event.product;
      _cartBox.put("products", _cartElements);
      yield ProductRemovedState();
    }
  }
}

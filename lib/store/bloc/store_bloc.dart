import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wag_proyecto_moviles/models/product_item.dart';
import 'package:wag_proyecto_moviles/models/product_item_cart.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  List<ProductItem> _productsList;

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
        _cartElements = List<ProductItemCart>.from(_cartBox.get("products"));
      yield CartLoadedState(productsList: _cartElements);
    } else if (event is AddToCartEvent) {
      // guardar en la local DB
      if (_cartBox.isNotEmpty) {
        _cartElements = _cartBox.get("products");
        int index = _cartElements
            .indexWhere((e) => e.productImage == event.product.productImage);
        if (index != -1) {
          _cartElements[index].productAmount++;
          _cartBox.put("products", _cartElements);
          yield CartUpdatedState();
          yield StandbyState();
          return;
        }
      }
      _cartElements.add(event.product);
      _cartBox.put("products", _cartElements);
      yield ProductAddedState();
    } else if (event is RemoveFromCartEvent) {
      _cartElements.removeAt(event.productIndex);
      _cartBox.put("products", _cartElements);
      yield ProductRemovedState();
      yield StandbyState();
    } else if (event is UpdateCartEvent) {
      _cartElements[event.productIndex] = event.product;
      _cartBox.put("products", _cartElements);
      yield CartUpdatedState();
      yield StandbyState();
    } else if (event is PaymentSuccessEvent) {
      _cartElements.clear();
      _cartBox.put("products", _cartElements);
      yield StandbyState();
    } else if (event is LeerProductosEvent) {
      try {
        await _getAllProducts();
        yield StoreSuccessState(productsList: _productsList);
      } catch (e) {
        yield StoreErrorState(errorMessage: e.toString());
      }
    }
  }

  Future _getAllProducts() async {
    // recuperar lista de docs guardados en Cloud firestore
    // mapear a objeto de dart (ProductItem)
    // agregar cada ojeto a una lista
    var misPosts = await FirebaseFirestore.instance
        .collection("products")
        .orderBy("title")
        .get();
    _productsList = misPosts.docs
        .map(
          (product) => ProductItem(
            productTitle: product["title"],
            productDescription: product["description"],
            productImage: product["imageUrl"],
            productPrice: double.parse(product["price"]),
          ),
        )
        .toList();
  }
}

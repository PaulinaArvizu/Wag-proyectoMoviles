import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/models/post.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Post> _postsList;
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is LeerPostsEvent) {
      try {
        await _getAllPosts();
        yield HomeSuccessState();
      } catch (e) {
        yield HomeErrorState(errorMessage: "Couldn't get posts: \n$e");
      }
    }
  }

  Future _getAllPosts() async {
    // recuperar lista de docs guardados en Cloud firestore
    // mapear a objeto de dart (Post)
    // agregar cada ojeto a una lista
    var misPosts = await FirebaseFirestore.instance.collection("posts").get();
    _postsList = misPosts.docs
        .map(
          (element) => Post(
            name: element["name"],
            size: element["size"],
            imageUrl: element["imageUrl"],
            age: element["age"],
            description: element["description"],
            authorID: element["authorID"],
            authorUsername: element["authorUsername"],
            authorImageUrl: element["authorImageUrl"],
            date: element["date"],
            contactInfo: element["contactInfo"],
          ),
        )
        .toList();
    print(_postsList);
  }
}

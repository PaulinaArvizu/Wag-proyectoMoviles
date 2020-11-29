import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wag_proyecto_moviles/models/post.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  List<Post> _postsList;
  FirebaseAuth _auth = FirebaseAuth.instance;

  ProfileBloc() : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LeerPostsEvent) {
      try {
        await _getAllUserPosts();
        yield ProfileSuccessState(postsList: _postsList);
      } catch (e) {
        yield EditPostErrorState(errorMessage: "Couldn't get posts: \n$e");
      }
    } else if (event is EditPostEvent) {
      try {
        String imageUrl = event.imageUrl;
        await _savePost(
          event.name,
          event.size,
          event.age,
          event.description,
          event.contactInfo,
          event.date,
          imageUrl,
        );
        yield EditPostUpdatedState();
      } catch (e) {
        yield EditPostErrorState(errorMessage: "Error at saving post: $e");
      }
    }
  }

  Future _getAllUserPosts() async {
    // recuperar lista de docs guardados en Cloud firestore
    // mapear a objeto de dart (Post)
    // agregar cada ojeto a una lista
    var misPosts = await FirebaseFirestore.instance
        .collection("posts")
        .where("authorID", isEqualTo: _auth.currentUser.uid)
        .get();
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

  //Guardar elemento en CloudFirestore
  Future<void> _savePost(
    String name,
    String size,
    String age,
    String description,
    String contactInfo,
    String date,
    String imageUrl,
  ) async {
    var doc = await FirebaseFirestore.instance
        .collection('posts')
        .where('imageUrl', isEqualTo: imageUrl)
        .get();
    if (doc.docs.length > 0) {
      var docID = doc.docs[0].id;
      // Crea un doc en la collection de posts
      await FirebaseFirestore.instance.collection("posts").doc(docID).set({
        "name": name,
        "size": size,
        "imageUrl": imageUrl,
        "age": age,
        "description": description,
        "authorID": _auth.currentUser.uid,
        "authorUsername": _auth.currentUser.displayName,
        "authorImageUrl": _auth.currentUser.photoURL,
        "date": date,
        "contactInfo": contactInfo
      });
    } else {
      print(imageUrl);
    }
  }
}

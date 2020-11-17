import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:wag_proyecto_moviles/models/post.dart';

part 'new_post_event.dart';
part 'new_post_state.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  List<Post> _postsList;
  // List<Post> get _listaPosts => _postsList;
  File _chosenImage;

  NewPostBloc() : super(NewPostInitial());

  @override
  Stream<NewPostState> mapEventToState(
    NewPostEvent event,
  ) async* {
    if (event is LeerPostsEvent) {
      try {
        await _getAllPosts();
        yield NewPostSuccessState();
      } catch (e) {
        yield NewPostErrorState(errorMessage: "Couldn't get posts: \n$e");
      }
    } else if (event is CargarImagenEvent) {
      _chosenImage = await _chooseImage(event.takePictureFromCamera);
      if (_chosenImage != null) {
        yield ImagenCargadaState(imagen: _chosenImage);
      }
    } else if (event is CreateNewPostEvent) {
      try {
        String imageUrl = await _uploadPicture(_chosenImage);
        await _savePost(
          event.name,
          event.size,
          event.age,
          event.description,
          event.authorID,
          imageUrl,
        );
        yield NewPostCreatedState();
      } catch (e) {
        yield NewPostErrorState(errorMessage: "Error at saving post: $e");
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
            date: element["date"],
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
    String authorID,
    String imageUrl,
  ) async {
    // Crea un doc en la collection de posts
    await FirebaseFirestore.instance.collection("posts").doc().set({
      "name": name,
      "size": size,
      "imageUrl": imageUrl,
      "age": age,
      "description": description,
      "authorID": authorID,
      "date": DateTime.now().toString(),
    });
  }

  //subir imagen al bucket de almacenamiento
  Future<String> _uploadPicture(File image) async {
    String imagePath = image.path;
    // referencia al storage de firebase
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("posts/${Path.basename(imagePath)}");

    // subir el archivo a firebase
    StorageUploadTask uploadTask = reference.putFile(image);
    await uploadTask.onComplete;

    // recuperar la url del archivo que acabamos de subir
    dynamic imageURL = await reference.getDownloadURL();
    return imageURL;
  }

  Future<File> _chooseImage(bool fromCamera) async {
    final picker = ImagePicker();
    final PickedFile chooseImage = await picker.getImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    return File(chooseImage.path);
  }
}
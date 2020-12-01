import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wag_proyecto_moviles/auth/user_auth_provider.dart';
import 'package:wag_proyecto_moviles/models/post.dart';
import 'package:path/path.dart' as Path;

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  List<Post> _postsList;
  FirebaseAuth _auth = FirebaseAuth.instance;
  File _chosenImage;

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
    } else if (event is DeletePostEvent) {
      try {
        String imageUrl = event.imageUrl;
        await _deletePost(imageUrl);
        yield PostDeletedState();
      } catch (e) {
        yield EditPostErrorState(errorMessage: "Error at deleting post: $e");
      }
    } else if (event is UpdateProfileEvent) {
      try {
        await _updateUser(event.imageChanged, event.nameChanged, event.name);
      } catch (umu) {
        yield EditPostErrorState(
            errorMessage: 'Error at updating profile: $umu');
      }
    } else if (event is CargarImagenEvent) {
      try {
        _chosenImage = await _chooseImage(event.takePictureFromCamera);

        yield ImagenCargadaState(imagen: _chosenImage);
      } catch (umu) {
        yield EditPostErrorState(errorMessage: 'Error at loading image: $umu');
      }
    } else if (event is ProfileLogOutEvent) {
      UserAuthProvider _authProvider = UserAuthProvider();
      try {
        _authProvider.signOutGoogle();
      } catch (e) {
        print(e);
      }
      try {
        _authProvider.signOutFirebase();
      } catch (e) {
        print(e);
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

  Future<void> _deleteFromStorage(String imageUrl) async {
    //Borrar imagen del storage de firebase\
    String baseUrl =
        'https://firebasestorage.googleapis.com/v0/b/wag-proyecto-moviles.appspot.com/o/posts%2F';
    String imagePath = imageUrl.replaceAll(baseUrl, '').split('?')[0];
    StorageReference reference =
        FirebaseStorage.instance.ref().child('posts/$imagePath');
    await reference.delete();
  }

  Future<void> _deletePost(String imageUrl) async {
    //Borrar documento
    var doc = await FirebaseFirestore.instance
        .collection('posts')
        .where('imageUrl', isEqualTo: imageUrl)
        .get();
    if (doc.docs.length > 0) {
      var docID = doc.docs[0].id;
      // Crea un doc en la collection de posts
      await FirebaseFirestore.instance.collection("posts").doc(docID).delete();
      await _deleteFromStorage(imageUrl);
    } else {
      print(imageUrl);
    }
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
    final PickedFile chosenImage = await picker.getImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    if (chosenImage != null)
      return File(chosenImage.path);
    else
      return null;
  }

  Future<void> _updateUser(
    bool imageChanged,
    bool nameChanged,
    String name,
  ) async {
    String imageUrl;
    if (imageChanged) {
      imageUrl = await _uploadPicture(_chosenImage);
      if (_auth.currentUser.photoURL.contains('firebasestorage')) {
        await _deleteFromStorage(_auth.currentUser.photoURL);
      }
    } // :'v
    await _auth.currentUser.updateProfile(
      displayName: nameChanged ? name : _auth.currentUser.displayName,
      photoURL: imageChanged ? imageUrl : _auth.currentUser.photoURL,
    );
    // actualizar datos del autor en todos los posts :D
    var doc = await FirebaseFirestore.instance
        .collection('posts')
        .where('authorID', isEqualTo: _auth.currentUser.uid)
        .get();
    var documents = doc.docs;
    for (var d in documents) {
      await FirebaseFirestore.instance.collection('posts').doc(d.id).update({
        "authorUsername": _auth.currentUser.displayName,
        "authorImageUrl": _auth.currentUser.photoURL
      });
    }
    print(documents);
  }
}

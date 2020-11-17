import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wag_proyecto_moviles/new/bloc/new_post_bloc.dart';

class NewPost extends StatefulWidget {
  NewPost({Key key}) : super(key: key);

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _sizeController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  File _chosenImage;
  NewPostBloc _bloc;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("New post"),
      ),
      body: BlocProvider(
        create: (context) {
          _bloc = NewPostBloc();
          return _bloc..add(LeerPostsEvent());
        },
        child: BlocConsumer<NewPostBloc, NewPostState>(
          listener: (context, state) {
            if (state is NewPostErrorState) {
              //DONE: dialogo o snackbar de error
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text("Se presentó un error"),
                ),
              );
            } else if (state is NewPostCreatedState) {
              //DONE: dialogo o snackbar de success
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text("Success: post creado"),
                ),
              );
            } else if (state is ImagenCargadaState) {
              _chosenImage = state.imagen;
            }
          },
          builder: (context, state) {
            if (state is NewPostCreatedState) {
              _clearForm();
              return _newPostForm();
            }
            return _newPostForm();
          },
        ),
      ),
    );
  }

  Widget _newPostForm() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _chosenImage != null
                ? Image.file(
                    _chosenImage,
                    width: 150,
                    height: 150,
                  )
                : Container(
                    height: 150,
                    width: 150,
                    child: Placeholder(
                      fallbackHeight: 150,
                      fallbackWidth: 150,
                    ),
                  ),
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: () {
                    _bloc.add(CargarImagenEvent(takePictureFromCamera: true));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add_photo_alternate_outlined),
                  onPressed: () {
                    _bloc.add(CargarImagenEvent(takePictureFromCamera: false));
                  },
                ),
              ],
            ),
            SizedBox(height: 48),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _sizeController,
              decoration: InputDecoration(
                hintText: "Size",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                hintText: "Age (aprox.)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 24),
            RaisedButton(
              child: Text("Post"),
              onPressed: () {
                print("Enter onPressed");
                _bloc.add(
                  CreateNewPostEvent(
                    name: _nameController.text,
                    size: _sizeController.text,
                    age: _ageController.text,
                    description: _descriptionController.text,
                    authorID: "123",
                  ),
                );
                print("Exit onPressed");
              },
            ),
          ],
        ),
      ),
    );
  }

  _clearForm() {
    //borrar el formulario
    _nameController.clear();
    _sizeController.clear();
    _ageController.clear();
    _chosenImage = null;
  }
}

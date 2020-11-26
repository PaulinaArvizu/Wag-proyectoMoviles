import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wag_proyecto_moviles/new/bloc/new_post_bloc.dart';

import '../colors.dart';

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
  TextEditingController _contactInfoController = TextEditingController();

  File _chosenImage;
  NewPostBloc _bloc;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        title: Text(
          "New Post",
          style: TextStyle(
            fontFamily: 'Sofia Pro Bold',
            fontSize: 24,
          ),
        ),
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
              _scaffoldKey.currentState
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("An error occurred"),
                    action: SnackBarAction(
                      label: "See more",
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text(state.errorMessage ?? ''),
                            actions: [
                              FlatButton(
                                onPressed: () => Navigator.of(_).pop(),
                                child: Text(
                                  "ACEPTAR",
                                  style: TextStyle(
                                    fontFamily: 'Poppins SemiBold',
                                    color: primary,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
            } else if (state is NewPostCreatedState) {
              //DONE: dialogo o snackbar de success
              _scaffoldKey.currentState
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Success: post created"),
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
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffE2E2E2)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Name",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(fontFamily: 'Poppins Regular'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _sizeController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffE2E2E2)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Size",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(fontFamily: 'Poppins Regular'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffE2E2E2)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Age (aprox.)",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(fontFamily: 'Poppins Regular'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffE2E2E2)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Description",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(fontFamily: 'Poppins Regular'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _contactInfoController,
              maxLines: 5,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffE2E2E2)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Contact Information",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(fontFamily: 'Poppins Regular'),
            ),
            SizedBox(height: 24),
            FlatButton(
              minWidth: 150,
              padding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: primary)),
              onPressed: () {
                _bloc.add(
                  CreateNewPostEvent(
                    name: _nameController.text,
                    size: _sizeController.text,
                    age: _ageController.text,
                    description: _descriptionController.text,
                    contactInfo: _contactInfoController.text,
                  ),
                );
              },
              color: primary,
              textColor: Colors.white,
              child: Text(
                "POST",
                style: TextStyle(
                  fontFamily: 'Poppins SemiBold',
                  fontSize: 16,
                ),
              ),
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

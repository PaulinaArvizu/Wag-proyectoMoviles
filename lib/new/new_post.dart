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

  bool _nameLengthError = false;
  bool _sizeLengthError = false;
  bool _ageLengthError = false;

  bool _sizeEmptyError = true;
  bool _descriptionEmptyError = true;
  bool _contactEmptyError = true;

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
        actions: [
          FlatButton(
            textColor: Colors.white,
            onPressed: _clearForm,
            child: Text("Clear"),
          ),
        ],
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
                                  "OK",
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
            SizedBox(height: 20),
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
            SizedBox(height: 20),
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
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                fillColor: _nameLengthError ? Colors.red[100] : Colors.white,
                filled: true,
                hintText: "Name",
                hintStyle: TextStyle(color: Colors.grey),
                errorText: _nameLengthError
                    ? "Name must be 20 characters or less"
                    : null,
              ),
              style: TextStyle(fontFamily: 'Poppins Regular'),
              onChanged: (value) {
                setState(() {
                  _nameLengthError = value.length > 20;
                });
              },
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
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                fillColor: (_sizeEmptyError || _sizeLengthError)
                    ? Colors.red[100]
                    : Colors.white,
                focusColor: (_sizeEmptyError || _sizeLengthError)
                    ? Colors.red[100]
                    : Colors.white,
                filled: true,
                hintText: "Size *",
                errorText: _sizeEmptyError
                    ? "Size cannot be empty"
                    : _sizeLengthError
                        ? "Size must be 20 characters or less"
                        : null,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(fontFamily: 'Poppins Regular'),
              onChanged: (value) {
                setState(() {
                  _sizeEmptyError = value.isEmpty;
                  _sizeLengthError = value.length > 20;
                });
              },
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
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                fillColor: _ageLengthError ? Colors.red[100] : Colors.white,
                filled: true,
                hintText: "Age (aprox.)",
                errorText: _ageLengthError
                    ? "Age must be 20 characters or less"
                    : null,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(fontFamily: 'Poppins Regular'),
              onChanged: (value) {
                setState(() {
                  _ageLengthError = value.length > 20;
                });
              },
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
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                fillColor:
                    _descriptionEmptyError ? Colors.red[100] : Colors.white,
                filled: true,
                hintText: "Description & location *",
                errorText: _descriptionEmptyError
                    ? "Description & location cannot be empty"
                    : null,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(fontFamily: 'Poppins Regular'),
              onChanged: (value) {
                setState(() {
                  _descriptionEmptyError = value.isEmpty;
                });
              },
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
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                fillColor: _contactEmptyError ? Colors.red[100] : Colors.white,
                filled: true,
                hintText: "Contact information *",
                errorText: _contactEmptyError
                    ? "Contact information cannot be empty"
                    : null,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(fontFamily: 'Poppins Regular'),
              onChanged: (value) {
                setState(() {
                  _contactEmptyError = value.isEmpty;
                });
              },
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "(*) Required fields",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 24),
            FlatButton(
              minWidth: 150,
              padding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: primary)),
              onPressed: () {
                if (_nameLengthError || _sizeLengthError || _ageLengthError) {
                  _scaffoldKey.currentState
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          "Name, size and age fields must be 20 characters or less",
                        ),
                      ),
                    );
                  return;
                }
                String missingFields = _missingFields();
                if (missingFields.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Image.asset(
                              'assets/images/EmptyCart.png',
                              height: 35,
                            ),
                            SizedBox(width: 10),
                            Text("Wait!"),
                          ],
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Please fill the required fields"),
                            Text(missingFields),
                          ],
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () => Navigator.of(_).pop(),
                            child: Text(
                              "OK",
                              style: TextStyle(
                                fontFamily: 'Poppins SemiBold',
                                color: primary,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }
                // print("holis");
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
    setState(() {
      //borrar el formulario
      _nameController.clear();
      _sizeController.clear();
      _ageController.clear();
      _descriptionController.clear();
      _contactInfoController.clear();
      _chosenImage = null;

      _sizeEmptyError = true;
      _descriptionEmptyError = true;
      _contactEmptyError = true;
    });
  }

  String _missingFields() {
    String missingFields = "";
    //verificar que no haya campos vacios
    if (_chosenImage == null) {
      missingFields += "- Image\n";
    }

    if (_sizeController.text.isEmpty) {
      missingFields += "- Size\n";
    }

    if (_descriptionController.text.isEmpty) {
      missingFields += "- Description & location\n";
    }

    if (_contactInfoController.text.isEmpty) {
      missingFields += "- Contact Information\n";
    }

    return missingFields;
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wag_proyecto_moviles/models/post.dart';
import 'package:wag_proyecto_moviles/profile/bloc/profile_bloc.dart';

import '../colors.dart';

class EditPost extends StatefulWidget {
  final Post post;
  EditPost({Key key, @required this.post}) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _sizeController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _contactInfoController = TextEditingController();

  File _chosenImage;
  ProfileBloc _bloc;
  String _currentImage;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _nameController.text = widget.post.name;
    _sizeController.text = widget.post.size;
    _ageController.text = widget.post.age;
    _descriptionController.text = widget.post.description;
    _contactInfoController.text = widget.post.contactInfo;
    _currentImage = widget.post.imageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        title: Text(
          "Edit Post",
          style: TextStyle(
            fontFamily: 'Sofia Pro Bold',
            fontSize: 24,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) {
          _bloc = ProfileBloc();
          return _bloc..add(LeerPostsEvent());
        },
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is EditPostErrorState) {
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
                                  "OK!",
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
            } else if (state is PostDeletedState) {
              Navigator.of(context).pop('Delete');
            }
          },
          builder: (context, state) {
            if (state is EditPostUpdatedState) {
              _clearForm();
              Navigator.of(context).pop('Save');
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
                : Image.network(
                    _currentImage,
                    width: 150,
                    height: 150,
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
                hintText: "Size *",
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
                hintText: "Description & location *",
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
                hintText: "Contact Information *",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(fontFamily: 'Poppins Regular'),
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
            Row(
              children: [
                FlatButton(
                  minWidth: 120,
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey)),
                  onPressed: () {
                    Navigator.of(context).pop('Cancel');
                  },
                  color: Colors.grey,
                  textColor: Colors.white,
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontFamily: 'Poppins SemiBold',
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  minWidth: 120,
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.red)),
                  onPressed: () {
                    _openDialog();
                  },
                  color: Colors.red[800],
                  textColor: Colors.white,
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontFamily: 'Poppins SemiBold',
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  minWidth: 120,
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: primary)),
                  onPressed: () {
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
                    } else {
                      _bloc.add(
                        EditPostEvent(
                          name: _nameController.text,
                          size: _sizeController.text,
                          age: _ageController.text,
                          description: _descriptionController.text,
                          contactInfo: _contactInfoController.text,
                          date: widget.post.date,
                          imageUrl: widget.post.imageUrl,
                        ),
                      );
                    }
                  },
                  color: primary,
                  textColor: Colors.white,
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontFamily: 'Poppins SemiBold',
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
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

  String _missingFields() {
    String missingFields = "";
    //verificar que no haya campos vacios
    if (_chosenImage == null && _currentImage == null) {
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

  _openDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(
                'assets/images/EmptyCart.png',
                height: 40,
              ),
              SizedBox(width: 10),
              Text("Warning!"),
            ],
          ),
          content: Text('You are about to delete this post. Is that correct?'),
          actions: [
            Row(
              children: [
                FlatButton(
                  onPressed: () => Navigator.of(_).pop(),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontFamily: 'Poppins SemiBold',
                      color: primary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  onPressed: () {
                    _bloc.add(DeletePostEvent(imageUrl: _currentImage));
                    Navigator.of(_).pop();
                  },
                  child: Text(
                    "Yes! Delete",
                    style: TextStyle(
                      fontFamily: 'Poppins SemiBold',
                      color: primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

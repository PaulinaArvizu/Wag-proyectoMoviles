import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wag_proyecto_moviles/profile/bloc/profile_bloc.dart';

import '../colors.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  File chosenImage;
  FirebaseAuth _auth;
  User _currentUser;
  ProfileBloc _bloc;

  @override
  void initState() {
    _auth = FirebaseAuth.instance;
    _currentUser = _auth.currentUser;
    _nameController.text = _currentUser.displayName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        //TODO: preguntar sobre padding extraño en appbar
        appBar: AppBar(
          backgroundColor: primary,
          centerTitle: true,
          title: Text(
            "Edit profile",
            style: TextStyle(
              fontFamily: 'Sofia Pro Bold',
              // fontSize: 24,
            ),
          ),
        ),
        body: BlocProvider(
          create: (context) {
            _bloc = ProfileBloc();
            return _bloc..add(LeerPostsEvent());
          },
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ProfileSuccessState) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            _currentUser.photoURL == null
                                ? AssetImage("assets/images/userAvatar.png")
                                : chosenImage == null
                                    ? Image.network(_currentUser.photoURL)
                                    : Image.file(
                                        chosenImage,
                                        width: 150,
                                        height: 150,
                                      ),
                            SizedBox(height: 48),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.add_a_photo),
                                  onPressed: () {
                                    _bloc.add(CargarImagenEvent(
                                        takePictureFromCamera: true));
                                  },
                                ),
                                IconButton(
                                  icon:
                                      Icon(Icons.add_photo_alternate_outlined),
                                  onPressed: () {
                                    _bloc.add(CargarImagenEvent(
                                        takePictureFromCamera: false));
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 48),
                            TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffE2E2E2)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              style: TextStyle(fontFamily: 'Poppins Regular'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Row(
                        children: <Widget>[
                          FlatButton(
                            minWidth: 150,
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.grey)),
                            onPressed: () {},
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
                            width: 20,
                          ),
                          FlatButton(
                            minWidth: 150,
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: primary)),
                            onPressed: () {},
                            color: primary,
                            textColor: Colors.white,
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                fontFamily: 'Poppins SemiBold',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Center(
                child: Text('Error loading page'),
              );
            },
          ),
        ));
  }
}

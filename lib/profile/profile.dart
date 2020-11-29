import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/models/post.dart';
import 'package:wag_proyecto_moviles/profile/bloc/profile_bloc.dart';

import 'editPost.dart';
import 'editProfile.dart';

void main() => runApp(Profile());

class Profile extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth _auth;
  User _currentUser;
  ProfileBloc _bloc;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Post> _postsList = List();
  double _blockSizeHorizontal = 0;
  double _blockSizeVertical = 0;

  double textMultiplier;
  double imageSizeMultiplier;
  double heightMultiplier;
  double widthMultiplier;

  bool isPortrait = true;
  bool isMobilePortrait = false;
  @override
  void initState() {
    _auth = FirebaseAuth.instance;
    _currentUser = _auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;

    textMultiplier = _blockSizeVertical;
    imageSizeMultiplier = _blockSizeHorizontal;
    heightMultiplier = _blockSizeVertical;
    widthMultiplier = _blockSizeHorizontal;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) {
            _bloc = ProfileBloc();
            return _bloc..add(LeerPostsEvent());
          },
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ProfileSuccessState) {
                _postsList = state.postsList;
                return Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Container(
                      color: primary,
                      height: 40 * heightMultiplier,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 30.0,
                            right: 30.0,
                            top: 10 * heightMultiplier),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 11 * heightMultiplier,
                                  width: 22 * widthMultiplier,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: _currentUser.photoURL == null
                                          ? AssetImage(
                                              "assets/images/userAvatar.png")
                                          : NetworkImage(_currentUser.photoURL),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5 * widthMultiplier,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _currentUser.displayName ?? "No username",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 3 * textMultiplier,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 1 * heightMultiplier,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3 * heightMultiplier,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      _postsList.length.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 3 * textMultiplier,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 1.9 * textMultiplier,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                            onPressed: null,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "EDIT PROFILE",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      1.8 * textMultiplier),
                                            ),
                                          ),
                                        ],
                                      )),
                                  onTap: _openEditProfile,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 35 * heightMultiplier),
                      child: Container(
                        padding: EdgeInsets.only(left: 15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.0),
                              topLeft: Radius.circular(30.0),
                            )),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            _bloc..add(LeerPostsEvent());
                            return Future.delayed(Duration(seconds: 1));
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: heightMultiplier,
                                ),
                                Container(
                                  height: 60 * heightMultiplier,
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    padding: EdgeInsets.all(16.0),
                                    children: _postsList
                                        .map(
                                            (e) => _postToCard(e, _scaffoldKey))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
              return Center(
                child: Text('Error loading posts'),
              );
            },
          ),
        ));
  }

  void _openEditProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return EditProfile();
      }),
    );
  }

  Widget _postToCard(Post post, var _scaffoldKey) {
    return GestureDetector(
      onTap: () {
        _scaffoldKey.currentState..hideCurrentSnackBar();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return EditPost(
              post: post,
            );
          }),
        ).then((value) {
          if ((value == 'Save' || value == 'Delete')) {
            _scaffoldKey.currentState
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    content: value == 'Save'
                        ? Text("Success: post updated")
                        : Text("Success: post deleted")),
              );
            _bloc..add(LeerPostsEvent());
          }
        });
      },
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              post.imageUrl,
              height: 40 * imageSizeMultiplier,
              width: 40 * imageSizeMultiplier,
              fit: BoxFit.cover,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

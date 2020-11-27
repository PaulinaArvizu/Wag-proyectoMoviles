import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/models/post.dart';
import 'package:wag_proyecto_moviles/profile/bloc/profile_bloc.dart';
import 'package:wag_proyecto_moviles/profile/sizeConfig.dart';

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
  List<Post> _postsList = List();
  @override
  void initState() {
    _auth = FirebaseAuth.instance;
    _currentUser = _auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                return RefreshIndicator(
                  onRefresh: () async {
                    _bloc..add(LeerPostsEvent());
                    return Future.delayed(Duration(seconds: 1));
                  },
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Container(
                        color: primary,
                        height: 40 * SizeConfig.heightMultiplier,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 30.0,
                              right: 30.0,
                              top: 10 * SizeConfig.heightMultiplier),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 11 * SizeConfig.heightMultiplier,
                                    width: 22 * SizeConfig.widthMultiplier,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: _currentUser.photoURL == null
                                            ? AssetImage(
                                                "assets/images/userAvatar.png")
                                            : NetworkImage(
                                                _currentUser.photoURL),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5 * SizeConfig.widthMultiplier,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _currentUser.displayName ??
                                            "No username",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                3 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 1 * SizeConfig.heightMultiplier,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 3 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "7",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                3 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Posts",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize:
                                              1.9 * SizeConfig.textMultiplier,
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "EDIT PROFILE",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 1.8 *
                                                        SizeConfig
                                                            .textMultiplier),
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
                        padding: EdgeInsets.only(
                            top: 35 * SizeConfig.heightMultiplier),
                        child: Container(
                          padding: EdgeInsets.only(left: 15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0),
                              )),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.heightMultiplier,
                                ),
                                Container(
                                  height: 60 * SizeConfig.heightMultiplier,
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    padding: EdgeInsets.all(16.0),
                                    children: _postsList
                                        .map((e) => _postToCard(e))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
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

  Widget _postToCard(Post post) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return EditPost(
              post: post,
            );
          }),
        );
      },
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              post.imageUrl,
              height: 40 * SizeConfig.imageSizeMultiplier,
              width: 40 * SizeConfig.imageSizeMultiplier,
              fit: BoxFit.cover,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/home/bloc/home_bloc.dart';
import 'package:wag_proyecto_moviles/models/post.dart';
import 'package:intl/intl.dart';
import 'package:extended_image/extended_image.dart';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  HomeBloc _homeBloc;
  List<Post> _posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 90,
        backgroundColor: background,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/Logo wag.png",
              height: 85,
            ),
            SizedBox(width: 5),
            Text(
              "Wag",
              style: TextStyle(
                fontFamily: 'Roboto Black Italic',
                fontSize: 46,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(
                  posts: _posts,
                  postFormat: _postFormat,
                ),
              );
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) {
          _homeBloc = HomeBloc();
          return _homeBloc..add(LeerPostsEvent());
        },
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeSuccessState) {
              _posts = state.postList;
              return RefreshIndicator(
                onRefresh: () async {
                  _homeBloc..add(LeerPostsEvent());
                  return Future.delayed(Duration(seconds: 1));
                },
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _postFormat(_posts[index]);
                  },
                ),
              );
            }
            if (state is HomeErrorState) {
              return RefreshIndicator(
                onRefresh: () async {
                  _homeBloc..add(LeerPostsEvent());
                  return Future.delayed(Duration(seconds: 1));
                },
                child: Center(
                  child: Text(state.errorMessage),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                _homeBloc..add(LeerPostsEvent());
                return Future.delayed(Duration(seconds: 1));
              },
              child: Center(
                child: Text("Please wait"),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _postFormat(Post post) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(post.date); // <-- Incoming date

    var outputFormat = DateFormat.yMMMMd('en_US').add_jm();
    var outputDate = outputFormat.format(inputDate); // <-- Desired date

    print(outputDate);
    return Container(
      //este container es un post
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: <Widget>[
              SizedBox(width: 15),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: post.authorImageUrl == ""
                        ? AssetImage("assets/images/userAvatar.png")
                        : NetworkImage(post.authorImageUrl),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                post.authorUsername == "" ? "No username" : post.authorUsername,
                style: TextStyle(
                  fontFamily: "Proxima Nova Bold",
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 247,
            child: ExtendedImage.network(
              post.imageUrl,
              fit: BoxFit.contain,
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/Loading.gif",
                          height: 75,
                        ),
                        Text("Loading..."),
                      ],
                    );
                    break;
                  case LoadState.completed:
                    return Image.network(
                      post.imageUrl,
                      fit: BoxFit.contain,
                    );
                    break;
                  case LoadState.failed:
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/ImageNotFound.png",
                          height: 150,
                        ),
                        Text("Image not found"),
                      ],
                    );
                    break;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(outputDate, style: TextStyle(color: Colors.grey)),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              SizedBox(width: 25),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name:",
                      style: TextStyle(
                        fontFamily: "Poppins Bold",
                        color: primary,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Size:",
                      style: TextStyle(
                        fontFamily: "Poppins Bold",
                        color: primary,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Age (aprox.):",
                      style: TextStyle(
                        fontFamily: "Poppins Bold",
                        color: primary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.name ?? '',
                      style: TextStyle(
                        fontFamily: "Poppins Regular",
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      post.size ?? '',
                      style: TextStyle(
                        fontFamily: "Poppins Regular",
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      post.age ?? '',
                      style: TextStyle(
                        fontFamily: "Poppins Regular",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(width: 100),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.black,
                      size: 25,
                    ),
                    onPressed: () {
                      _openDialog(post.contactInfo);
                    },
                  ),
                ),
              )
            ],
          ),
          ExpansionTile(
            expandedAlignment: Alignment.centerLeft,
            title: Text(
              "Description",
              style: TextStyle(color: Colors.grey),
            ),
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(
                  post.description ?? '',
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  _openDialog(String contactInfo) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(
                'assets/images/contactInfoIcon.png',
                height: 40,
              ),
              SizedBox(width: 10),
              Text("Contact Information"),
            ],
          ),
          content: Text(contactInfo ?? ''),
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
  }
}

class Search extends SearchDelegate {
  final List<Post> posts;
  final Function postFormat;

  Search({
    @required this.posts,
    @required this.postFormat,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    //boton que limpie la busqueda
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon (a la izquierda del search)
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Post> filteredPosts = [];
    //busca los resultados
    query.isEmpty
        ? filteredPosts = []
        : filteredPosts = posts.where((p) {
            String name = p.name.toLowerCase();
            String size = p.size.toLowerCase();
            String age = p.age.toLowerCase();
            String desc = p.description.toLowerCase();
            String author = p.authorUsername.toLowerCase();
            String search = query.toLowerCase();
            return name.contains(search) ||
                size.contains(search) ||
                age.contains(search) ||
                desc.contains(search) ||
                author.contains(search);
          }).toList();

    //muestra los resultados
    return filteredPosts.length == 0
        ? Center(child: Text('No results'))
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: filteredPosts.length,
            itemBuilder: (BuildContext context, int index) {
              return postFormat(filteredPosts[index]);
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text(''));
  }
}

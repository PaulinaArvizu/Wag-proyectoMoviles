import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/models/post.dart';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Post> _posts = [
    Post(
      name: 'Perritu',
      size: 'Grande',
      imageUrl: '',
      age: '3 años',
      description:
          'Mucho texto mucho texto mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto ',
      authorID: null,
      date: null,
      contactInfo: 'Holis',
    ),
    Post(
      name: 'Hola',
      size: 'adios',
      imageUrl: '',
      age: '1 años',
      description:
          'Mucho texto mucho texto mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto ',
      authorID: null,
      date: null,
      contactInfo: 'jelou',
    ),
  ];

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
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        // padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: _posts.length,
        itemBuilder: (BuildContext context, int index) {
          return _postFormat(_posts[index]);
        },
      ),
    );
  }

  Widget _postFormat(Post post) {
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
                    image: AssetImage("assets/images/cassie.jpeg"),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Cassie Donk",
                style: TextStyle(
                  fontFamily: "Proxima Nova Bold",
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 22),
          SizedBox(
            height: 247,
            child: Image.asset(
              "assets/images/perrito feliz.jpg",
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              SizedBox(width: 25),
              Column(
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
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "Perritu",
                    post.name ?? '',
                    style: TextStyle(
                      fontFamily: "Poppins Regular",
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    // "Grande",
                    post.size ?? '',
                    style: TextStyle(
                      fontFamily: "Poppins Regular",
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    // "3 años",
                    post.age ?? '',
                    style: TextStyle(
                      fontFamily: "Poppins Regular",
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 125),
              IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                  size: 25,
                ),
                onPressed: () {
                  _openDialog(post.contactInfo);
                },
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  //TODO: poner una variable bool para cada post
                  child: false //expandedText
                      ? Text(
                          // "Mucho texto mucho texto mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto ",
                          post.description ?? '',
                        )
                      : Text(
                          // "Mucho texto mucho texto mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto ",
                          post.description ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                ),
              ),
              IconButton(
                icon: false //expandedText
                    ? Icon(Icons.arrow_circle_up)
                    : Icon(Icons.arrow_circle_down),
                onPressed: () {
                  setState(() {
                    // expandedText = !expandedText;
                  });
                },
              ),
              SizedBox(width: 20),
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
              // Icon(Icons.info_outline),
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
            String search = query.toLowerCase();
            return name.contains(search) ||
                size.contains(search) ||
                age.contains(search) ||
                desc.contains(search);
          }).toList();

    //muestra los resultados
    return filteredPosts.length == 0
        ? Center(child: Text('No results'))
        : ListView.builder(
            scrollDirection: Axis.vertical,
            // padding: EdgeInsets.symmetric(horizontal: 20),
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

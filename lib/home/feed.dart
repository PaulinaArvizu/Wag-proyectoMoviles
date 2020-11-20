import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/models/post.dart';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  Post _post = Post(
    name: 'Perritu',
    size: 'Grande',
    imageUrl: '',
    age: '3 años',
    description:
        'Mucho texto mucho texto mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto ',
    authorID: null,
    date: null,
    contactInfo: 'Holis',
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/Logo wag.png",
                height: 100,
              ),
              SizedBox(width: 5),
              Text(
                "WAG",
                style: TextStyle(
                  fontFamily: 'Roboto Black Italic',
                  fontSize: 46,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          // aqui empiezan los posts
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            // padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return _postFormat(_post);
            },
          ),
        ),
      ],
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
          SizedBox(height: 10),
          SizedBox(
            child: Image.asset("assets/images/perrito feliz.jpg"),
          ),
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
          title: Text("Contact Info"),
          content: Text(contactInfo ?? ''),
          actions: [
            FlatButton(
              onPressed: () {},
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

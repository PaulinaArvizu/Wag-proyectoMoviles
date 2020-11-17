import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/colors.dart';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
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
          child: ListView(
            children: <Widget>[
              Container(
                //este container es un post
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: <Widget>[
                        SizedBox(width: 15),
                        Container(
                          height: 50,
                          width: 50,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(width: 300),
                        IconButton(
                          icon: Icon(
                            Icons.info_outline,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {},
                        )
                      ],
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
                              "Perritu",
                              style: TextStyle(
                                fontFamily: "Poppins Regular",
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Grande",
                              style: TextStyle(
                                fontFamily: "Poppins Regular",
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "3 años",
                              style: TextStyle(
                                fontFamily: "Poppins Regular",
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Text(
                        "Mucho texto mucho texto mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto ",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              Container(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(width: 300),
                        IconButton(
                          icon: Icon(
                            Icons.info_outline,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {},
                        )
                      ],
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
                              "Perritu",
                              style: TextStyle(
                                fontFamily: "Poppins Regular",
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Grande",
                              style: TextStyle(
                                fontFamily: "Poppins Regular",
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "3 años",
                              style: TextStyle(
                                fontFamily: "Poppins Regular",
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Text(
                        "Mucho texto mucho texto mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto  mucho texto ",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

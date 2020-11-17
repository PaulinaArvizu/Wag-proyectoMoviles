import 'package:flutter/foundation.dart';

class Post {
  final String name;
  final String size;
  final String imageUrl;
  final String age;
  final String description;
  final String authorID;
  final String date;
  final String contactInfo;

  Post({
    @required this.name,
    @required this.size,
    @required this.imageUrl,
    @required this.age,
    @required this.description,
    @required this.authorID,
    @required this.date,
    @required this.contactInfo,
  });
}

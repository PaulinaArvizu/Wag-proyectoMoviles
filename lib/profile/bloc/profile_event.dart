part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class EditPostEvent extends ProfileEvent {
  final String name;
  final String size;
  final String age;
  final String description;
  final String contactInfo;
  final String date;
  final String imageUrl;

  EditPostEvent({
    @required this.name,
    @required this.size,
    @required this.age,
    @required this.description,
    @required this.contactInfo,
    @required this.date,
    @required this.imageUrl,
  });

  @override
  List<Object> get props =>
      [name, size, age, description, contactInfo, date, imageUrl];
}

class LeerPostsEvent extends ProfileEvent {}

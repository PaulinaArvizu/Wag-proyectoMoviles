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
  final String authorID;
  final String contactInfo;

  EditPostEvent({
    @required this.name,
    @required this.size,
    @required this.age,
    @required this.description,
    @required this.authorID,
    @required this.contactInfo,
  });

  @override
  List<Object> get props => [name, size, age, description];
}

class LoadImageEvent extends ProfileEvent {
  final bool takePictureFromCamara;

  LoadImageEvent({@required this.takePictureFromCamara});
  @override
  List<Object> get props => [takePictureFromCamara];
}

class LeerPostsEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

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

class CargarImagenEvent extends ProfileEvent {
  final bool takePictureFromCamera;

  CargarImagenEvent({@required this.takePictureFromCamera});
  @override
  List<Object> get props => [takePictureFromCamera];
}

class LeerPostsEvent extends ProfileEvent {}

class EditProfileEvent extends ProfileEvent {}

class DeletePostEvent extends ProfileEvent {
  final String imageUrl;

  DeletePostEvent({
    @required this.imageUrl,
  });

  @override
  List<Object> get props => [imageUrl];
}

class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final bool nameChanged;
  final bool imageChanged;

  UpdateProfileEvent({
    @required this.name,
    @required this.nameChanged,
    @required this.imageChanged,
  });

  @override
  List<Object> get props => [name, nameChanged, imageChanged];
}

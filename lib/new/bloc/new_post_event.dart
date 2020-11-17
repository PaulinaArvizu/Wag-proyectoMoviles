part of 'new_post_bloc.dart';

abstract class NewPostEvent extends Equatable {
  const NewPostEvent();

  @override
  List<Object> get props => [];
}

class CreateNewPostEvent extends NewPostEvent {
  final String name;
  final String size;
  final String age;
  final String description;
  final String authorID;
  final String contactInfo;

  CreateNewPostEvent({
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

class CargarImagenEvent extends NewPostEvent {
  final bool takePictureFromCamera;

  CargarImagenEvent({@required this.takePictureFromCamera});
  @override
  List<Object> get props => [takePictureFromCamera];
}

class LeerPostsEvent extends NewPostEvent {
  @override
  List<Object> get props => [];
}

part of 'new_post_bloc.dart';

abstract class NewPostState extends Equatable {
  const NewPostState();

  @override
  List<Object> get props => [];
}

class NewPostInitial extends NewPostState {}

class NewPostSuccessState extends NewPostState {}

class NewPostCreatedState extends NewPostState {}

class NewPostErrorState extends NewPostState {
  final String errorMessage;

  NewPostErrorState({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class ImagenCargadaState extends NewPostState {
  final File imagen;

  ImagenCargadaState({@required this.imagen});

  @override
  List<Object> get props => [imagen];
}

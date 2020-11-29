part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class EditPostSuccessState extends ProfileState {}

class EditPostUpdatedState extends ProfileState {}

class EditPostErrorState extends ProfileState {
  final String errorMessage;

  EditPostErrorState({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class ProfileSuccessState extends ProfileState {
  final List<Post> postsList;

  ProfileSuccessState({@required this.postsList});
  @override
  List<Object> get props => [postsList];
}

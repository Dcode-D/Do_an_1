part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsImageState extends PostsState {
  final List<File> listImages;
  PostsImageState(this.listImages);
}

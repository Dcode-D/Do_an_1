part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsImageState extends PostsState {
  final List<File> listImages;
  PostsImageState(this.listImages);
}

class PostsWardState extends PostsState {
  final List<Map> listWard;
  PostsWardState(this.listWard);
}

class PostCreatePostsState extends PostsState {
  final bool success;
  PostCreatePostsState(this.success);
}

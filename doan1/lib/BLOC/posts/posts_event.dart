part of 'posts_bloc.dart';
enum ImagePickMethod {gallery, camera}
@immutable
abstract class PostsEvent {}

class AddImageEvent extends PostsEvent {
  final ImagePickMethod method;
  AddImageEvent(this.method);
}

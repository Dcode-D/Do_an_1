part of 'posts_bloc.dart';
enum ImagePickMethod {gallery, camera}
@immutable
abstract class PostsEvent {}

class AddImageEvent extends PostsEvent {
  final ImagePickMethod method;
  AddImageEvent(this.method);
}

class RemoveImageEvent extends PostsEvent {
  final int index;
  RemoveImageEvent(this.index);
}


class CreatePostEvent extends PostsEvent{
  final String title;
  final String description;
  final String address;
  final String province;
  final String district;
  final String referenceName;
  CreatePostEvent({required this.title,required this.description,required this.address,required this.province,required this.district,required this.referenceName});
}

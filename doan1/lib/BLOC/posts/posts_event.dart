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

//handle getting places
class GetProvinceEvent extends PostsEvent {}

class GetDistrictEvent extends PostsEvent {
  final int provinceCode;
  GetDistrictEvent(this.provinceCode);
}

class GetWardEvent extends PostsEvent {
  final int districtCode;
  final int provinceCode;
  GetWardEvent(this.districtCode, this.provinceCode);
}

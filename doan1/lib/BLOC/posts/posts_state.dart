part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsImageState extends PostsState {
  final List<File> listImages;
  PostsImageState(this.listImages);
}

class PostsProvinceState extends PostsState {
  final List<Map> listProvince;
  PostsProvinceState(this.listProvince);
}

class PostsDistrictState extends PostsState {
  final List<Map<String,dynamic>> listDistrict;
  PostsDistrictState(this.listDistrict);
}

class PostsWardState extends PostsState {
  final List<Map<String,dynamic>> listWard;
  PostsWardState(this.listWard);
}

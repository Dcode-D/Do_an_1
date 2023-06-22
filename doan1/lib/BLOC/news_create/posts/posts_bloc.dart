import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:doan1/data/Preferences.dart';
import 'package:doan1/data/repositories/article_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:doan1/Utils/pick_files.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  var listImages = <File>[];
  PostsBloc() : super(PostsInitial()) {
    final sharedPrefs = GetIt.instance.get<SharedPreferences>();
    final token ="Bearer ${sharedPrefs.getString(Preferences.token) as String}" ;
    final articleRepo = GetIt.instance.get<ArticleRepository>();
    on<PostsEvent>((event, emit) {
    });
    on<AddImageEvent>((event, emit) async {
      if(event.method == ImagePickMethod.camera){
        var image = await FilesPicking.pickImageFromCamera();
        if(image != null){
          listImages.add(image);
          emit(PostsImageState(listImages));
        }
      }
      else{
        var image = await FilesPicking.pickImageFromGallery();
        if(image != null){
          listImages.add(image);
          emit(PostsImageState(listImages));
        }
      }
    });
    on<RemoveImageEvent>((event, emit) async {
      listImages.removeAt(event.index);
      emit(PostsImageState(listImages));
    });
    on<CreatePostEvent>((event, emit) async {
      final rs = await articleRepo.createPost(
          token,
          event.title,
          event.description,
          event.address,
          event.province,
          event.district,
          event.referenceName,
          listImages);
      emit(PostCreatePostsState(rs));
    });
  }
}

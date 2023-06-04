import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:doan1/Utils/pick_files.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  var listImages = <File>[];
  PostsBloc() : super(PostsInitial()) {
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
  }
}

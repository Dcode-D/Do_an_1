import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/article.dart';

part 'edit_post_event.dart';
part 'edit_post_state.dart';

class EditPostBloc extends Bloc<EditPostEvent,EditPostState>{
  Article? article;
  List<String>? images;
  var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
  EditPostBloc() : super(EditPostInitial()){
    images = [];
   on<EditPostInitialEvent>((event,emit)async{
     if(event.article == null){
       emit(EditPostDataInitial(false));
       return;
     }
     article = event.article;
     for (var item in article!.images!){
       images!.add('$baseUrl/files/${item['_id']}');
     }
     if(article != null && images != null ){
       emit(EditPostDataInitial(true));
     }
     else{
       emit(EditPostDataInitial(false));
     }
   });
  }
}
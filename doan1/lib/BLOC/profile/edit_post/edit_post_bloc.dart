import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/article.dart';
import '../../../data/repositories/article_repo.dart';

part 'edit_post_event.dart';
part 'edit_post_state.dart';

class EditPostBloc extends Bloc<EditPostEvent,EditPostState>{
  Article? article;
  List<String>? images;
  int? index;
  var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
  EditPostBloc() : super(EditPostInitial()){
   on<EditPostInitialEvent>((event,emit)async{
     images = [];
     if(event.article == null){
       emit(EditPostDataInitial(false));
       return;
     }
     article = event.article;
     index = event.index;
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
   on<DeletePostEvent>((event,emit) async{
     if(event.articleID == null){
       emit(DeletePostState(false));
       return;
     }
     bool? result = await deletePostById(event.articleID);
     if(result == true){
       emit(DeletePostState(true));
     }
     else{
       emit(DeletePostState(false));
     }
   });
  }
  Future<bool> deletePostById(String id){
    return GetIt.instance.get<ArticleRepo>().deletePost(id);
  }
}
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doan1/Utils/pick_files.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../Utils/image_pick_method.dart';
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
   on<RefreshPostEvent>(
       (event,emit) async {
         if(article !=null)
           {
             var articlerepo = GetIt.instance.get<ArticleRepository>();
             article = await articlerepo.getArticleById(article!.id!);
             if(article!=null){
               add(EditPostInitialEvent(article: article));}

             else{
               emit(EditPostDataInitial(false));
             }

           }
         else{
           emit(EditPostDataInitial(false));
         }
       }
   );

   on<EditPostEventAddImage>(
           (event,emit) async {
             var file;
          if(event.method == ImagePickMethod.GALLERY){
            file = await FilesPicking.pickImageFromGallery();
          }
          if(event.method == ImagePickMethod.CAMERA){
            file = await FilesPicking.pickImageFromCamera();
          }
          if(file == null){
            emit(EditPostResultState(editSuccess: false));
            return;
          }
          else {
            var articlerepo = GetIt.instance.get<ArticleRepository>();
            if (article != null) {
              var result = await articlerepo.uploadArticleImage(
                  article!.id as String, file);
              if (result) {
                emit(EditPostResultState(editSuccess: true));
                add(RefreshPostEvent());
              }
              else {
                emit(EditPostResultState(editSuccess: false));
                return;
              }
            }
            else{
              emit(EditPostResultState(editSuccess: false));
            }
          }
       }
   );

   on<EditPostEventUpdate>(
       (event,emit) async{
          if(article == null){
            emit(EditPostResultState(editSuccess: false));
            return;
          }
          var articlerepo = GetIt.instance.get<ArticleRepository>();
          var result = await articlerepo.updateArticleInfo(article!.id as String, event.title, event.address, event.description, event.name);
          if(result){
            emit(EditPostResultState(editSuccess: true));
            add(RefreshPostEvent());
          }
          else{
            emit(EditPostResultState(editSuccess: false));
            return;
          }
       }
   );

   on<EditPostEventDeleteImage>(
       (event,emit) async {
         if(article == null){
           emit(EditPostResultState(editSuccess: false));
           return;
         }
         var articlerepo = GetIt.instance.get<ArticleRepository>();
         var result = await articlerepo.deleteArticleImage(article!.id as String, article!.images![event.index]['_id']);
         if(result){
           emit(EditPostResultState(editSuccess: true));
           add(RefreshPostEvent());
         }
         else{
           emit(EditPostResultState(editSuccess: false));
           return;
         }
       }
   );

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
    return GetIt.instance.get<ArticleRepository>().deletePost(id);
  }
}
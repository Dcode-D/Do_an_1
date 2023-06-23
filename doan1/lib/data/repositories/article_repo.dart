import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doan1/data/model/article.dart';
import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Preferences.dart';
import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class ArticleRepository {
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  ArticleRepository(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<int?> getMaxPage() async {
    return _appService
        .getArticleMaxPage()
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data;
      }
    });
  }

  Future<Article?> getArticleById(String id) async {
    return _appService.getArticleById(id).then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toArticle();
      }
    });
  }

  Future<List<String>?> getListId(int page, String? city, String? province, String? name) async {
    return _appService
        .getListIdArticleFromPage(page, city, province, name)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListIdArticle();
      }
    });
  }

  Future<bool> createPost(String token, String title, String description, String address, String province, String district, String referenceName, List<File> files) async {
    return _appService.createArticle(title: title, description: description, address: address, province :province, district: district, referenceName: referenceName, token: token, files: files).then((http) async {
      if (http.response.statusCode != 200) {
        return false;
      }
      else{
        return true;
      }
    });
  }

  Future<bool> deletePost(String id){
    return _appService.deleteArticleById(
        token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
        id: id).then((http) async {
      if (http.response.statusCode != 200) {
        return false;
      }
      else{
        return true;
      }
    });
  }

  Future<List<String>?> getListIdArticleFromUser(int page, String publishBy) async {
    return _appService
        .getListIdArticleFromUser(page, publishBy)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListIdArticle();
      }
    });
  }

  Future<bool> deleteArticleImage(String id, String imageId) async {
    return _appService.deleteArticleImage(
        token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
        article: id,
        request: _requestFactory.deleteImage(imageId)
    ).then((http) async {
      if (http.response.statusCode != 200) {
        return false;
      }
      else{
        return true;
      }
    });
  }

  Future<bool> uploadArticleImage(String id, File file){
    return _appService.uploadArticleImage(token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
        article: id,
        file: file).then((http) async {
      if (http.response.statusCode != 200) {
        return false;
      }
      else {
        return true;
      }
    });
    }

    Future<bool> updateArticleInfo(String id, String title, String address, String description, String referenceName){
      return _appService.updateArticleInfo(
          token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
          article: id,
          request: _requestFactory.updateArticleInfo(title, address, description, referenceName)
      ).then((http) async {
        if (http.response.statusCode != 200) {
          return false;
        }
        else {
          return true;
        }
      });
    }
}

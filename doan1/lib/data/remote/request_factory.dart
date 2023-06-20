import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class RequestFactory {
  RequestFactory();
  createLogin(String username, String password) {
    return {
      "username": username,
      "password": password,
      "device": "mobile"
    };
  }

  createRegister(String username, String password,String email, String firstname, String lastname,String phone, String address,int gender) {
    return {
      "username": username,
      "password": password,
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "phonenumber": phone,
      "address": address,
      "gender": gender
    };
  }

  updateUser(String username,String email, String firstname, String lastname,String phone, String address,int gender){
      return {
        "username": username,
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "phonenumber": phone,
        "address": address,
        "gender": gender
      };
   }

  updateUserPassWord(String password){
    return {
      "password": password,
    };
  }

  updateAvatar(FormData path){
    return {
      "file": path,
    };
  }

  createBookingDate(List<String> attachedServices, String startDate, String endDate, String user, String note, bool approved, bool suspended,String type){
    return {
      "attachedServices": attachedServices,
      "startDate": startDate,
      "endDate": endDate,
      "user": user,
      "note": note,
      "approved": approved,
      "suspended": suspended,
      "type": type
    };
  }

  createPostTour(String name, String description, double rating, List<String> plans, int duration,double price, int maxGroupSize){
    return {
      "name": name,
      "description": description,
      "rating": rating,
      "articles": plans,
      "duration": duration,
      "price": price,
      "maxGroupSize": maxGroupSize
    };
  }

  deleteHotelImage(String imageId){
    return {
      "imageId": imageId,
    };
  }

  CreateFavorite(String user, String element, String type){
    return {
      "user": user,
      "element": element,
      "type": type
    };
  }
}
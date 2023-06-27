import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../model/hotelroom.dart';

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

  createPostTour(String name, String description, double rating, List<String> plans, List<String> hotels, int duration,double price, int maxGroupSize){
    return {
      "name": name,
      "description": description,
      "rating": rating,
      "articles": plans,
      "hotels": hotels,
      "duration": duration,
      "price": price,
      "maxGroupSize": maxGroupSize
    };
  }

  deleteImage(String imageId){
    return {
      "imageId": imageId,
    };
  }

  createFavorite(String user, String element, String type){
    return {
      "user": user,
      "element": element,
      "type": type
    };
  }

  updateVehicle(String brand, double price, String color, String description, String address, int seats){
    return {
      "brand": brand,
      "pricePerDay": price,
      "color": color,
      "description": description,
      "address": address,
      "seats": seats
    };
  }

  createRating(String user, String service, double rating, String comment, String type){
    return {
      "user": user,
      "service": service,
      "rating": rating,
      "comment": comment,
      "type": type
    };
  }

  updateRating(double rating, String comment){
    return {
      "rating": rating,
      "comment": comment,
    };
  }

  updateArticleInfo(String tile, String address, String description, String referenceName){
    return {
      "title": tile,
      "address": address,
      "description": description,
      "referenceName": referenceName
    };
  }

  updateTourInfo(String name, String description, double rating, List<String> plans, int duration,double price, int maxGroupSize){
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

  createRooms(List<HotelRoom> hotelRooms){
    var hotelroomsjson = hotelRooms.map((e) => e.toJson()).toList();
    return {
      "hotelRooms": hotelroomsjson
    };
  }

  updateRoom(HotelRoom hotelRoom){
    return hotelRoom.toJson();
  }
}
import 'package:dio/dio.dart';

class GetPlaces {
  static Future<List<Map>> getProvince() async{
    final dio = Dio();
    final response = await dio.get('https://provinces.open-api.vn/api/p/');
    List<Map> result = [];
    for(var item in response.data){
      result.add({"name":item["name"],"code":item["code"]});
    }
    return result;
  }

  static Future<List<Map<String,dynamic>>> getDistrict(int provinceCode) async{
    final dio = Dio();
    final Response<List<Map<String,dynamic>>> response = await dio.get('https://provinces.open-api.vn/api/d/search/?p=$provinceCode&q=*');
    final result = response.data?.map((e) => {"name":e["name"],"code":e["code"]}).toList();
    return result ?? [];
  }

  static Future<List<Map<String,dynamic>>> getWard(int districtCode, int provinceCode) async{
    final dio = Dio();
    final Response<List<Map<String,dynamic>>> response = await dio.get('https://provinces.open-api.vn/api/w/search/?d=$districtCode&p=$provinceCode&q=*');
    final result = response.data?.map((e) => {"name":e["name"],"code":e["code"]}).toList();
    return result ?? [];
  }
}
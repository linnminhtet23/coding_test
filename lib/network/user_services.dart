import 'package:aceplus_codetest/network/api_services.dart';
import 'package:dio/dio.dart';

class UserServices{
  static getUserList()async{
    Response response = await ApiService.getApiHandler().get("users");
    return response.data;
  }
  static getUserListDetail(int id) async{
    Response response = await ApiService.getApiHandler().get("users/$id");
    return response.data;
  }
}
import 'dart:convert';

import 'package:aceplus_codetest/db/user_db_service.dart';
import 'package:aceplus_codetest/network/user_services.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  var decodedForm;
  var decodedDetailForm;

  Future<void> getUserData() async {
    var userResponse = await UserServices.getUserList();
    String userJson = jsonEncode(userResponse);
    await UserDBService.deleteExisting();
    await UserDBService.saveUserData(userJson);

    await getUserDataOffline();
    // var data = userResponse.data;
    // for (var i = 0; i < data.length; i++) {
    //   users.add(User(
    //     id: data[i]["id"],
    //     name: data[i]["name"],
    //     email: data[i]["email"],
    //     address: data[i]["address"],
    //     phone: data[i]["phone"],
    //     website: data[i]["website"],
    //   ));
    // }
    notifyListeners();
  }

  Future<void> getUserDataOffline() async {
    String userJson = await UserDBService.getUserDataJson();
    decodedForm = jsonDecode(userJson);
    notifyListeners();
  }

  Future<void> getUserDetailData(int id) async {
    var response = await UserServices.getUserListDetail(id);
    // print(response);
    var userDetailJson = jsonEncode(response);
    await UserDBService.deleteExistingUserDetail();
    await UserDBService.saveUserDetailData(userDetailJson);
    getUserDetailDataOffline();
    notifyListeners();
  }

    Future<void> getUserDetailDataOffline() async {
    String userJson = await UserDBService.getUserDetailDataJson();
    decodedDetailForm = jsonDecode(userJson);
    notifyListeners();
  }
}

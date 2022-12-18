import '../helpers/db_helper.dart';

class UserDBService {
  static Future<void> saveUserData(String formJson) async {
    var result = await DBHelper.getDB()
        ?.insert("userData", {"userDataJson": formJson});
  }
  static Future<void> saveUserDetailData(String formJson) async {
    var result = await DBHelper.getDB()
        ?.insert("userDetailData", {"userDetailDataJson": formJson});
  }

  static Future<String> getUserDataJson() async {
    var result =
        await DBHelper.getDB()?.rawQuery("SELECT * FROM userData  limit 1");

    return result![0]["userDataJson"].toString();
  }

    static Future<String> getUserDetailDataJson() async {
    var result =
        await DBHelper.getDB()?.rawQuery("SELECT * FROM userDetailData  limit 1");

    return result![0]["userDetailDataJson"].toString();
  }

  static Future<void> deleteExisting() async {
    await DBHelper.getDB()?.delete("userData");
  }
    static Future<void> deleteExistingUserDetail() async {
    await DBHelper.getDB()?.delete("userDetailData");
  }
}

import 'dart:convert';

import 'package:rash7ly/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalHelper {
  static late SharedPreferences pref;
  static const String kUserData = 'user_data';

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static setUserData(UserModel? userData) {
    if (userData == null) return;
    var objectJson = userData.toMap();
    var userDataString = json.encode(objectJson);
    setData(kUserData, userDataString);
  }

  static UserModel? getUserData() {
    var userDataString = pref.getString(kUserData);
    if (userDataString == null) return null;
    var objectJson = json.decode(userDataString);
    return UserModel.fromMap(objectJson);
  }

  static setData(String key, dynamic value) async {
    if (value is String) {
      return await pref.setString(key, value);
    } else if (value is int) {
      return await pref.setInt(key, value);
    } else if (value is bool) {
      return await pref.setBool(key, value);
    } else if (value is double) {
      return await pref.setDouble(key, value);
    } else if (value is List<String>) {
      return await pref.setStringList(key, value);
    }
  }

  static getData(String key) {
    return pref.get(key);
  }

  static removeData(String key) async {
    return await pref.remove(key);
  }
}

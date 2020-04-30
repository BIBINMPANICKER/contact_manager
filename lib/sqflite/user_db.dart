import 'package:contact_manager/models/user_model.dart';

import 'db_helper.dart';

class UserDb {
  DBHelper dbHelper = new DBHelper();

  static final String userTable = "user";
  static final String createTableQuery = "CREATE TABLE IF NOT EXISTS " +
      userTable +
      "(id TEXT, "
          "first_name TEXT, "
          "last_name TEXT, "
          "email TEXT, "
          "gender TEXT, "
          "date_of_birth TEXT, "
          "phone_no TEXT)";

  Future<void> saveUsers(UserModel userModel) async {
    var dbClient = await dbHelper.db;
    try {
      for (int i = 0; i < userModel.data.length; i++) {
        await dbClient.rawQuery(
            "INSERT INTO $userTable (id, first_name, last_name, email, gender,"
            "date_of_birth, phone_no) VALUES ("
            "'${userModel.data[i].id}',"
            "'${userModel.data[i].firstName}',"
            "'${userModel.data[i].lastName.replaceAll("'", "''")}',"
            "'${userModel.data[i].email}',"
            "'${userModel.data[i].gender}',"
            "'${userModel.data[i].dateOfBirth}',"
            "'${userModel.data[i].phoneNo}')");
      }
    } catch (e) {
      print(e);
    }
  }

  getAllUsers() async {
    var dbClient = await dbHelper.db;
    List<Map> map = await dbClient.rawQuery("SELECT * FROM $userTable");

    List<Datum> list = new List();
    for (int i = 0; i < map.length; i++) {
      list.add(Datum.fromMap(map[i]));
    }
    return UserModel(data: list);
  }

  Future<dynamic> clearUserTable() async {
    var dbClient = await dbHelper.db;
    await dbClient.delete(userTable);
  }
}

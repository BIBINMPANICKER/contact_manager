import 'package:contact_manager/models/user_model.dart';

import 'db_helper.dart';

class FavouritesDb {
  DBHelper dbHelper = new DBHelper();

  static final String favouritesTable = "favourites";
  static final String createTableQuery = "CREATE TABLE IF NOT EXISTS " +
      favouritesTable +
      "(Id INTEGER PRIMARY KEY, UserId TEXT)";

  Future<List<String>> getFavouritesId() async {
    var dbClient = await dbHelper.db;
    List<Map> map = await dbClient.rawQuery("SELECT * FROM $favouritesTable");

    List<String> list = new List();
    for (int i = 0; i < map.length; i++) {
      list.add(map[i]['UserId']);
    }
    return list;
  }

  Future<UserModel> getFavourites() async {
    var dbClient = await dbHelper.db;
    List<Map> map = await dbClient.rawQuery(
        "SELECT DISTINCT user.id,user.first_name,"
        "user.last_name,user.gender,user.email,user.date_of_birth,"
        "user.phone_no FROM user INNER JOIN favourites on user.id=favourites.UserId");

    List<Datum> list = new List();
    for (int i = 0; i < map.length; i++) {
      list.add(Datum.fromMap(map[i]));
    }
    list.forEach((f) {
      f.isFavourite = true;
    });
    return UserModel(data: list);
  }

  Future<dynamic> addFavourite(String id) async {
    var dbClient = await dbHelper.db;
    await dbClient
        .rawQuery("INSERT INTO $favouritesTable (UserId)VALUES ('$id')");
  }

  Future<dynamic> deleteFavourite(String id) async {
    var dbClient = await dbHelper.db;
    await dbClient.rawDelete("DELETE FROM $favouritesTable WHERE UserId='$id'");
  }
}

import 'package:contact_manager/sqflite/favourites_db.dart';
import 'package:contact_manager/sqflite/user_db.dart';

class DbFactory {
  static final _dbFactory = DbFactory._internal();

  DbFactory._internal();

  factory DbFactory() => _dbFactory;
  UserDb userDb = UserDb();
  FavouritesDb favouritesDb = FavouritesDb();
}

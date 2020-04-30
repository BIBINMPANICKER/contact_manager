import 'package:contact_manager/models/user_model.dart';
import 'package:contact_manager/resources/api_providers/map_api_provider.dart';

class Repository {
  final userApiProvider = UserApiProvider();

// fetch the map co-ordinates and its details
  Future<UserModel> getAllUsers() => userApiProvider.getAllUsers();

  Future<void> editUser(id, userModel) =>
      userApiProvider.editUser(id, userModel);

  Future<void> addUser(userModel) => userApiProvider.addUser(userModel);

  Future<void> deleteUser(id) => userApiProvider.deleteUser(id);
}

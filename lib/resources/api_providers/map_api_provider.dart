import 'package:contact_manager/models/user_model.dart';
import 'package:contact_manager/utils/object_factory.dart';
import 'package:contact_manager/utils/utils.dart';

class UserApiProvider {
  Future<UserModel> getAllUsers() async {
    final response = await ObjectFactory().apiClient.getAllUsers();

    if (response.statusCode == 200) {
      return UserModel.fromMap(response.data);
    } else {
      return null;
    }
  }

  Future<void> editUser(id, Datum userModel) async {
    final response =
        await ObjectFactory().apiClient.editUser(id, userModel.toMap());
    if (response.statusCode == 200) {
      showToast('Edited Successfully');
    } else {
      showToast('Some Error Occurred');
    }
  }

  Future<void> addUser(userModel) async {
    final response = await ObjectFactory().apiClient.addUser(userModel.toMap());
    if (response.statusCode == 200) {
      showToast('Added Successfully');
    } else {
      showToast('Some Error Occurred');
    }
  }

  Future<void> deleteUser(id) async {
    final response = await ObjectFactory().apiClient.deleteUser(id);
    if (response.statusCode == 200) {
      showToast('Deleted Successfully');
    } else {
      showToast('Some Error Occurred');
    }
  }
}

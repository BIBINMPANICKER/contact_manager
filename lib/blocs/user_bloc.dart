import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:contact_manager/models/user_model.dart';
import 'package:contact_manager/utils/db_factory.dart';
import 'package:contact_manager/utils/object_factory.dart';
import 'package:contact_manager/utils/utils.dart';

import 'base_bloc.dart';

class UserBloc extends BaseBloc {
  StreamController<UserModel> _userSink =
      new StreamController<UserModel>.broadcast();

  Stream<UserModel> get getUsers => _userSink.stream;

  Future<UserModel> getAllUsers() async {
    UserModel userResponse;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      userResponse = await ObjectFactory().repository.getAllUsers();
      if (userResponse != null) {
        _userSink.sink.add(userResponse);
        DbFactory().userDb.clearUserTable();
        DbFactory().userDb.saveUsers(userResponse);
      } else {
        _userSink..addError('Eooro occured');
      }
    } else {
      userResponse = await DbFactory().userDb.getAllUsers();
      _userSink.sink.add(userResponse);
    }

    return userResponse;
  }

  Future<void> editUser(id, userModel) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await ObjectFactory().repository.editUser(id, userModel);
    } else {
      showToast('Check your connectivity');
    }
  }

  Future<void> addUser(Datum userModel) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await ObjectFactory().repository.addUser(userModel);
    } else {
      showToast('Check your connectivity');
    }
  }

  Future<void> deleteUser(id) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await ObjectFactory().repository.deleteUser(id);
    } else {
      showToast('Check your connectivity');
    }
  }

  @override
  void dispose() {
    _userSink.close();
  }
}

final userBloc = UserBloc();

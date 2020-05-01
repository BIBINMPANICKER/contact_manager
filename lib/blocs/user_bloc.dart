import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:contact_manager/models/user_model.dart';
import 'package:contact_manager/utils/constants.dart';
import 'package:contact_manager/utils/db_factory.dart';
import 'package:contact_manager/utils/object_factory.dart';
import 'package:contact_manager/utils/utils.dart';

import 'base_bloc.dart';

class UserBloc extends BaseBloc {
  StreamController<UserModel> _userSink =
      new StreamController<UserModel>.broadcast();

  Stream<UserModel> get getUsers => _userSink.stream;

  //fetch all user details
  Future<UserModel> getAllUsers() async {
    UserModel userResponse;

    //checking the internet connectivity
    var connectivityResult = await (Connectivity().checkConnectivity());
    //if there is internet
    if (connectivityResult != ConnectivityResult.none) {
      userResponse = await ObjectFactory().repository.getAllUsers();
      if (userResponse != null) {
        _userSink.sink.add(userResponse);
        DbFactory().userDb.clearUserTable();
        DbFactory().userDb.saveUsers(userResponse);
      } else {
        _userSink..addError(Constants.SOME_ERROR_OCCURED);
      }
    } else {
      //if no connectivity, then data is loaded from local sqlite database
      userResponse = await DbFactory().userDb.getAllUsers();
      _userSink.sink.add(userResponse);
    }

    return userResponse;
  }

  //edit a user
  Future<void> editUser(id, userModel) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await ObjectFactory().repository.editUser(id, userModel);
    } else {
      showToast(Constants.CHECK_YOUR_CONNECTIVITY);
    }
  }

  Future<void> addUser(Datum userModel) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await ObjectFactory().repository.addUser(userModel);
    } else {
      showToast(Constants.CHECK_YOUR_CONNECTIVITY);
    }
  }

  Future<void> deleteUser(id) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await ObjectFactory().repository.deleteUser(id);
    } else {
      showToast(Constants.CHECK_YOUR_CONNECTIVITY);
    }
  }

  @override
  void dispose() {
    _userSink.close();
  }
}

final userBloc = UserBloc();

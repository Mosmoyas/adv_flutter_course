import 'dart:async';

import 'package:adv_flutter_course/presentation/base/base_view_model.dart';

import '../../../common/freezed_data_classess.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  var loginObject = LoginObject("", "");
  //Inputs
  @override
  void dispose() {
    // implement dispose
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }
  @override
  setUserName(String userName) {
    //implement setUserName
    InputUserName.add(userName);
    loginObject.copyWith(userName: userName);
  }

  @override
  setUserPassword(String password) {
    //implement setUserPassword
    InputPassword.add(password);
    loginObject.copyWith(password: password);
  }

  @override
  // implement InputPassword
  Sink get InputPassword => _passwordStreamController;

  @override
  // implement InputUserName
  Sink get InputUserName => _userNameStreamController;

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

//OutPuts
  @override
  //  implement outIsPasswordValid
  Stream<bool> get outIsPasswordValid =>
      _passwordStreamController.stream.map((password) => isPassword(password));

  @override
  //  implement outIsUserNameValid
  Stream<bool> get outIsUserNameValid =>
      _userNameStreamController.stream.map((userName) => isUserName(userName));
}

isPassword(String password) {
  return password.isNotEmpty;
}

isUserName(String userName) {
  return userName.isNotEmpty;
}

abstract class LoginViewModelInputs {
  setUserName(String userName);
  setUserPassword(String password);
  login();
  Sink get InputUserName;
  Sink get InputPassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
}

import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gerente_loja/core/models/user.dart';
import 'package:gerente_loja/core/providers/user_provider.dart';




class UserController extends BlocBase {

  UserProvider _provider = UserProvider();
  List<User> userList = List();
  bool _isDisposed = false;

  StreamController<List<User>> _userController = StreamController<
      List<User>>.broadcast();
  StreamController<User> _controllerSaveUser = StreamController<
      User>();

  //Stream gets the data from this StreamController(output)
  Stream<List<User>> get outProformas => _userController.stream;

  //Sink puts data into the StreamController(inPut)
  StreamSink<List<User>> get inProformas => _userController.sink;


  StreamSink<User> get saveProforma => _controllerSaveUser.sink;

  UserController() {
    _userController.add(userList);
    _controllerSaveUser.stream.listen(_saveUserData);
  }


  _saveUserData(User user) {
    _provider.saveUser(user);
    userList.add(user);
    inProformas.add(userList);
  }

  Future<void> getUsers() {
    if (_isDisposed) {
      return null;
    }
    return _provider.getUsers().then(
            (dados) {
          if (dados != null) {
            userList = dados;
            _userController.sink.add(dados);
          }
        }
    );
  }

  Future<User> getUserById(String uid)async {
    return await _provider.getUserById(uid);

  }


  @override
  void dispose() {
    _userController.close();
    _controllerSaveUser.close();
    _isDisposed = true;
    super.dispose();
  }
}
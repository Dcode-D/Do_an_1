import 'package:injectable/injectable.dart';

@injectable
class RequestFactory {
  RequestFactory();
   createLogin(String username, String password) {
    return {
      "username": username,
      "password": password,
    };
  }
}
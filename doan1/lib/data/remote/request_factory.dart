import 'package:injectable/injectable.dart';

@injectable
class RequestFactory {
  RequestFactory();
    createLogin(String username, String password) {
    return {
      "username": username,
      "password": password,
      "device": "mobile"
    };
  }

    createRegister(String username, String password,String email, String firstname, String lastname,String phone, String address,int gender) {
    return {
      "username": username,
      "password": password,
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "phone": phone,
      "address": address,
      "gender": gender
    };
  }
}
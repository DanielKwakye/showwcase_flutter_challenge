import 'package:showwcase_flutter_challenge/features/auth/domain/entities/auth_user.dart';

/// This model interacts with the json api.
/// Json Api is converted to Auth user for the application to use
class AuthUserModel extends AuthUser{

  const AuthUserModel({required name,required email, required password}) : super(name: name, email: email, password: password);

  factory AuthUserModel.fromJson(Map<String, dynamic> j){
    return AuthUserModel(
        name: j['name'],
        email: j['email'],
        password: j['password']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

}
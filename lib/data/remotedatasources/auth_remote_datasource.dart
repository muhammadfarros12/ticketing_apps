import 'package:dartz/dartz.dart';
import 'package:ticketing_apps/core/constants/variables.dart';
import 'package:ticketing_apps/data/localdatasources/auth_local_datasource.dart';
import 'package:ticketing_apps/model/request/login_request_model.dart';
import 'package:ticketing_apps/model/response/login_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, LoginResponseModel>> login(LoginRequestModel data) async {
    final response = await http.post(Uri.parse('${Variables.baseUrl}/api/login'),
    headers: <String,String> {
      'Content-Type' : 'application/json; charset=UTF-8',
      'Accept' : 'application/json'
    },
    body: data.toJson()
    );

    if (response.statusCode == 200) {
      return Right(LoginResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(Uri.parse('${Variables.baseUrl}/api/logout'),
    headers: <String,String> {
      'Content-Type' : 'application/json; charset=UTF-8',
      'Accept' : 'application/json',
      'Authorization' : 'Bearer ${authData.token}'
    },
    );
    if (response.statusCode == 200) {
      return Right('Logout success');
    } else{
      return Left(response.body);
    }


  }
}
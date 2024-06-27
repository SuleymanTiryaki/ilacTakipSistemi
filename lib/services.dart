import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'dart:convert';

import 'package:untitled1/data.dart';
final dio = Dio();
class UserService{

  final String url = "https://reqres.in/api/users?page=2";
Future<UsersModel?> fetcUsers() async{

final res =  await dio.get(url);

if(res.statusCode == 200){

   Logger().d(res.data);
   var jsonBody = UsersModel.fromJson(res.data);
   return(jsonBody);
}
 else{
print("istek başarısız=>${res.statusCode}" );
 }
}
  }

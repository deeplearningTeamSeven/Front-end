// #10
import 'package:ai_project/Login/kakao_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DietGraphDto {
  static final storage = FlutterSecureStorage();
  String userId;
   String start_date;
   String end_date; 
   

  DietGraphDto(this.userId, this.start_date,this.end_date);

  DietGraphDto.fromJson(Map<String, dynamic> json)
      : start_date = json['start_date'],
        end_date = json['end_date'],
        userId=json['user_id'];

  Future<Map<String, dynamic>> toJson() async =>
    {
      'user_id' : await storage.read(key: "user_id"),
      'start_date': start_date,
      'end_date': end_date,
      
    };
}
// #10
import 'package:ai_project/Login/kakao_login.dart';

class DietGraphDto {
  String userId;
   String start_date;
   String end_date; 
   

  DietGraphDto(this.userId, this.start_date,this.end_date);

  DietGraphDto.fromJson(Map<String, dynamic> json)
      : start_date = json['start_date'],
        end_date = json['end_date'],
        userId=json['user_id'];

  Map<String, dynamic> toJson() =>
    {
      'user_id' : KakaoLoginState.user_id,
      'start_date': start_date,
      'end_date': end_date,
      
    };
}
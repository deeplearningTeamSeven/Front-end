// #7
import 'package:ai_project/Login/kakao_login.dart';

class DietListDto {
   String created_at;
   String meal; 
   String userId;

  DietListDto(this.userId, this.created_at, this.meal);

  DietListDto.fromJson(Map<String, dynamic> json)
      : created_at = json['created_at'],
        meal = json['meal'],
        userId=json['user_id'];

  Map<String, dynamic> toJson() =>
    {
      'user_id' : KakaoLoginState.user_id,
      'created_at': created_at,
      'meal': meal,
      
    };
}
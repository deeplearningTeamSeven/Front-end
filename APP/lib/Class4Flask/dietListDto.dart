// #7
import 'package:ai_project/Login/kakao_login.dart';


class DietListDto {
   String created_at;
   int meal; 
   int userId;

  DietListDto(this.userId, this.created_at, this.meal);

  DietListDto.fromJson(Map<String, dynamic> json)   //받을때
      : created_at = json['created_at'],
        meal = json['meal'],
        userId=json['user_id'];

  Map<String, dynamic> toJson() =>    //보낼때
    {
      'user_id' : userId,
      'created_at': created_at,
      'meal': meal,
      
    };
}
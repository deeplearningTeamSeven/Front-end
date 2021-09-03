// #2

import 'package:ai_project/Login/kakao_login.dart';

class UserInfoDto {  //user_id, age, gender, height, weight, activity_level
   String age;
   String gender;
   String height;
   String weight;
   String activity_level; 
   String user_id;
  

  UserInfoDto(this.user_id, this.age, this.gender, this.height, this.weight, this.activity_level);

  UserInfoDto.fromJson(Map<String, dynamic> json)
      : user_id= json['user_id'],
        age = json['age'],
        gender = json['gender'],
        height = json['height'],
        weight = json['weight'],
        activity_level = json['activity_level'];
        
      

  Map<String, dynamic> toJson() =>
    {
      'user_id' : user_id,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'activity_level': activity_level
      
    };
}
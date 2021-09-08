//#6

import 'package:ai_project/Login/kakao_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Send6 {
   int user_id;
  //late List<FoodList> food_list;
   FoodList food_list;
   String created_at;
   int meal;

  Send6(this.user_id, this.food_list, this.created_at, this.meal);

  Send6.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    if (json['food_list'] != null) {
      //food_list = new List<FoodList>();
      json['food_list'].forEach((v) {
        //food_list.add(new FoodList.fromJson(v));
      });
    }
    created_at = json['created_at'];
    meal = json['meal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    if (this.food_list != null) {
      //data['food_list'] = this.food_list.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.created_at;
    data['meal'] = this.meal;
    return data;
  }
}

class FoodList {
   int no;
   String name;
   int amount;

  FoodList(this.no,  this.name,  this.amount);

  FoodList.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    name = json['name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['name'] = this.name;
    data['amount'] = this.amount;
    return data;
  }
}
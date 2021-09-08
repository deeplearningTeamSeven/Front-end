//#5

import 'package:ai_project/Login/kakao_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Send5 {
  int user_id;
  //late List<FoodList> food_list;
  List <FoodList> food_list;
  String created_at;
  int meal;

  Send5(this.user_id, this.food_list, this.created_at, this.meal);

  factory Send5.fromJson(Map<String, dynamic> json) {
    return Send5(json['user_id'] as int, json['food_list'], json['created_at'] as String,json['meal']as int);
    // user_id = json['user_id'] as int;
    // if (json['food_list'] != null) {
    //     //food_list = List<FoodList>;
    //   json['food_list'].forEach((v) {
    //       food_list.add(new FoodList.fromJson(v));
    //   });
    // }
    // created_at = json['created_at'] as String;
    // meal = json['meal'] as int;
  }

  Map toJson() {
    List<Map> food_list=
    this.food_list !=null ? this.food_list.map((i)=>i.toJson()).toList() :null;
    
    return{
      'user_id':user_id,
      'food_list':food_list,
      'created_at':created_at,
      'meal':meal
    };
  }
}

class FoodList {
  int no;
  String name;
  int amount;

  FoodList(this.no,  this.name,  this.amount);

  FoodList.fromJson(Map<String, dynamic> json):
      no =json['no'] as int,
      name = json['name'] as String,
      amount = json['amount'] as int;
   
   

  Map toJson() =>{
    'no' :this.no,
    'name' : this.name,
    'amount' : this.amount
   
  };
}
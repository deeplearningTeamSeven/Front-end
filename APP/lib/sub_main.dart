import 'package:ai_project/Class4Flask/dietGraphDto.dart';
import 'package:ai_project/Class4Flask/dietListDto.dart';
import 'package:ai_project/Login/kakao_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

import 'CheckDiet/check_diet.dart';
import 'StatsDiet/diet_graph.dart';
import 'RecommendDiet/diet_recommend.dart';
import 'MemberInfo/input_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 조회, 추천, 통계 페이지 전환을 위한 UI
class SubMain extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _SubMain();
  }
}

class _SubMain extends State<SubMain> with TickerProviderStateMixin {
  TabController _tabController;
  

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "식단조회",
        labels: const ["식단조회", "식단추천", "식단통계"],
        icons: const [
          Icons.restaurant_rounded,
          Icons.thumb_up_alt_rounded,
          Icons.add_chart_rounded,
        ],

        tabSize: 50, // 탭바 버튼 눌렀을 때 동그라미 크기
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 13,
          color: Colors.black,
          fontFamily: 'NanumSquare',
          fontWeight: FontWeight.w800,
        ),
        tabIconColor: Color(0xFF151026),
        tabIconSize: 28.0,

        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blue[900],
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.grey[300],
        onTabItemSelected: (int value) {     //추천 눌렀을 때 #11 호출,   식단통계 누르면 (시작 날짜: 현재 날짜, 끝날짜 : 현재 날짜로 해서 #10 호출),
        if(value==0){
          setState(() {                       
            _tabController.index = value;    //누른 페이지로 이동
          });

        }
          else if(value==1){
            receive4DietRecommend();   // #11
            setState(() {                       
            _tabController.index = value;    //누른 페이지로 이동
          });
          }else if(value==2){  //  #10
            //send4DietGraph();
            ///////// #10 호출하고 받은 데이터 변수에 저장해야함. 그리고 통계 페이지에서 활용해야함
            setState(() {                       
            _tabController.index = value;    //누른 페이지로 이동
          });

          }
          
          
        },
      ),
      body: TabBarView(
        dragStartBehavior: DragStartBehavior.start,
        physics:
            const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
        controller: _tabController,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const CheckDiet(), //식단조회 버튼 누를 시 CheckDiet 함수 실행
          const DietRecommend(),
          const DietGraph(), //식단통계 버튼 누를 시 DietGraph 함수 실행
        ],
      ),
    );
  }

  receive4DietRecommend() async{   //#11
    
    final url = 'http://3.35.167.225:8080/diet/recommend?user_id=i';
    print(Uri.parse(url));

    print(url);
    //sending a post request to the url

    final response = await http.get(Uri.parse(url));
          
  }

 /* send4DietGraph() async{   //#10
    DietGraphDto dietGraph = new DietGraphDto(KakaoLoginState.user_id, afdaf, asdfsf);  //시작날짜, 끝날짜 불러와서 넣어야함
    var DietGraphJson =  dietGraph.toJson();
    print(DietGraphJson);

    final url = 'http://3.38.106.149/diets/graph';
    print(Uri.parse(url));

    print(url);
    //sending a post request to the url

    final response = await http.post(Uri.parse(url), body: json.encode(DietGraphJson), headers: {'Content-Type':'application/json'});   
    print('hello');
    print(response.body); 
  }  */


}

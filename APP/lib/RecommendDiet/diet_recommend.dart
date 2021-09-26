import 'dart:io';

import 'package:ai_project/CheckDiet/add_diet.dart';
import 'package:ai_project/MemberInfo/management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:ai_project/CheckDiet/menu_button_ui.dart';

class DietRecommend extends StatefulWidget {           //#11에서 받은 정보들 출력
  const DietRecommend({ Key key }) : super(key: key);

  @override
  _DietRecommendState createState() => _DietRecommendState();
}

String getSystemTime(){
  var now = DateTime.now();
  return DateFormat("h:mm a").format(now);
}


class _DietRecommendState extends State<DietRecommend> {
  var date = DateTime.now();
  Color _iconColor1 = Colors.red;
  Color _iconColor2 = Colors.red;
  Color _iconColor3 = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('식단추천'),
        backgroundColor: Color(0xFF151026),
        centerTitle: true,
        elevation: 0.0, // 그림자생김
      ),
  
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(  //최상위 column 박스

          children: [
            Column(           //최상위 column 박스 안에서 가장 위에 있는 column 박스
              children: [
                //날짜 정보와 식사 추천 텍스트
                Row(
                  children: [
                    TimerBuilder.periodic(
                      Duration(days: 1), 
                      builder: (context){
                        print('${getSystemTime()}');
                        return Text(
                          DateFormat('EEEE, ').format(date),
                    
                        );
                      },
                    ),
                    
                    Text(
                      DateFormat('M/d/y').format(date),

                    ),
                    SizedBox(
              width: 90.0,
            ),
                    Container(
                      margin: const EdgeInsets.all(15.0),
                   padding: const EdgeInsets.all(3.0),
                   decoration: BoxDecoration(
                   border: Border.all(color: Colors.black)
                   ),
                      child: Text(                       //이전에 등록한 식사에 따라 달라짐
                        '저녁 추천'   
                      ),
                    )
                  ],
                  ),
                
              ],
            ),

            Column(               //섭취량 정보 텍스트,  2번째 위에 있는 column박스
              children: [
                SizedBox(
              height: 30.0,
            ),
                Text(
                  '단백질 섭취량이 목표치보다 40% 부족하네요!'
                ),
                Text(
                  '저녁에는 이런 음식들 어떠세요?'
                  ),
                SizedBox(
              height: 20.0,
            ),

              ],
            ),

            Column(     
              mainAxisAlignment: MainAxisAlignment.center,          //추천 음식 사진 3개 출력,  3번째 위에 있는 row박스
              children: [
                
                Container(
                   margin: const EdgeInsets.all(15.0),
                   padding: const EdgeInsets.all(3.0),
                   decoration: BoxDecoration(
                   border: Border.all(color: Colors.blueAccent)
                   ),

                  child: Row(               //첫번째 사진과 그 아래 영양 정보 있는 박스
                    children: [
                      Flexible(
                        child: Text(
                    '불고기'
                  ),
                      ),
                  SizedBox(
              width: 30.0,
            ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          '칼로리: 1000kcal'
                        ),
                        
                      ],
                    ),
                  ),
                  SizedBox(
              width: 50.0,
            ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        print("liked");               //누르면 #12호출, 일단 나중에 하자(다시 눌렀을 때 어케할지)
                        setState(() {
                          if(_iconColor1== Colors.red){
                            _iconColor1 = Colors.red.shade900;
                          }else{
                            _iconColor1 = Colors.red;
                          }
                          
                        });
                        
                      },
                      icon: Icon(Icons.favorite, color: _iconColor1),
                                
                      iconSize: 20.0,

                    ),
                  ),

                    ],
                    
                  ),
                ),
                SizedBox(
              height: 40.0,
            ),

                Container(
                   margin: const EdgeInsets.all(15.0),
                   padding: const EdgeInsets.all(3.0),
                   decoration: BoxDecoration(
                   border: Border.all(color: Colors.blueAccent)
                   ),

                  child: Row(               //첫번째 사진과 그 아래 영양 정보 있는 박스
                    children: [
                      Flexible(
                        child: Text(
                    '탕수육'
                  ),
                      ),
                  SizedBox(
              width: 30.0,
            ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          '칼로리: 1200kcal'
                        ),
                        
                      ],
                    ),
                  ),
                  SizedBox(
              width: 50.0,
            ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        print("liked");
                        setState(() {
                          if(_iconColor2== Colors.red){
                            _iconColor2 = Colors.red.shade900;
                          }else{
                            _iconColor2 = Colors.red;
                          }
                          
                        });
                        
                      },
                      icon: Icon(Icons.favorite, color: _iconColor2),
                                 
                      iconSize: 20.0,

                    ),
                  ),

                    ],
                    
                  ),
                ),
                SizedBox(
              height: 40.0,
            ),

                Container(
                   margin: const EdgeInsets.all(15.0),
                   padding: const EdgeInsets.all(3.0),
                   decoration: BoxDecoration(
                   border: Border.all(color: Colors.blueAccent)
                   ),

                  child: Row(               //첫번째 사진과 그 아래 영양 정보 있는 박스
                    children: [
                      Flexible(
                        child: Text(
                    '소시지'
                  ),
                      ),
                  SizedBox(
              width: 30.0,
            ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          '칼로리: 2000kcal'
                        ),
                        
                      ],
                    ),
                  ),
                  SizedBox(
              width: 50.0,
            ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        print("liked");
                        setState(() {
                          if(_iconColor3== Colors.red){
                            _iconColor3 = Colors.red.shade900;
                          }else{
                            _iconColor3 = Colors.red;
                          }
                          
                        });
                        
                      },
                      icon: Icon(Icons.favorite, color: _iconColor3),
                               
                      iconSize: 20.0,

                    ),
                  ),

                    ],
                    
                  ),
                ),
                

              ],
            ),

          ],
        )
      )
      
    );
  }
}
import 'dart:ffi';

import 'package:ai_project/Class4Flask/dietListDto.dart';
import 'package:ai_project/Class4Flask/userInfoDto.dart';
import 'package:ai_project/Login/kakao_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import '../sub_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 첫 시작시 회원 정보 입력 받기
class InputInfo extends StatefulWidget {
  String additional_text;
  int pressed_save_button;
  InputInfo(
      {Key key,
       this.additional_text,
       this.pressed_save_button})
      : super(key: key);

  @override
  _InputInfoState createState() => _InputInfoState();
}

class _InputInfoState extends State<InputInfo> {
  // late List<int> no;
  // late List<Double> cal; 
  // late List<String> name; 
  // late List<int> amount;

//가짜 데이터
  // late List<int> no = [9298];
  // late List<double> cal = [245.0]; 
  // late List<String> name = ['베이컨']; 
  // late List<int> amount = [1];
  
  static final storage = FlutterSecureStorage();
  int gender_current_seg = 0;
  int activity_index_current_seg = 0;
  //String userId = '1';
  int meal = 4;  //아침점심저녁 전부 출력하도록
  var created_at= DateTime.now();           
  //
   int gender;
   int activity;


  // 사용가자 입력한 값 가져오기 위한 컨트롤러
  TextEditingController member_height = TextEditingController();
  TextEditingController member_weight = TextEditingController();
  TextEditingController member_age = TextEditingController();

  final Map<int, Widget> gender_segments = const <int, Widget>{
    0: Text('남자'),
    1: Text('여자'),
  };

  final Map<int, Widget> activity_index_segments = const <int, Widget>{
    0: Text('비활동적'),
    1: Text('저활동적'),
    2: Text('활동적'),
    3: Text('매우 활동적')
  };

  void text_print() {
    print('====================textfield 정보====================');
    print('키:' + member_height.value.text.toString());
    print('몸무게:' + member_weight.value.text.toString());
    print('나이:' + member_age.value.text.toString());
    print('성별:' + gender_segments[gender_current_seg].toString());
    print('활동 지수:' +
        activity_index_segments[activity_index_current_seg].toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('회원정보입력'), 
          backgroundColor: Color(0xFF151026),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        // color: Colors.red,
                        margin: const EdgeInsets.all(50),
                        child: Text(
                          widget.additional_text,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'NanumSquare',
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: 1.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey[350],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 40),
                        // alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '키',
                              style: TextStyle(
                                  fontSize: 17, fontFamily: 'NanumSquare'),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: member_height,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13)),
                                  ),
                                  labelText: 'cm'
                                  ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              '체중',
                              style: TextStyle(
                                  fontSize: 17, fontFamily: 'NanumSquare'),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: member_weight,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13)),
                                  ),
                                  labelText: 'kg'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              '나이',
                              style: TextStyle(
                                  fontSize: 17, fontFamily: 'NanumSquare'),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: member_age,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13)),
                                  ),
                                  labelText: '세'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              '성별',
                              style: TextStyle(
                                  fontSize: 17, fontFamily: 'NanumSquare'),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Expanded(
                                child: CupertinoSlidingSegmentedControl<int>(
                                    padding: EdgeInsets.all(0),
                                    groupValue: gender_current_seg,
                                    children: gender_segments,
                                    onValueChanged: (i) {
                                      setState(() {
                                        gender_current_seg = i;
                                      });
                                    }),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              '활동지수',
                              style: TextStyle(
                                  fontSize: 17, fontFamily: 'NanumSquare'),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Expanded(
                                child: CupertinoSlidingSegmentedControl<int>(
                                    padding: EdgeInsets.all(0),
                                    groupValue: activity_index_current_seg,
                                    children: activity_index_segments,
                                    onValueChanged: (i) {
                                      setState(() {
                                        activity_index_current_seg = i;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  // width: double.infinity,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: FlatButton(
                    color: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      // side: BorderSide(color: Color(0xFF151026), width: 5),
                    ),
                    onPressed: () {                  ////////////// #2으로  users PUT 먼저 하고, if 200일떄 메인화면으로 이동하면서, #7을 호출한다
                    if(gender_segments[gender_current_seg].toString()=='Text("남자")'){
                      gender = 2;
                    }else if(gender_segments[gender_current_seg].toString()=='Text("여자")'){
                      gender = 1;
                    }

                    if(activity_index_segments[activity_index_current_seg].toString()=='Text("비활동적")'){
                      activity = 1;

                    }else if(activity_index_segments[activity_index_current_seg].toString()=='Text("저활동적")'){
                      activity = 2;

                    }
                    else if(activity_index_segments[activity_index_current_seg].toString()=='Text("활동적")'){
                      activity = 3;
                      
                    }
                    else if(activity_index_segments[activity_index_current_seg].toString()=='Text("매우 활동적")'){
                      activity = 4;
                      
                    }
                      sendUserInfo();   //#2
                      
                    },
                    child: Text(
                      '저장',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'NanumSquareRound',
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  sendUserInfo() async{   //#2
    //String? user_id = await storage.read(key: "user_id");
   
    UserInfoDto userInfo = new UserInfoDto(3, int.parse(member_age.value.text), gender, double.parse(member_height.value.text), double.parse(member_weight.value.text), activity);
    var userInfoJson = userInfo.toJson();
    text_print();
    print(gender);
    print(activity);
    print(userInfoJson);
    print(json.encode(userInfoJson));

    final url = 'http://3.35.167.225:8080/users/';
    print(Uri.parse(url));

    print(url);
    //sending a post request to the url

    final response = await http.put(Uri.parse(url), body: json.encode(userInfoJson), headers: {'Content-Type':'application/json'});   
    print('hello1');
    print(response.body);
    print(response.statusCode); //

    if (response.statusCode==200){
      Map userMap=jsonDecode(response.body);
      print(userMap);    //success 떠야함
      sendMainPage();
      //String userId = userMap['user_id'].toString();
      
      //await storage.write(key: 'userid', value:userId);
    } 
  }

 sendMainPage() async{   //#7
  
  //#7호출
  //String? user_id = await storage.read(key: "user_id");
//DateFormat('M/d/y').format(date),
  DietListDto dietList = new DietListDto(3, DateFormat('y-M-d').format(created_at).toString(), meal);   //2번째 인자에 created_at에 들어갈 날짜 정보 생성해서 넣어야함, meal은 디폴트 값 4
  var DietListJson = dietList.toJson();
  print(DietListJson);
  print(json.encode(DietListJson));

  final url = 'http://3.35.167.225:8080/diets/list';
  print(Uri.parse(url));

  print(url);
  //sending a post request to the url

  final response = await http.post(Uri.parse(url), body: json.encode(DietListJson), headers: {'Content-Type':'application/json'});   
  print('hello2');
  print(response);
  print(response.body);
  print('hello3');

  ///////////////////////////////////// 여기에 서버에서 온 값들 변수에 저장해놔야함 #7    
  Map userMap=jsonDecode(response.body);    //response를 디코딩해서 변수에 저장
  print(userMap);
  print('hello4');

  /////////////////////////////////////////불러올 때 for문
  
  // var diet_list = userMap['diet_list'];
  // print(diet_list);
  // if(dietList == null){
  // //for (int i=0; i<=diet_list.length-1;  i++){  
  //   for (int i=0; i<1;  i++){ 
  //     no[i] = diet_list[i]['no'];
  //     cal[i] = diet_list[i]['cal'];
  //     name[i] = diet_list[i]['name'];
  //     amount[i] = diet_list[i]['amount']; 

  //     }                                       
  //     print(no[0]);
  //   }


  widget.pressed_save_button == 0
  ? Navigator.of(context).pushReplacement(    //서버에서 준 데이터들을 변수에 다 저장한 후, 메인 화면으로 이동
      MaterialPageRoute(
          builder: (context) => SubMain()))    //메인화면으로 이동
  : Navigator.of(context).pop();




  }

  recieveMainPage() async{    // #7 호출하고 데이터들 받고 변수에 저장
    

  }


}

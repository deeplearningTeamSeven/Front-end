import 'dart:convert';
import 'dart:io';

import 'package:ai_project/CheckDiet/add_diet.dart';
import 'package:ai_project/CheckDiet/edit_diet.dart';
import 'package:ai_project/CheckDiet/edit_diet2.dart';
import 'package:ai_project/CheckDiet/image_load_button.dart';
import 'package:ai_project/DataBase1/db2.dart';
import 'package:ai_project/DataBase1/user_diet.dart';
import 'package:ai_project/Class4Flask/dietListDto.dart';
import 'package:ai_project/Login/kakao_login.dart';
import 'package:ai_project/MemberInfo/management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'menu_button_ui.dart';
import 'package:http/http.dart' as http;
import 'package:ai_project/DataBase1/user_diet.dart';

// 조회 페이지 UI
class CheckDiet extends StatefulWidget {
  const CheckDiet({Key key}) : super(key: key);
  @override
  CheckDietState createState() => CheckDietState();
}

class CheckDietState extends State<CheckDiet> with AutomaticKeepAliveClientMixin {   //다른 페이지 갔다 와도 정보가 그대로 저장돼있음
  String _date = "날짜 선택";
  CupertinoTabBar tabBar;

  String month;
  String day;

  String deleteId;

  

  var checkDate = DateTime.now(); 
  static String chosenMealtime = '';

  final DBHelper2 dbHelper = DBHelper2();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //dbHelper.initlizeDatabase();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('SixSense'),
        backgroundColor: Color(0xFF151026),
        centerTitle: true,
        elevation: 0.0, // 그림자생김
        actions: <Widget>[
          IconButton(
            onPressed: () {
              print('shopping_cart button is clicked');
              Navigator.push(context,   //회원버튼 눌렀을때 회원정보 페이지 이동
                  MaterialPageRoute(builder: (context) => Management()));
            },
            icon: Icon(Icons.person, size: 30),
            padding: EdgeInsets.only(right: 15, left: 15),
            // 왼쪽도 패딩을 같이 줘야 터치반응액션이 아이콘 중앙에 있게됨
          ),
        ], // 1개 이상의 위젯 리스트를 가짐
      ),
      floatingActionButton: ImageLoadButton(),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        height: 42,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            datePicker(context);
                          },
                          icon: const Icon(
                            Icons.date_range,
                            color: Colors.black,
                            size: 20,
                          ),
                          label: Text(    //날짜선택 버튼
                            _date,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                width: 1.5, color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: NormalMenuButton(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      height: 42,
                      width: 70,
                      child: RaisedButton(
                        child: const Text(
                          '조회',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'NanumSquareRound',
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {  //정보들 입력하고 조회버튼 누르면, #7 호출 후 다시 업데이트된 메인 화면으로
                          //sendMainPage();
                        

                          Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => CheckDiet()    //업데이트 된 정보들을 가지고 다시 메인화면으로
                            
                            ), (route) => false);

                        },               
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.red[100],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              height: 1.5,
              width: MediaQuery.of(context).size.width - 20,
              color: Colors.grey[350],
            ),                          //회색 구분 선
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            Expanded(                                  
                child: dietBuilder(context)
    //SingleChildScrollView(     //여기서부터 스크롤 기능 시작
    //             scrollDirection: Axis.vertical,
    //             child: Column(
    //               children: List.generate(text.length,(index){
    //         return Text(text[index].toString());
    //       }
    // //                 children: [
                      
    // //                   Container(                  //앨범에서 가져온 사진 띄워지는 곳, 
    // //                       decoration: BoxDecoration(
    // //                         border: Border.all(color: Colors.grey, width: 1.5),
    // //                         //borderRadius: const BorderRadius.all(Radius.circular(15)),
    // //                       ),
    // //                       margin: EdgeInsets.only(top: 20),
    // //                       // color: Colors.amber,
    // //                       width: 350,
    // //                       height: 510,
    // //                       child: Column(
    // //                         children: [
    // //                           Row(
    // //                             children: [
    // //                               Text(
    // //                                  DateFormat('y-M-d').format(checkDate).toString() +   '  아침 ' +   ' 칼로리: 1000kcal'     // 여기서 칼로리는 음식 각각의 칼로리 합한거...
    // //                               ),
    // //                               IconButton(
    // //                                 onPressed: () {          //삭제 버튼 누르면 #9번 호출, userid랑 dietid를 준다
    // //                                   print("delete diet");  
    // //                                   send4DeleteDiet();      
    // //                                   /////// 식단 정보가 지워지면 화면에도 없어지도록 해야함               
    // //                                 },
    // //                               icon: Icon(Icons.remove_circle, color: Colors.red),
    // //                               iconSize: 20.0,
    // //                               ),
    // //                             ],
    // //                           ),
    // //                           Padding(
    // //                             padding: const EdgeInsets.all(8.0),
    // //                             child: InkWell(
    // //                               onTap: (){     //메인 페이지에서 사진을 누르면 #8호출, editdiet2페이지로 이동
    // //                                 chosenMealtime = '아침';
    // //                                 send4EditDiet2();   // #8 호출

    // //                                 change2EditDiet2();                
    // //                               },
    // //                               child: ClipRRect(
    // //                                 borderRadius: BorderRadius.circular(15),
                                    
    // //                                 child:  Image.file(
                                      
    // //                                         WriteDietState.image4checkdiet1,                ///////////////////// 널 체크 문제 발생!!!!!!!!!
    // //                                         fit: BoxFit.fill,
    // //                                       ),
    // //                               ),
    // //                             ),
    // //                           ),
                              
    // //                         ],
    // //                       ),
    // //                     ),
                    
                  
                
    // //                   Container(                  //앨범에서 가져온 사진 띄워지는 곳, 
    // //                       decoration: BoxDecoration(
    // //                         border: Border.all(color: Colors.grey, width: 1.5),
    // //                         //borderRadius: const BorderRadius.all(Radius.circular(15)),
    // //                       ),
    // //                       margin: EdgeInsets.only(top: 20),
    // //                       // color: Colors.amber,
    // //                       width: 350,
    // //                       height: 510,
    // //                       child: Column(
    // //                         children: [
    // //                           Row(
    // //                             children: [     //이미지와 함께 저장돼 있는 날짜, 칼로리 정보 띄워지게 해야함
    // //                               Text(
    // //                                '   디폴트날짜       점심      칼로리: 1000kcal'
    // //                               ),
    // //                               IconButton(
    // //                                 onPressed: () {
    // //                                   print("delete diet");                       
    // //                                 },
    // //                               icon: Icon(Icons.remove_circle, color: Colors.red),
    // //                               iconSize: 20.0,
    // //                               ),
    // //                             ],
    // //                           ),
    // //                           Padding(
    // //                             padding: const EdgeInsets.all(8.0),
    // //                             child: InkWell(
    // //                               onTap: (){
    // //                                 chosenMealtime = '점심';
    // //                                 send4EditDiet2();   // #8 호출
    // //                                 change2EditDiet2();
    // //                               },
    // //                               child: ClipRRect(
    // //                                 borderRadius: BorderRadius.circular(15),
                                    
    // //                                 child:  Image.file(
                                      
    // //                                         WriteDietState.image4checkdiet2,                ///////////////////// 널 체크 문제 발생!!!!!!!!!
    // //                                         fit: BoxFit.fill,
    // //                                       ),
    // //                               ),
    // //                             ),
    // //                           ),
                              
    // //                         ],
    // //                       ),
    // //                     ),

    // //                   Container(                  //앨범에서 가져온 사진 띄워지는 곳, 
    // //                       decoration: BoxDecoration(
    // //                         border: Border.all(color: Colors.grey, width: 1.5),
    // //                         //borderRadius: const BorderRadius.all(Radius.circular(15)),
    // //                       ),
    // //                       margin: EdgeInsets.only(top: 20),
    // //                       // color: Colors.amber,
    // //                       width: 350,
    // //                       height: 510,
    // //                       child: Column(
    // //                         children: [
    // //                           Row(
    // //                             children: [
    // //                               Text(
    // //                                '   디폴트날짜       저녁      칼로리: 1000kcal'
    // //                               ),
    // //                               IconButton(
    // //                                 onPressed: () {
    // //                                   print("delete diet");                       
    // //                                 },
    // //                               icon: Icon(Icons.remove_circle, color: Colors.red),
    // //                               iconSize: 20.0,
    // //                               ),
    // //                             ],
    // //                           ),
    // //                           Padding(
    // //                             padding: const EdgeInsets.all(8.0),
    // //                             child: InkWell(
    // //                               onTap: (){
    // //                                 chosenMealtime = '저녁';
    // //                                 send4EditDiet2();   // #8 호출
    // //                                 change2EditDiet2();
    // //                               },
    // //                               child: ClipRRect(
    // //                                 borderRadius: BorderRadius.circular(15),
                                    
    // //                                 child:  Image.file(
                                      
    // //                                         WriteDietState.image4checkdiet3,                ///////////////////// 널 체크 문제 발생!!!!!!!!!
    // //                                         fit: BoxFit.fill,
    // //                                       ),
    // //                               ),
    // //                             ),
    // //                           ),
                              
    // //                         ],
    // //                       ),
    // //                     ),

                        
                  
                
                
    // //         ],
    // // //      ),
    //     ),
    //             ),
    //           ),
           ),

            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(
            //       child: Container(                  //앨범에서 가져온 사진 띄워지는 곳, 
            //         decoration: BoxDecoration(
            //           border: Border.all(color: Colors.grey, width: 1.5),
            //           borderRadius: const BorderRadius.all(Radius.circular(15)),
            //         ),
            //         margin: EdgeInsets.only(top: 20),
            //         // color: Colors.amber,
            //         width: 200,
            //         height: 200,
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(15),
                      
            //           child:  Image.file(
                        
            //                   WriteDietState.image4checkdiet,                ///////////////////// 널 체크 문제 발생!!!!!!!!!
            //                   fit: BoxFit.fill,
            //                 ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  dateChange(){
    month = WriteDietState.month_value.toString();
    day = WriteDietState.day_value.toString();
  }

  datePicker(context) {
    DatePicker.showDatePicker(context,
        theme: DatePickerTheme(
          containerHeight: 210.0,
        ),
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: DateTime(2030), onConfirm: (date) {
      print('confirm $date');
      _date = '${date.year}/${date.month}/${date.day}';
      setState(() {
        Text(_date);
      });
    }, currentTime: DateTime.now(), locale: LocaleType.ko);
    return _date;
  }

  change2EditDiet2() {
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(
          builder: (BuildContext context) => EditDiet2()    
      
      ), (route) => false);
  }

  /*sendMainPage() async{   //#7
  //#7호출
    DietListDto dietList = new DietListDto(KakaoLoginState.user_id, dsfda, meal);   //2번째 인자에 created_at에 들어갈 날짜 정보 생성해서 넣어야함, meal은 디폴트 값 4
    var DietListJson = dietList.toJson();
    print(DietListJson);

    final url = 'http://3.38.106.149/users/';
    print(Uri.parse(url));

    print(url);
    //sending a post request to the url

    final response = await http.post(Uri.parse(url), body: json.encode(DietListJson), headers: {'Content-Type':'application/json'});   
    print('hello');
    print(response.body);

    ///////////////////////////////////// 여기에 서버에서 온 값들 변수에 저장해놔야함 #7    많이 복잡하네;;
  } */
  
  send4DeleteDiet() async{   // #9 호출
    final url = 'http://3.35.167.225:8080/diets?diet_id=i&user_id=j';
    print(Uri.parse(url));

    print(url);
    //sending a post request to the url

    final response = await http.delete(Uri.parse(url));   
    print('hello');
    print(response.body);

  }

  send4EditDiet2() async{   // #8
    final url = 'http://3.35.167.225:8080/diets?diet_id=i';
    print(Uri.parse(url));

    print(url);
    //sending a post request to the url

    final response = await http.get(Uri.parse(url));   
    print('hello');
    print(response.body);

    // 사진, 음식이름, 칼로리, 인분 정보 변수에 저장 후 dietedit2 화면에 출력
  }

  Future<List<UserDiet>> loadDiet() async{
    DBHelper2 sd = DBHelper2();   //dbhelper부르고
    return await sd.diets();   //dbhelper에서 diets 부르고
  }

 Future<void> deleteDiet(String id) async{
    DBHelper2 sd = DBHelper2();   //dbhelper부르고
    return await sd.deleteDiet(id);   //dbhelper에서 diets 부르고
  }

  

  void showAlertDialog(BuildContext context) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 경고'),
          content: Text("정말 삭제하실거에요?"),
          actions: <Widget>[
            FlatButton(
              child: Text('삭제'),
              onPressed: () {
                Navigator.pop(context, "삭제");
                setState(() {
                  deleteDiet(deleteId);
                });
                deleteId = null;
              },
            ),
            FlatButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context, "취소");
              },
            ),
          ],
        );
      },
    );
  }

  Widget dietBuilder(BuildContext parentContext){
    return FutureBuilder(
    builder: (context, Snap) {
      if (Snap.data == null || Snap.data.isEmpty) {
        return Container(child: Text("식단을 지금 바로 추가해보세요"));
      }
      return ListView.builder(
        itemCount: (Snap.data as List).length,
        itemBuilder: (context, index) {
          UserDiet diet = (Snap.data as List)[index];
          return InkWell(
            onTap: (){
              Navigator.push(
                parentContext, CupertinoPageRoute(builder: (parentContext) => EditDiet2(id: diet.id, imageFile: diet.imageFile,))
              );
              print(diet.imageFile);
              //print(File(diet.imageFile));
            },
            onLongPress: (){
              print('Long Press');
              deleteId = diet.id;
              showAlertDialog(parentContext);
              

              },
            child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white10,
              border: Border.all(
              color: Colors.brown,
              width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Text(diet.mealTime),
                    SizedBox(width: 30),
                    Text(diet.mealDate),
                    SizedBox(width: 30),
                    //Text(diet.imageFile),
                    Text(diet.cal.toString()+ " kcal"),
                  ],
                ),
                Container(                  //앨범에서 가져온 사진 띄워지는 곳
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.5),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    margin: EdgeInsets.only(top: 20),
                    // color: Colors.amber,
                    width: 300,
                    height: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      
                      child:  Image.file(
                        
                            
                              File(diet.imageFile),                ///////////////////// 널 체크 문제 발생!!!!!!!!!
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
              ],
            ),
          )

          );
        },
      );
    },
    future: loadDiet(),
  );
}


}



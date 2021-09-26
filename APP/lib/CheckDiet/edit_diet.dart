import 'dart:io';
import 'dart:math';
import 'package:ai_project/Class4Flask/send5.dart';
import 'package:ai_project/DataBase1/db2.dart';
import 'package:ai_project/Login/kakao_login.dart';
import 'package:ai_project/MemberInfo/management.dart';
import 'package:ai_project/SearchDiet/search_bar1.dart';
import 'package:ai_project/SearchDiet/search_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ai_project/sub_main.dart';
import 'package:ai_project/CheckDiet/check_diet.dart';
import 'package:ai_project/CheckDiet/image_load_button.dart';
import 'package:ai_project/CheckDiet/add_diet.dart';
import 'package:ai_project/CheckDiet/edit_diet2.dart';
import 'package:ai_project/CheckDiet/inboon_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ai_project/DataBase1/user_diet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

class EditDiet extends StatefulWidget {
  //const EditDiet({ Key key }) : super(key: key);
  //final UserDiet diet;
  //EditDiet({this.diet});
  //AddNote({this.note});
  

  @override
  EditDietState createState() => EditDietState();
}

class EditDietState extends State<EditDiet> {
  static const storage = FlutterSecureStorage();

  String mealTime = '';
  String mealDate = '2021-09-13';
  File imageFile;
  int cal = 3081;

  static String diet_id = "";
  FoodList food_list = FoodList(323,  '사과',  1);              

  static String changedCalValue = WriteDietState.cal.toString(); 

  final DBHelper2 helper = DBHelper2();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SixSense'),
        backgroundColor: Color(0xFF151026),
        centerTitle: true,
        elevation: 0.0, // 그림자생김
        actions: <Widget>[
          IconButton(
            onPressed: () {
              print('button is clicked');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Management()));
            },
            icon: Icon(Icons.person, size: 30),
            padding: EdgeInsets.only(right: 15, left: 15),
            // 왼쪽도 패딩을 같이 줘야 터치반응액션이 아이콘 중앙에 있게됨
          ),
        ], // 1개 이상의 위젯 리스트를 가짐
      ),
       body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(          
                child: Container(                  //앨범에서 가져온 사진 띄워지는 곳
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.5),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    margin: EdgeInsets.only(top: 20),
                    // color: Colors.amber,
                    width: 200,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      
                      child:  Image.network(
                              WriteDietState.ai_image,
                        
                              //'https://sixsense20210819.s3.ap-northeast-2.amazonaws.com/4_2021-09-26%2006:18:00.029546',
                              //File(WriteDietState.ai_image),                ///////////////////// 널 체크 문제 발생!!!!!!!!!
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
              ),
              SizedBox(
              height: 50.0,
            ),


              Expanded(                                  ///////////
                child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
                    //WriteDietState.name        //서버에서 받은 음식 이름 정보 출력
                    '치즈피자'
                  ),
                      ),
                  SizedBox(
              width: 20.0,
            ),
            Flexible(
                        child: NormalMenuButton2()
                      ),
                  SizedBox(
              width: 20.0,
            ),
            
                  Container(
                    child: Column(
                      children: [
                        Text(
                          '2128 kcal'
                        )            /////////////////////////////////////////////
                        
                      ],
                    ),
                  ),
                  SizedBox(
              width: 10.0,
            ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        print("delete diet");                       
                      },
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                                
                      iconSize: 20.0,

                    ),
                  ),

                    ],
                    
                  ),
                ),
            //     Container(
            //       margin: const EdgeInsets.all(15.0),
            //        padding: const EdgeInsets.all(3.0),
            //        decoration: BoxDecoration(
            //        border: Border.all(color: Colors.blueAccent)
            //        ),

            //       child: Row(               //첫번째 사진과 그 아래 영양 정보 있는 박스
            //         children: [
            //           Flexible(
            //             child: Text(
            //         //WriteDietState.name        //서버에서 받은 음식 이름 정보 출력
            //         '사과주스'
            //       ),
            //           ),
            //       SizedBox(
            //   width: 20.0,
            // ),
            // Flexible(
            //             child: NormalMenuButton2()
            //           ),
            //       SizedBox(
            //   width: 20.0,
            // ),
            
            //       Container(
            //         child: Column(
            //           children: [
            //             Text(
            //               changedCalValue + ' kcal'    //서버에서 받은 칼로리 정보 출력
            //             ),
                        
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //   width: 20.0,
            // ),
            //       Container(
            //         child: IconButton(
            //           onPressed: () {
            //             print("delete diet");                       
            //           },
            //           icon: Icon(Icons.remove_circle, color: Colors.red),
                                
            //           iconSize: 20.0,

            //         ),
            //       ),

            //         ],
                    
            //       ),
            //     ),
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
                    //WriteDietState.name        //서버에서 받은 음식 이름 정보 출력
                    '스파게티'
                  ),
                      ),
                  SizedBox(
              width: 20.0,
            ),
            Flexible(
                        child: NormalMenuButton2()
                      ),
                  SizedBox(
              width: 20.0,
            ),
            
                  Container(
                    child: Column(
                      children: [
                        Text(
                           '953 kcal'    //서버에서 받은 칼로리 정보 출력
                        ),
                        
                      ],
                    ),
                  ),
                  SizedBox(
              width: 20.0,
            ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        print("delete diet");                       
                      },
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                                
                      iconSize: 20.0,

                    ),
                  ),

                    ],
                    
                  ),
                ),
            //     Container(
            //       margin: const EdgeInsets.all(15.0),
            //        padding: const EdgeInsets.all(3.0),
            //        decoration: BoxDecoration(
            //        border: Border.all(color: Colors.blueAccent)
            //        ),

            //       child: Row(               //첫번째 사진과 그 아래 영양 정보 있는 박스
            //         children: [
            //           Flexible(
            //             child: Text(
            //         //WriteDietState.name        //서버에서 받은 음식 이름 정보 출력
            //         '오이피클'
            //       ),
            //           ),
            //       SizedBox(
            //   width: 20.0,
            // ),
            // Flexible(
            //             child: NormalMenuButton2()
            //           ),
            //       SizedBox(
            //   width: 20.0,
            // ),
            
            //       Container(
            //         child: Column(
            //           children: [
            //             Text(
            //               WriteDietState.cal.toString() + ' kcal'     //서버에서 받은 칼로리 정보 출력
            //             ),
                        
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //   width: 20.0,
            // ),
            //       Container(
            //         child: IconButton(
            //           onPressed: () {
            //             print("delete diet");                       
            //           },
            //           icon: Icon(Icons.remove_circle, color: Colors.red),
                                
            //           iconSize: 20.0,

            //         ),
            //       ),

            //         ],
                    
            //       ),
            //     ),
            //     Container(
            //       margin: const EdgeInsets.all(15.0),
            //        padding: const EdgeInsets.all(3.0),
            //        decoration: BoxDecoration(
            //        border: Border.all(color: Colors.blueAccent)
            //        ),

            //       child: Row(               //첫번째 사진과 그 아래 영양 정보 있는 박스
            //         children: [
            //           Flexible(
            //             child: Text(
            //         //WriteDietState.name        //서버에서 받은 음식 이름 정보 출력
            //         '감자튀김'
            //       ),
            //           ),
            //       SizedBox(
            //   width: 20.0,
            // ),
            // Flexible(
            //             child: NormalMenuButton2()
            //           ),
            //       SizedBox(
            //   width: 20.0,
            // ),
            
            //       Container(
            //         child: Column(
            //           children: [
            //             Text(
            //               WriteDietState.cal.toString() + ' kcal'     //서버에서 받은 칼로리 정보 출력
            //             ),
                        
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //   width: 20.0,
            // ),
            //       Container(
            //         child: IconButton(
            //           onPressed: () {
            //             print("delete diet");                       
            //           },
            //           icon: Icon(Icons.remove_circle, color: Colors.red),
                                
            //           iconSize: 20.0,

            //         ),
            //       ),

            //         ],
                    
            //       ),
            //     ),
            ],
    //      ),
        ),
              ),
           ),
           SizedBox(
              height: 10.0,
            ),

           Container(
            
              
                       child: Row( 
                         children: [ //스크롤 할 수 있는 공간 밑에 완료랑 추가 버튼 있도록
                         SizedBox(
              width: 90.0,
            ),
                            Container(
                              // margin: EdgeInsets.only(right: 18, left: 18, top: 5),
                              // // color: Colors.green
                              // width: MediaQuery.of(context).size.width,
                              child: FlatButton(
                                color: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  // side: BorderSide(color: Color(0xFF151026), width: 5),
                                ),
                                onPressed: () {   //완료 버튼 눌렀을 때   #5번 호출, 메인 페이지로 이동
                                  print('완료버튼 pressed');
                                  imageFileSave();
                                  //pickImage2(ImageSource.gallery);
                                  //print('식단조회 페이지에 등록되는 이미지');
                                  //print(new_image);
                                  //image4checkdiet= ImageLoadButtonState.image!;
                                  //print(image4checkdiet);
                                  send4EditDiet();    // #5 호출하고
                                  //// diet_id 받아서 저장
                                  saveDB();

                                  change2MainPage();     //메인 화면으로 이동

                              },                
                              child: const Text(
                                '완료',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'NanumSquareRound',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            ),
                            SizedBox(
                              width: 50.0,
                            ),

                            Container(
                              // margin: EdgeInsets.only(right: 18, left: 18, top: 5),
                              // // color: Colors.green
                              // width: MediaQuery.of(context).size.width,
                              child: FlatButton(
                                color: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  // side: BorderSide(color: Color(0xFF151026), width: 5),
                                ),
                                onPressed: () {   //추가 버튼 눌렀을 때
                                  print('추가버튼 pressed');
                                  //pickImage2(ImageSource.gallery);
                                  //print('식단조회 페이지에 등록되는 이미지');
                                  //print(new_image);
                                  //image4checkdiet= ImageLoadButtonState.image!;
                                  //print(image4checkdiet);
                                  //change2SubMain();
                                  send4DietSearch();  // #13호출
                                  change2SearchDiet();  //검색 창으로 이동, 거기서 음식 누르면, 받은 데이터 변수에 저장해서 화면에 그 음식이 추가되게 해야함


                              },                
                              child: const Text(
                                '추가',                       //추가(식단 검색) 버튼을 눌렀을때는 #13호출, 
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'NanumSquareRound',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            ),
                         ],
                       ),
                     //),
           ),
           SizedBox(
              height: 10.0,
            ),
           
            ],
       ),
    
    );
  }

  Future<void> saveDB() async{
    transferMealTime();
    imageFileSave();
    //idDetection();

    DBHelper2 sd = DBHelper2();

    var fido = UserDiet(                    /////////////////////////////////////////////////////////////////////   id  
      id: Str2sha512(DateTime.now().toString()), 
      mealTime: this.mealTime, 
      mealDate: this.mealDate,
      imageFile: this.imageFile.path,
      cal: this.cal,
    
    );
    print('hi');

    await sd.insertDiet(fido);
    print(await sd.diets());
     
      // widget.diet.mealTime = WriteDietState.mealTime;
      // widget.diet.mealDate = '2021-09-07';
      // helper.updateDiet(widget.diet);
    
    // Navigator.pushAndRemoveUntil(context,
    //   MaterialPageRoute(
    //       builder: (BuildContext context) => SubMain()  
    //       ), (route) => false);
  }

  change2MainPage() {
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(
          builder: (BuildContext context) => SubMain()    
      
      ), (route) => false);
  }

  send4EditDiet() async{   // #5
  print('------------------------------------------------------------#5');
  List<FoodList> food_list=[];
  food_list.add(FoodList(246,'쌀밥',1));
  food_list.add(FoodList(345,"미역국",1));
  var prefs=await SharedPreferences.getInstance();
  final user_id = prefs.getInt('user_id') ?? 0;
  //String created_at="2021-"+WriteDietState.month_value.toString()+"-"+WriteDietState.day_value.toString();
  String created_at = "2021-09-03";
  print(created_at);
  Send5 send5 = new Send5(user_id, food_list,created_at, 3);   //1은 아침   
  var DietListJson = send5.toJson();
  print(DietListJson);
  print(json.encode(DietListJson));

  final url = 'http://3.35.167.225:8080:8080/diets/';
  print(Uri.parse(url));

  print(url);
  //sending a post request to the url

  final response = await http.post(Uri.parse(url), body: json.encode(DietListJson), headers: {'Content-Type':'application/json'});   
  print('hello2');
  print(response);
  print(response.body);
  print('hello3');
  print(response.statusCode);

  if (response.statusCode==200){
        Map userMap=jsonDecode(response.body);    //response를 디코딩해서 변수에 저장
        print(userMap);
        diet_id = userMap['diet_id'].toString();   
        await storage.write(key: 'userid', value: diet_id);   //diet_id 기기에 저장

      }
  }

  send4DietSearch() async{   // #13
    var queryParams=json.encode({
      'food_name':"떡볶이"
    });
    final url = 'http://3.35.167.225:8080/diets/search?food_name=$queryParams';
    print(Uri.parse(url));

    print(url);
    //sending a post request to the url

    final response = await http.get(Uri.parse(url));    //요 response를 검색 창에서 쓸 수 있게 해야함
    print('hello');
    print(response.body);
  }

  change2SearchDiet() {
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(
          builder: (BuildContext context) => ExamplePage()    
      
      ), (route) => false);
  }

  changeCalValText(){
    setState(() {
      Text(WriteDietState.cal.toString() + ' kcal');
    });

  }

  transferMealTime(){
    if(WriteDietState.mealTime == '아침'){
      mealTime = '아침';
    }else if(WriteDietState.mealTime == '점심'){
      mealTime = '점심';
    }else if(WriteDietState.mealTime == '저녁'){
      mealTime = '저녁';
    }
  }

  imageFileSave(){
    imageFile = WriteDietState.image4checkdiet;
  }

 



  String Str2sha512(String text) {
  var bytes = utf8.encode(text); // data being hashed

  var digest = sha512.convert(bytes);

  return digest.toString();


}

  


}
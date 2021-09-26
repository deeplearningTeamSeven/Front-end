import 'dart:io';
import 'package:ai_project/CheckDiet/edit_diet.dart';
import 'package:ai_project/MemberInfo/management.dart';
import 'package:ai_project/SearchDiet/search_bar1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ai_project/sub_main.dart';
import 'package:ai_project/CheckDiet/check_diet.dart';
import 'package:ai_project/CheckDiet/image_load_button.dart';
import 'package:ai_project/CheckDiet/add_diet.dart';
import 'package:ai_project/SearchDiet/search_bar2.dart';
import 'package:ai_project/CheckDiet/inboon_button.dart';
import 'package:http/http.dart' as http;

class EditDiet2 extends StatefulWidget {
  const EditDiet2({ Key key, this.id, this.imageFile }) : super(key: key);

  final String id;
  final String imageFile;
  //findDiet(id)[0]

  @override
  EditDiet2State createState() => EditDiet2State();
}

class EditDiet2State extends State<EditDiet2> {
  @override
  initState() {
  // 부모의 initState호출
  super.initState();
  // 이 클래스애 리스너 추가
  imageFileSave();
}
  
  String FinalImageFile;

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
                      
                      child:  Image.file(
                        
                              File(FinalImageFile),             /////////////////////////// 문제 ///////////////////////////////////
                                        
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
              ),
              SizedBox(
              height: 50.0,
            ),


              Expanded(
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
                    '미역국'
                  ),
                      ),
                  SizedBox(
              width: 40.0,
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
                          '칼로리: 297kcal'
                        ),
                        
                      ],
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
            //         '불고기'
            //       ),
            //           ),
            //       SizedBox(
            //   width: 40.0,
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
            //               '칼로리: 1000kcal'
            //             ),
                        
            //           ],
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
                    '흰쌀밥 '
                  ),
                      ),
                  SizedBox(
              width: 40.0,
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
                          '칼로리: 304kcal'
                        ),
                        
                      ],
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
            //         '미역국'
            //       ),
            //           ),
            //       SizedBox(
            //   width: 40.0,
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
            //               '칼로리: 300kcal'
            //             ),
                        
            //           ],
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
            //         '파김치'
            //       ),
            //           ),
            //       SizedBox(
            //   width: 40.0,
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
            //               '칼로리: 100kcal'
            //             ),
                        
            //           ],
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
                                onPressed: () {   //수정 버튼 눌렀을 때 #6호출 후 메인 페이지 이동 
                                  print('수정버튼 pressed');
                                  print(widget.imageFile);
                                  //pickImage2(ImageSource.gallery);
                                  //print('식단조회 페이지에 등록되는 이미지');
                                  //print(new_image);
                                  //image4checkdiet= ImageLoadButtonState.image!;
                                  //print(image4checkdiet);
                                  send4SubmitDiet();  // #6 호출
                                  change2SubMain();  //메인 화면으로 이동

                              },                
                              child: const Text(
                                '수정',
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
                                onPressed: () {   //추가 버튼 눌렀을 때  # 13호출
                                  print('추가버튼 pressed');
                                  //pickImage2(ImageSource.gallery);
                                  //print('식단조회 페이지에 등록되는 이미지');
                                  //print(new_image);
                                  //image4checkdiet= ImageLoadButtonState.image!;
                                  //print(image4checkdiet);
                                  send4DietSearch();  // #13호출
                                  change2SearchDiet();  //검색 창으로 이동, 거기서 음식 누르면, 받은 데이터 변수에 저장해서 화면에 그 음식이 추가되게 해야함

                              },                
                              child: const Text(
                                '추가',
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

  change2SubMain() {
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(
          builder: (BuildContext context) => SubMain()    
      
      ), (route) => false);
  }

  change2SearchDiet() {
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(
          builder: (BuildContext context) => ExamplePage2()    
      
      ), (route) => false);
  }

  send4DietSearch() async{
    final url = 'http://3.35.167.225:8080/diets/search?food_name=i';
    print(Uri.parse(url));

    print(url);
    //sending a post request to the url

    final response = await http.get(Uri.parse(url));    //요 response를 검색 창에서 쓸 수 있게 해야함
    print('hello');
    print(response.body);
  }

  send4SubmitDiet(){   // #6 호출
  


  }

  mealTimeCase(){
    if(WriteDietState.image4checkdiet == null){
    if(CheckDietState.chosenMealtime == '아침'){
      WriteDietState.image4checkdiet;              ///////////////////// 널 체크 문제 발생!!!!!!!!!
      fit: BoxFit.fill;
    }
    }
  }

  imageFileSave(){
    print('EditDiet2 page entered');
    print('# '+ widget.imageFile + ' #');
    print(File(widget.imageFile));
    FinalImageFile = widget.imageFile;
    //FinalImageFile = FinalImageFile.substring(7,FinalImageFile.length-1);
    print(FinalImageFile);
    

  }

  


}
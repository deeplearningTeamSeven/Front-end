import 'dart:convert';
import 'dart:io';
import 'package:ai_project/CheckDiet/edit_diet.dart';
import 'package:ai_project/MemberInfo/management.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ai_project/sub_main.dart';
import 'package:ai_project/CheckDiet/check_diet.dart';
import 'package:ai_project/CheckDiet/image_load_button.dart';
import 'package:ai_project/CheckDiet/edit_diet.dart';
import 'package:http/http.dart' as http;


// 식단 추가 작성 페이지 (인공지능에 들어가기 전 페이지)
class WriteDiet extends StatefulWidget {
  final File food_image;          ////////////
  const WriteDiet({Key key, this.food_image}) : super(key: key);         //////////////

  @override
  WriteDietState createState() => WriteDietState();
}

class WriteDietState extends State<WriteDiet> {
  List<String> button_value = ["아침", "점심", "저녁"];
  static TextEditingController month_value = TextEditingController();   //month_value.toString() 으로 나중에 이 정보 불러오기
  static TextEditingController day_value = TextEditingController();     //day_value.toString() 으로 나중에 이 정보 불러오기
  File new_image; // 다시 선택하기 버튼 누를 때 불러올 이미지 변수
  static File image4checkdiet;  //식단조회 페이지로 보낼 이미지 변수   ***null로 만들수 없어서 file.txt넣어둠   
  static String ai_image = 'https://sixsense20210819.s3.ap-northeast-2.amazonaws.com/4_2021-09-26%2006:18:00.029546';

  
  

  

  static double cal = 31.0;
  //static String name = '수박';
  static int amount = 1;

  static String mealTime = '';  
  static int mealTimeVal;    

  static String imageFile = '';
  

  Future pickImage(ImageSource imageSource) async {
    try {
      PickedFile f = await ImagePicker.platform.pickImage(source: imageSource);
      File img_file = File(f.path);
      print(img_file);
      setState(() => new_image = img_file);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // Future pickImage2(ImageSource imageSource) async {
  //   try {
  //     PickedFile? f = await ImagePicker.platform.pickImage(source: imageSource);
  //     File img_file = File(f!.path);
  //     print(img_file);
  //     setState(() => image4checkdiet = ImageLoadButtonState.image);
  //     print('이미지 선택 완료');
  //   } on PlatformException catch (e) {
  //     print('Failed to picl image: $e');
  //   }
  // }

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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
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
                  width: 300,
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: new_image != null
                        ? Image.file(
                            new_image,
                            fit: BoxFit.fill,
                          )
                        : Image.file(
                            widget.food_image,      ///////
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.5),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                // color: Colors.yellow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('다시 선택하기'),
                    OutlinedButton(
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },
                      child: const Text(
                        '카메라',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'NanumSquare',
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 1.5, color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // <-- Radius
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                      },
                      child: const Text(
                        '갤러리',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'NanumSquare',
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 1.5, color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // <-- Radius
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2.5,
                color: Colors.grey[300],
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      '날짜',
                      style: TextStyle(fontSize: 15, fontFamily: 'NanumSquare'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4, left: 8),
                        child: SizedBox(
                          width: 45,
                          height: 40,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: month_value,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                hintText: '월'),
                          ),
                        ),
                      ),
                      const Text(
                        '월',
                        style:
                            TextStyle(fontSize: 15, fontFamily: 'NanumSquare'),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4, left: 8),
                        child: SizedBox(
                          width: 45,
                          height: 40,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: day_value,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                hintText: '일'),
                          ),
                        ),
                      ),
                      const Text(
                        '일',
                        style:
                            TextStyle(fontSize: 15, fontFamily: 'NanumSquare'),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "식사 시간",
                      style: TextStyle(fontSize: 15, fontFamily: 'NanumSquare'),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    GroupButton(
                      mainGroupAlignment: MainGroupAlignment.start,
                      crossGroupAlignment: CrossGroupAlignment.start,
                      groupRunAlignment: GroupRunAlignment.start,
                      isRadio: true,
                      spacing: 10,
                      buttons: button_value,
                      onSelected: (index, isSelected) {
                        print('$index button is selected ' + button_value[index]);
                        mealTime = button_value[index];     //식사 시간 정보 저장
                        print(mealTime);

                      },
                      selectedTextStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      selectedColor: Colors.grey[100],
                      unselectedBorderColor: Colors.grey[500],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 18, left: 18, top: 5),
                // color: Colors.green
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    // side: BorderSide(color: Color(0xFF151026), width: 5),
                  ),
                  onPressed: () {       
                                                 //등록 버튼 눌렀을 때 날짜랑 식사시간 저장한 상태에서 #4번 호출 /predict로 이미지 file AI모델에 전달
                    print('등록버튼 pressed');
                    //transferMealTime();
                    //pickImage2(ImageSource.gallery);
                    //print('식단조회 페이지에 등록되는 이미지');
                    //print(new_image);
                    image4checkdiet= ImageLoadButtonState.image;
                    print(image4checkdiet.toString());
                    send4predict();  // #4
                   
                    /// 음식명, 이름, 칼로리 정보 변수에 저장 후 editDiet 페이지에 출력할 수 있게함
                    
                    

                    change2EditDiet();  // editdiet 페이지로 이동

                  },                
                  child: const Text(
                    '등록',
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
        ),
      ),
    );
  }
  change2EditDiet() {
    
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(
          builder: (BuildContext context) => EditDiet()    
      
      ), (route) => false);
    
  }

  send4predict() async{    // #4   이미지 파일을 어떤 형식으로 보내야지?
    print('send4predict');
    Dio dio = new Dio();   //dio 객체 생성
    final url = 'http://3.35.167.225:8080/predict';
    print(Uri.parse(url));
    print(widget.food_image.path);

    FormData formData = new FormData.fromMap({   
      "user_id": '3',  //user_id
      "file": await MultipartFile.fromFile(widget.food_image.path, filename: "food_image.jpg")    
    });

    Response response = await dio.post(url , data: formData);
      print(response.statusCode);
      print(response);
      print(response.data['img_url']);
      
      print('hello');
      ai_image = response.data['img_url'];
      print(ai_image);
   
  }



  ///////////////////////////////////// 여기에 서버에서 온 값들 변수에 저장해놔야함     
  //  // Map userMap=jsonDecode(response.body);    //response를 디코딩해서 변수에 저장
  //   print(userMap);
  //   print('hello4');
  //   //diet_list = userMap['diet_list'].toString();
  //   cal = userMap['food']['cal'].toString();
  //   name = userMap['food']['name'].toString();
  //   amount = userMap['food']['amount'].toString();

  // }
  transferMealTime(){
    if(mealTime == '아침'){
      mealTimeVal = 1;
    }else if(mealTime == '점심'){
      mealTimeVal = 2;
    }else if(mealTime == '저녁'){
      mealTimeVal = 3;
    }
  }
  


}

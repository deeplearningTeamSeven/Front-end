import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'package:ai_project/MemberInfo/input_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ai_project/Class4Flask/userDto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KakaoLogin extends StatefulWidget {    //로그인 기능 & ui
  const KakaoLogin({Key key}) : super(key: key);

  @override
  KakaoLoginState createState() => KakaoLoginState();
}

class KakaoLoginState extends State<KakaoLogin> {
  SharedPreferences prefs;
  static final storage = new FlutterSecureStorage();
  
  static String userName = "";
  static String userEmail = "";
  int user_id;             ///

  @override
  void initState() {
    super.initState();
    _initKakaoTalkInstalled();
  }

  // 카카오톡 설치 여부 확인
  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    print('kakao installed = $installed');
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  bool _isKakaoTalkInstalled = true;

  _loginWithKakao() async {    //카톡 설치돼있는지 확인후 로그인 화면ㄱ, 카톡이 없으면 웹페이지에서 로그인할 수 있게 함
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
      print('code:$code');
    } catch (e) {
      print(e);
    }
  }

  // 카카오 어플로 설치      
  _loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
      print('code:$code');
    } catch (e) {
      print(e);
    }
  }
   String name;
  _getUserId() async {
    prefs=await SharedPreferences.getInstance();
    User user = await UserApi.instance.me();
    setState(() {
      name = user.kakaoAccount?.profile?.toJson()['nickname'];
      prefs.setString('userName',name);
    });
    print('이름: '+ name);
    return name;
  }

  _getUserEmail() async {
    prefs=await SharedPreferences.getInstance();
    User user = await UserApi.instance.me();
    print('이메일 주소: ' + user.kakaoAccount.email.toString());
    String email=user.kakaoAccount.email.toString();
    prefs.setString('email',email);
    return user.kakaoAccount.email.toString();
  }

  _getUserInfo() async {
    User user = await UserApi.instance.me();
    print(
        "=========================[kakao account]=================================");
    // print(user.kakaoAccount.toString());
    // userid 나오는 곳
    String id = user.toString();
    print(user.toString());
    print(id[0]);
    print(
        "=========================[kakao account]=================================");
  }

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      
      AccessTokenStore.instance.toStore(token);
      //print(token.toString());
      await _getUserInfo();
      var userName = await _getUserId();
      var userEmail = await _getUserEmail();
      // await storage.write(key: 'userName', value: userName); 
      // await storage.write(key: 'email', value: userEmail);
      
      
      
      
    
      UserDto user = new UserDto(userName,userEmail);
      var userJson=user.toJson();
      print(userJson);

 
   
      //post request

      //url to send the post request to 
      final url = 'http://3.35.167.225:8080/login/';
      print(Uri.parse(url));
      
      print(url);
      //sending a post request to the url
 
      final response = await http.post(Uri.parse(url), body: json.encode(userJson), headers: {'Content-Type':'application/json'});   
      print('hello');
      print(response.body);

      if (response.statusCode==200){
        Map userMap=jsonDecode(response.body);    //response를 디코딩해서 변수에 저장
        print(userMap);
        user_id = userMap['user_id'];   
        //SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('user_id',user_id);

        await storage.write(key: 'userid', value: user_id.toString());   //user_id 기기에 저장         

        Navigator.pushReplacement(
        context,
        MaterialPageRoute(        
            builder: (context) => InputInfo(
                  additional_text: userName +'님! 개인 맞춤 서비스를 위해\n신체 정보를 꼭 입력해주세요!',
                  pressed_save_button: 0,
                )),
      );
      }else{
        print('response statusCode is not 200');
        //어떻게 처리하지?

      }      
    } catch (e) {
      print("error on issuing access token: $e");
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(        
      //       builder: (context) => InputInfo(
      //             additional_text: '개인 맞춤 서비스를 위해\n신체 정보를 꼭 입력해주세요!',
      //             pressed_save_button: 0,
      //           )),
      // );
    } 
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color(0xFF151026),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('식단관리 어플이 처음이라면?'),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CupertinoButton(
                  onPressed:
                      _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
                  child: Image.asset(
                    'image/kakao_login_large_wide.png',
                    width: 300,
                    height: 50,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}

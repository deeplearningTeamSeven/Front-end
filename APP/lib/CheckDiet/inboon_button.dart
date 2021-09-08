import 'package:ai_project/CheckDiet/add_diet.dart';
import 'package:ai_project/CheckDiet/edit_diet.dart';
import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';

// 조회페이지에서 선택할 식사 시간 메뉴 버튼 UI
class NormalMenuButton2 extends StatefulWidget {
  const NormalMenuButton2({
    Key key,
  }) : super(key: key);

  @override
  NormalMenuButton2State createState() => NormalMenuButton2State();
}

class NormalMenuButton2State extends State<NormalMenuButton2> {
   BoxDecoration decoration;

   String selectedKey;
  static double selectedKeyValue = 1;

  List<String> keys = <String>['1/4인분', '1/2인분', '3/4인분', '1인분', '2인분'];

  @override
  void initState() {
    selectedKey = '인분';    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget normalChildButton = Container(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                selectedKey,
                style: const TextStyle(color: Colors.black, fontSize: 14),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              width: 12,
              height: 17,
              child: const FittedBox(
                fit: BoxFit.fill,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MenuButton<String>(
          child: normalChildButton,
          items: keys,
          topDivider: true,
          itemBuilder: (String value) => Container(
            height: 40,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
            child: Text(value),
          ),
          toggledChild: Container(
            child: normalChildButton,
          ),
          divider: Container(
            height: 1,
            color: Colors.grey,
          ),
          onItemSelected: (String value) {
              selectedKey = value;
              selectAmountchangeCal();
            
          },
          onMenuButtonToggle: (bool isToggle) {
            print(isToggle);
          },
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          menuButtonBackgroundColor: Colors.transparent,
        ),
      ],
    );
  }

  selectAmountchangeCal(){
    if(selectedKey == '1/4인분'){
      selectedKeyValue = 0.25;
      setState(() {
        EditDietState.changedCalValue = (WriteDietState.cal * selectedKeyValue).toString();
      });
    }else if(selectedKey == '1/2인분'){
      selectedKeyValue = 0.5;
      setState(() {
        EditDietState.changedCalValue = (WriteDietState.cal * selectedKeyValue).toString();
      });
    }else if(selectedKey == '3/4인분'){
      selectedKeyValue = 0.75;
      setState(() {
        EditDietState.changedCalValue = (WriteDietState.cal * selectedKeyValue).toString();
      });
    }else if(selectedKey == '1인분'){
      selectedKeyValue = 1;
      setState(() {
        EditDietState.changedCalValue = (WriteDietState.cal * selectedKeyValue).toString();
      });
    }else if(selectedKey == '2인분'){
      selectedKeyValue = 2;
      setState(() {
        EditDietState.changedCalValue = (WriteDietState.cal * selectedKeyValue).toString();
      });
    }
    print(selectedKeyValue);
    print(EditDietState.changedCalValue);
  }
}

class UserDiet {
  final String id;
  final String mealTime;
  final String mealDate;
  final String imageFile;
  final int cal;

  UserDiet({this.id, this.mealTime, this.mealDate, this.imageFile, this.cal});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mealTime': mealTime,
      'mealDate': mealDate,
      'imageFile': imageFile,
      'cal': cal,
    };
  }

  // 각 memo 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'Memo{id: $id, mealTime: $mealTime, mealDate: $mealDate, imageFile: $imageFile, cal: $cal}';
    //return 'Memo{id: $id, mealTime: $mealTime, mealDate: $mealDate}';
  }
}

//#1

class UserDto {
   String name;
   String email; 
    int userId;

  UserDto(this.name, this.email);

  UserDto.fromJson(Map<String, dynamic> json)
      : name = json['user_name'],
        email = json['email'],
        userId=json['user_id'];

  Map<String, dynamic> toJson() =>
    {
      'email': email,
      'user_name': name,
      
    };
}



class UserData {
  final String? email;
  final String? phone;
  final String? password;
  final String? iin;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? birthDate;

  const UserData({
    this.email,
    this.phone,
    this.iin,
    this.firstName,
    this.middleName,
    this.lastName,
    this.birthDate,
    this.password,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        email:json['email'],
        phone:json['phone'],
        iin: json['uid'],
        firstName: json['firstName'],
        middleName: json['patronomic'],
        lastName: json['lastName'],
        birthDate: json['dateOfBirth'],
        password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    email !=null ? data['email'] = email : {};
    phone !=null ? data['phone'] = phone : {};
    iin !=null ? data['uid'] = iin : {};
    firstName !=null ? data['firstName'] = firstName : {};
    middleName !=null ? data['patronomic'] = middleName : {};
    lastName !=null ? data['lastName'] = lastName : {};
    birthDate !=null ? data['dateOfBirth'] = birthDate : {};
    password !=null ? data['password']= password : {};
    return data;
  }
}

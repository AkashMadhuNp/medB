class UserModel {
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String contactNo;
  final String password;
  final String confirmPassword;

  UserModel({
    required this.firstName,
    this.middleName = '',  
    required this.lastName,
    required this.email,
    required this.contactNo,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'firstName': firstName.trim(),
      'lastName': lastName.trim(),
      'email': email.trim().toLowerCase(),
      'contactNo': contactNo.trim(),
      'password': password,
      'confirmPassword': confirmPassword,
    };
    
    if (middleName.isNotEmpty) {
      json['middleName'] = middleName.trim();
    }
    
    return json;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      contactNo: json['contactNo'] ?? '',
      password: '', 
      confirmPassword: '', 
    );
  }
}
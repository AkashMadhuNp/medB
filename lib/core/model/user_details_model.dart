class UserDetails {
  final String id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String contactNo;
  final bool isEmailVerified;

  UserDetails({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.contactNo,
    required this.isEmailVerified,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'] ?? json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      contactNo: json['contactNo'] ?? '',
      isEmailVerified: json['isEmailVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'contactNo': contactNo,
      'isEmailVerified': isEmailVerified,
    };
  }
}


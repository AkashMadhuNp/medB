class UserDetails {
  final String id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String contactNo;
  final bool isEmailVerified;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserDetails({
    required this.id,
    required this.firstName,
    this.middleName = '',
    required this.lastName,
    required this.email,
    required this.contactNo,
    this.isEmailVerified = false,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
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
      profileImage: json['profileImage'],
      createdAt: json['createdAt'] != null 
          ? DateTime.tryParse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.tryParse(json['updatedAt']) 
          : null,
    );
  }

  String get fullName {
    final names = [firstName, middleName, lastName]
        .where((name) => name.isNotEmpty)
        .join(' ');
    return names;
  }
}
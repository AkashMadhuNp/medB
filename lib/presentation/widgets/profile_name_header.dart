import 'package:flutter/material.dart';

class ProfileNameHeader extends StatelessWidget {
  final String? firstName;
  final String? lastName;

  const ProfileNameHeader({
    super.key,
    this.firstName,
    this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    String displayName = "User's Profile";
    if (firstName != null && lastName != null) {
      displayName = "$firstName $lastName's Profile";
    } else if (firstName != null) {
      displayName = "$firstName's Profile";
    }

    return Text(
      displayName,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
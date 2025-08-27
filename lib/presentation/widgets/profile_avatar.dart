import 'package:flutter/material.dart';
import 'package:medb/core/colors/colors.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.grey,
          width: 3,
        ),
      ),
      child: CircleAvatar(
        radius: 80,
        backgroundColor: AppColors.surface,
        child: Image.asset("assets/profile_img.png",height: 100,width: 100,fit: BoxFit.cover,)
      ),
    );
  }
}
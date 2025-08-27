import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:medb/core/colors/colors.dart';

class ForgotPasswordLink extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onTap;

  const ForgotPasswordLink({
    super.key,
    required this.isLoading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: isLoading ? null : onTap,
        child: isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 14 * 1.2,
                  width: 'Forgot Password?'.length * 14 * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              )
            : Text(
                'Forgot Password?',
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryBlue,
                ),
              ),
      ),
    );
  }
}
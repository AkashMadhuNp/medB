import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:medb/core/colors/colors.dart';

class SignUpLink extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onTap;

  const SignUpLink({
    super.key,
    required this.isLoading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading)
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 16 * 1.2,
                width: 'Don\'t have an account? Sign Up'.length * 16 * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            )
          else ...[
            Text(
              'Don\'t have an account? ',
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Text(
                'Sign Up',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isLoading;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (isLoading)
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: Theme.of(context).textTheme.bodyLarge!.fontSize! * 1.2,
                width: title.length * Theme.of(context).textTheme.bodyLarge!.fontSize! * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            )
          else
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          const SizedBox(height: 8),
          if (isLoading)
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 14 * 1.2,
                width: subtitle.length * 14 * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            )
          else
            Text(
              subtitle,
              style: GoogleFonts.lato(
                fontSize: 14,
                color: Colors.black54,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
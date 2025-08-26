import 'package:flutter/material.dart';

class MedBLogo extends StatelessWidget {
  const MedBLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, 
      children: [
        Image.asset(
          "assets/medb_logo.png", 
          height: 180, 
          width: 180,  
          fit: BoxFit.contain,
        ),
        
        
        // RichText(
        //   text: TextSpan(
        //     style: GoogleFonts.poppins(
        //       fontSize: 14, // Reduced from 18
        //       fontWeight: FontWeight.w500,
        //       height: 1.2, // Tighter line height
        //     ),
        //     children: [
        //       TextSpan(
        //         text: "Bringing ",
        //         style: GoogleFonts.poppins(
        //           color: Colors.black87,
        //         ),
        //       ),
        //       TextSpan(
        //         text: "Healthcare",
        //         style: GoogleFonts.poppins(
        //           color: AppColors.primaryBlue,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //       TextSpan(
        //         text: " to your finger tips",
        //         style: GoogleFonts.poppins(
        //           color: Colors.black87,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTextField extends StatelessWidget {
  const ShimmerTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    double containerHeight = screenHeight * 0.07; 
    
    containerHeight = containerHeight.clamp(48.0, 64.0);
    
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: containerHeight,
        width: screenWidth * 0.9, 
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
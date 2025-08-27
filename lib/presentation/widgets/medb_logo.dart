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
        
        
        
      ],
    );
  }
}
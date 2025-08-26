import 'package:flutter/material.dart';
import 'package:medb/core/colors/colors.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;

  const GradientScaffold({
    super.key,
    required this.body,
    this.appBar,
     required bool resizeToAvoidBottomInset,  Drawer? drawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.lightblue,
              Color(0xFFF0F9FA),
              Colors.white
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: body,
        
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:medb/core/colors/colors.dart';
import 'package:medb/presentation/widgets/base_drawer_appbar_layout.dart';
import 'package:medb/presentation/widgets/custom_elevated_buttons.dart'; 

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      currentScreen: 'Appointments',
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.lblu,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: CustomElevatedButton(
                text: "Book Appoinment",
                onPressed: () {
                  
                  
                },
                ),
            ),
          ),
        ),
      )
    );
  }}
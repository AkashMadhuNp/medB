import 'package:flutter/material.dart';
import 'package:medb/presentation/widgets/base_drawer_appbar_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      currentScreen: 'Home',
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Center(
              child: Image.asset("assets/medb_logo.png", height: 100, width: 100)
            ),
            Text(
              "Welcome to MedB !",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              "We are glad to have you here. MedB is your\ntrusted platform for healthcare needs - all in one place ",
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              "Use the menu on the left to get started ",
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
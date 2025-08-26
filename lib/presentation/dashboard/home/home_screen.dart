import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medb/core/colors/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
} 

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedItem = 'Home'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, 
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false, 
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.surface,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: CircleAvatar(
              backgroundColor: AppColors.grey,
              child: IconButton(
                icon: const Icon(Icons.menu, size: 25, color: AppColors.surface),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();  
                },
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: AppColors.lightblue),
          title: Image.asset("assets/m_logo.png", height: 50, width: 50),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.grey,
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                        }, 
                        icon: const Icon(Icons.notifications, size: 25, color: AppColors.surface)
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: AppColors.grey,
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                        }, 
                        icon: const Icon(Icons.exit_to_app, size: 25, color: AppColors.surface)
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      drawer: SizedBox(
        width: 250,
        child: Drawer(
          backgroundColor: AppColors.grey, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.grey, 
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Center(child: Image.asset("assets/m_logo.png", height: 70, width: 70)),
                      const SizedBox(height: 8),
                      
                    ],
                  ),
                ),
              ),
              
              // Drawer items without automatic divider
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                   
                    _buildDrawerItem(
                      icon: Icons.event,
                      title: 'Appointments',
                      isSelected: selectedItem == 'Appointments',
                      onTap: () {
                        setState(() {
                          selectedItem = 'Appointments';
                        });
                        Navigator.pop(context);
                        // Add navigation logic here
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.health_and_safety,
                      title: 'Health Records',
                      isSelected: selectedItem == 'Health Records',
                      onTap: () {
                        setState(() {
                          selectedItem = 'Health Records';
                        });
                        Navigator.pop(context);
                        // Add navigation logic here
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.person,
                      title: 'Account',
                      isSelected: selectedItem == 'Account',
                      onTap: () {
                        setState(() {
                          selectedItem = 'Account';
                        });
                        Navigator.pop(context);
                        // Add navigation logic here
                      },
                    ),
                    
                    // Add some spacing before logout
                    const SizedBox(height: 20),
                    
                    _buildDrawerItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      isSelected: false, // Lo
                      onTap: () {
                        Navigator.pop(context);
                        // Add logout logic here
                      },
                      isLogout: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

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
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: isSelected 
          ? AppColors.background 
          : Colors.transparent,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        leading: Icon(
          icon, 
          color: isSelected 
            ? AppColors.ButtonColor 
            :  AppColors.black, 
          size: 24,
        ),
        title: Text(
          title,
          style: GoogleFonts.lato(
            color: isSelected 
              ? AppColors.ButtonColor
              :  AppColors.black, 
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
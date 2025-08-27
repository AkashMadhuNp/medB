import 'package:flutter/material.dart';
import 'package:medb/core/colors/colors.dart';
import 'package:medb/presentation/widgets/base_drawer_appbar_layout.dart';

class HealthRecordsScreen extends StatefulWidget {
  const HealthRecordsScreen({super.key});

  @override
  State<HealthRecordsScreen> createState() => _HealthRecordsScreenState();
}

class _HealthRecordsScreenState extends State<HealthRecordsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      currentScreen: 'Health Records',
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.lblu,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "My Records",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.lblu,
                  unselectedLabelColor: Colors.white,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                  tabs: const [
                    Tab(text: 'Prescriptions'),
                    Tab(text: 'Health Files'),
                  ],
                ),
              ),
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildMedicalRecordsTab(),
                      _buildTestResultsTab(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMedicalRecordsTab() {
    return  Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text("No Prescriptions Available")),
    );
  }

  Widget _buildTestResultsTab() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text("No Health Files Uploaded Yet")),
    );
  }
}
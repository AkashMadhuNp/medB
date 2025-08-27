import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medb/core/colors/colors.dart';
import 'package:medb/presentation/widgets/base_drawer_appbar_layout.dart';
import 'package:medb/core/service/auth_service.dart';
import 'package:medb/presentation/widgets/custom_elevated_buttons.dart';
import 'package:medb/presentation/widgets/custom_profile_field.dart';
import 'package:medb/presentation/widgets/profile_avatar.dart';
import 'package:medb/presentation/widgets/profile_name_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedItem = 'Account';
  
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  
  String selectedGender = 'Select Gender';
  bool isLoading = true;
  
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      isLoading = true;
    });
    
    try {
      final userDetails = AuthService.userDetails;
      
      if (userDetails != null) {
        userData = {
          'firstName': userDetails.firstName,
          'middleName': userDetails.middleName,
          'lastName': userDetails.lastName,
          'age': '',
          'gender':'',
          'email': userDetails.email,
          'phone': '' ?? userDetails.contactNo,
          'designation': '',
          'address': '',
          'city': '',
          'district': '',
          'state': '',
          'country':'',
          'postalCode': '',
        };
        
        _populateFields();
      } else {
        userData = {};
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No user data available. Please login again.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      print('Error fetching user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading profile data'),
          backgroundColor: Colors.red,
        ),
      );
      userData = {}; 
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _populateFields() {
    if (userData != null) {
      _firstNameController.text = userData!['firstName'] ?? '';
      _middleNameController.text = userData!['middleName'] ?? '';
      _lastNameController.text = userData!['lastName'] ?? '';
      _ageController.text = userData!['age']?.toString() ?? '';
      _emailController.text = userData!['email'] ?? '';
      _phoneController.text = userData!['phone'] ?? '';
      _designationController.text = userData!['designation'] ?? '';
      _addressController.text = userData!['address'] ?? '';
      _cityController.text = userData!['city'] ?? '';
      _districtController.text = userData!['district'] ?? '';
      _stateController.text = userData!['state'] ?? '';
      _countryController.text = userData!['country'] ?? '';
      _postalCodeController.text = userData!['postalCode'] ?? '';
      selectedGender = userData!['gender'] ?? 'Select Gender';
      
      if (!['Select Gender', 'Male', 'Female', 'Other'].contains(selectedGender)) {
        selectedGender = 'Select Gender';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Container(
            
          width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.lblu,
              borderRadius: BorderRadius.circular(25)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2,
                    color: AppColors.primaryBlue,
                  )
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          ProfileNameHeader(
                            firstName: userData?['firstName'],
                            lastName: userData?['lastName'],
                          ),
                          SizedBox(height: 20),
                          ProfileAvatar(),
                          GestureDetector(
                            onTap: isLoading ? null : () {
                              print('Update profile picture tapped');
                            },
                            child: Text(
                              "Update Profile Picture",
                              style: GoogleFonts.lato(
                                color: isLoading ? Colors.grey : Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          CustomProfileField(
                            controller: _firstNameController,
                            hintText: "First Name",
                            enabled: !isLoading,
                          ),
                          CustomProfileField(
                            controller: _middleNameController,
                            hintText: "Middle Name",
                            enabled: !isLoading,
                          ),
                          CustomProfileField(
                            controller: _lastNameController,
                            hintText: "Last Name",
                            enabled: !isLoading,
                          ),
                          CustomProfileField(
                            controller: _ageController,
                            hintText: "Age",
                            keyboardType: TextInputType.number,
                            enabled: !isLoading,
                          ),
                          
                          
                          
                          
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isLoading ? Colors.grey[200] : Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: selectedGender,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                ),
                                items: [
                                  'Select Gender',
                                  'Male',
                                  'Female',
                                  'Other'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: value == 'Select Gender' 
                                            ? Colors.grey[600] 
                                            : (isLoading ? Colors.grey[500] : Colors.black87),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: isLoading ? null : (String? newValue) {
                                  setState(() {
                                    selectedGender = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),

                         
                         
                          CustomProfileField(
                            controller: _emailController,
                            hintText: "Email",
                            keyboardType: TextInputType.emailAddress,
                            enabled: !isLoading,
                          ),
                          CustomProfileField(
                            controller: _phoneController,
                            hintText: "Phone Number",
                            keyboardType: TextInputType.phone,
                            enabled: !isLoading,
                          ),
                          CustomProfileField(
                            controller: _designationController,
                            hintText: "Designation",
                            enabled: !isLoading,
                          ),
                          CustomProfileField(
                            controller: _addressController,
                            hintText: "Address",
                            enabled: !isLoading,
                          ),
                          CustomProfileField(
                            controller: _cityController,
                            hintText: "City",
                            enabled: !isLoading,
                          ),
                          CustomProfileField(
                            controller: _districtController,
                            hintText: "District",
                            enabled: !isLoading,
                          ),
                          CustomProfileField(
                            controller: _stateController,
                            hintText: "State",
                            enabled: !isLoading,
                          ),
                          CustomProfileField(
                            controller: _countryController,
                            hintText: "Country",
                            enabled: !isLoading,
                          ),
                          CustomProfileField(
                            controller: _postalCodeController,
                            hintText: "Postal Code",
                            keyboardType: TextInputType.number,
                            enabled: !isLoading,
                          ),

                          SizedBox(height: 30),


                          CustomElevatedButton(text: "Update Profile",
                          onPressed: () {},),

                          SizedBox(height: 20),


                          CustomElevatedButton(
                            text: "Update Contact Number",
                            onPressed: (){},
                            backgroundColor: AppColors.surface,
                            textColor: AppColors.primaryBlue,
                            borderColor: AppColors.primaryBlue,
                            
                            ),


                            SizedBox(height: 40),





                         

                        ],
                      ),
                    ),
                    
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      currentScreen: 'Account',
    );
  }
}






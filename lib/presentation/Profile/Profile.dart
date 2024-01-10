import 'dart:convert';
import 'dart:io';

import 'package:advanced_mobile/common/loading.dart';
import 'package:advanced_mobile/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';
import '../../Provider/auth_provider.dart';
import '../../services/user.api.dart';
import 'birthday-select.dart';
import 'country-select.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController studyScheduleController = TextEditingController();
  String linkAvatar = "";
  // Define the list of countries
  List<String> countries = ['Vietnam', 'United States', 'Canada', 'Other'];
  String selectedCountry = "Vietnam";
  List<String> itemsLevel = [
    "BEGINNER",
    "HIGHER_BEGINNER",
    "PRE_INTERMEDIATE",
    "INTERMEDIATE",
    "UPPER_INTERMEDIATE",
    "ADVANCED",
    "PROFICIENCY"
  ];
  List<String> itemsCategory = [
    'ALL',
    'ENGLISH-FOR-KIDS',
    'BUSINESS-ENGLISH',
    'TOEIC',
    'CONVERSATIONAL',
    "TOEFL",
    'PET',
    "KET",
    'IELTS',
    'TOEFL',
    "STARTERS",
    "MOVERS",
    "FLYERS"
  ];
  String selectedLevel = "Beginner";
  List<String> selectedCategory = [];
  late DateTime selectedDate;
  late bool hasInitValue = false;
  XFile? _pickedFile;

  void initValues(UserModel userData) {
    setState(() {
      linkAvatar = userData.avatar ?? "";
      nameController.text = userData.name ?? "";
      emailController.text = userData.email ?? "";
      phoneController.text = userData.phone ?? "";
      studyScheduleController.text = userData.studySchedule ?? "";
      String country = userData.country ?? "Others";
      bool check = false;
      for (var element in countries) {
        if (element.toLowerCase() == country.toLowerCase()) {
          check = true;
          selectedCountry = element;
          break;
        }
      }
      if (check == false) {
        setState(() {
          countries.add(country);
        });
      }
      if (userData.birthday != null) {
        List<String> dateComponents = userData.birthday!.split('-');

        if (dateComponents.length == 3) {
          String year = dateComponents[0];
          String month = dateComponents[1];
          String day = dateComponents[2];

          // Chuyển đổi thành DateTime để kiểm tra tính hợp lệ

          DateTime dateTime =
              DateTime(int.parse(year), int.parse(month), int.parse(day));

          // Nếu không có ngoại lệ, ngày tháng là hợp lệ
          String formattedDateString =
              "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
          selectedDate = DateTime.parse(formattedDateString);
        }
      }

      String level = userData.level ?? "BEGINNER";
      check = false;
      for (var element in itemsLevel) {
        if (element.toLowerCase().compareTo(level.toLowerCase()) == 0) {
          check = true;
          selectedLevel = element;
          break;
        }
      }
      if (check == false) {
        setState(() {
          itemsLevel.add(level);
        });
      }

      check = false;
      userData?.learnTopics?.forEach((element) {
        selectedCategory.add(element.key!.toUpperCase());
      });

      hasInitValue = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (hasInitValue == false) {
      initValues(authProvider.currentUser!);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(50.0), // Define the height of the AppBar
        child: Container(
          decoration: BoxDecoration(color: Colors.blueAccent, boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.1), // Color and opacity of the shadow
              spreadRadius: 1, // Spread radius of the shadow
              blurRadius: 8, // Blur radius of the shadow
              offset: const Offset(0, 0), // Offset of the shadow
            )
          ]),

          child: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Colors.black,
              // Status bar brightness (optional)
              statusBarIconBrightness:
                  Brightness.light, // For Android (dark icons)
            ),
            title: Text("Profile",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: Colors.blueAccent,
              ),
            ),
            centerTitle: true,
          ),

          // Replace 'assets/icon.png' with your image path
        ),
      ),
      body: !hasInitValue
          ? Loading()
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: _pickedFile != null
                                        ? FileImage(File(_pickedFile!.path))
                                            as ImageProvider<Object>
                                        : NetworkImage(
                                            linkAvatar,
                                          ))),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                _getFromGallery(authProvider);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  color: Colors.blue.shade700,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        authProvider.currentUser?.name ?? "Anonymous",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                        child: _buildInfo("Account ID: ",
                            authProvider.currentUser?.id ?? "")),
                    SizedBox(height: 10),
                    Center(
                        child: GestureDetector(
                      onTap: () {},
                      child: Container(
                          child: Text(
                        "Others review you",
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      )),
                    )),
                    SizedBox(height: 10),
                    Center(
                        child: GestureDetector(
                      onTap: () {},
                      child: Container(
                          child: Text(
                        "Change Password",
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      )),
                    )),
                    SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Account",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    _buildForm(authProvider.currentUser!),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildForm(UserModel userData) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildGreyText("Name"),
            const SizedBox(height: 8),
            _buildInputField(
              nameController,
              'Enter your name',
            ),
            const SizedBox(height: 16),
            _buildGreyText("Email Address"),
            const SizedBox(height: 8),
            _buildInputField(
              emailController,
              "Enter your email",
            ),
            const SizedBox(height: 16),
            _buildGreyText("Country"),
            const SizedBox(height: 8),
            CountrySelect(
              countries: countries,
              selectedCountry: selectedCountry,
              onCountryChanged: (String newCountry) {
                setState(() {
                  selectedCountry = newCountry;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildGreyText("Phone Number"),
            const SizedBox(height: 8),
            _buildInputField(
              phoneController,
              "Enter your phone",
            ),
            const SizedBox(height: 16),
            _buildGreyText("Birthday"),
            const SizedBox(height: 8),
            BirthdayProfileSelect(
              dateTimeData: selectedDate,
              onBirthDayChanged: (String newBirthDay) {
                setState(() {
                  selectedDate = DateTime.parse(newBirthDay);
                });
              },
            ),
            const SizedBox(height: 16),
            _buildGreyText("My level"),
            const SizedBox(height: 8),
            _buildSelectLevel("Choose your level", itemsLevel, selectedLevel),
            const SizedBox(height: 16),
            _buildGreyText("Want to learn"),
            const SizedBox(height: 8),
            _buildSelect("Want to learn", itemsCategory, selectedCategory),
            const SizedBox(height: 16),
            _buildGreyText("Study Schedule"),
            const SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 1.0,
                ),
              ),
              child: TextField(
                controller: studyScheduleController,
                decoration: InputDecoration(
                  hintText:
                      "Note the time of the week you want to study on LetTutor",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                  border: InputBorder.none, // Loại bỏ viền
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 12),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          var authProvider = Provider.of<AuthProvider>(context, listen: false);
          callAPIUpdateProfile(UserRepository(), authProvider);
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            // border radius
            borderRadius: BorderRadius.circular(8)),
        backgroundColor: const Color.fromRGBO(4, 104, 211, 1.0),
        minimumSize: const Size.fromHeight(46),
      ),
      child: const Text(
        "Save changes",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildInfo(String title, String content) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10),
      child: Wrap(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            content,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hintText,
      {isPassword = false, Function? validator}) {
    return TextFormField(
      // validator: (value) {
      //   return validator!(value ?? "");
      // },
      controller: controller,
      style: TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        isDense: true, // Added this
        contentPadding: EdgeInsets.all(12),
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : null,
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildSelect(
      String title, List<String> selects, List<String> selected) {
    return Container(
      width: double.infinity, // Set width to match parent
      height: 42.0, // Set height to match TextInput
      alignment: Alignment.center,
      child: DropDownMultiSelect(
        isDense: true,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(12),
        ),
        onChanged: (List<String> x) {
          setState(() {
            selected = x;
          });
        },
        options: selects,
        selectedValues: selected,
        whenEmpty: title,
      ),
    );
  }

  Widget _buildSelectLevel(
      String title, List<String> selects, String selected) {
    return Container(
      width: double.infinity, // Set width to match parent
      height: 42.0, // Set height to match TextInput
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(8.0), // Match the TextInput border radius
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1.0,
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: DropdownButton<String>(
            underline: Container(),
            isDense: true,
            isExpanded: true,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            value: selected,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedLevel = newValue;
                });
              }
            },
            items: itemsLevel.map<DropdownMenuItem<String>>((String level) {
              return DropdownMenuItem<String>(
                value: level,
                child: Text(level),
              );
            }).toList(),
          )),
    );
  }

  _getFromGallery(AuthProvider authProvider) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      callAPIUpdateAvatar(UserRepository(), authProvider, pickedFile.path);
    }
  }

  Future<void> callAPIUpdateAvatar(UserRepository userRepository,
      AuthProvider authProvider, String avatar) async {
    await userRepository.uploadAvatar(
        accessToken: authProvider.token?.access?.token ?? "",
        imagePath: avatar,
        onSuccess: (user) async {
          authProvider.saveLoginInfo(user, authProvider.token);
          initValues(authProvider.currentUser!);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Profile updated successfully',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }

  Future<void> callAPIUpdateProfile(
      UserRepository userRepository, AuthProvider authProvider) async {
    await userRepository.updateInfoUser(
        accessToken: authProvider.token?.access?.token ?? "",
        input: UserModel(
            name: nameController.text,
            phone: phoneController.text,
            country: selectedCountry,
            birthday: DateFormat('yyyy-MM-dd').format(selectedDate),
            level: selectedLevel,
            learnTopics: authProvider.currentUser?.learnTopics!,
            testPreparations: authProvider.currentUser?.testPreparations!,
            studySchedule: studyScheduleController.text),
        onSuccess: (user) async {
          authProvider.saveLoginInfo(user, authProvider.token);
          initValues(authProvider.currentUser!);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Profile updated successfully',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }
}

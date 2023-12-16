import 'package:advanced_mobile/presentation/Login/Login.dart';
import 'package:advanced_mobile/services/user.api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword();

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isTypeEmail = true;
  String errorEmail = "";

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(50.0), // Define the height of the AppBar
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.2), // Color and opacity of the shadow
                spreadRadius: 5, // Spread radius of the shadow
                blurRadius: 7, // Blur radius of the shadow
                offset: const Offset(0, 3), // Offset of the shadow
              ),
            ],
          ),
          child: AppBar(
              automaticallyImplyLeading: false,
              systemOverlayStyle: const SystemUiOverlayStyle(
                // Status bar color
                statusBarColor: Colors.black,
                // Status bar brightness (optional)
                statusBarIconBrightness:
                    Brightness.light, // For Android (dark icons)
              ),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.school,
                        size: 45,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 7),
                      Text(
                        "LetTutor",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100, right: 40, bottom: 0, left: 40),
          child: Column(
            children: [
              Text("Reset Password",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 5,
              ),
              Text(
                "Please enter your email address to search for your account.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 35,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 35,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Màu của biên
                        width: 1.0, // Độ rộng của biên
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        if (value == "") {
                          setState(() {
                            isTypeEmail = false;
                            errorEmail = "Please input your Email!";
                          });
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          setState(() {
                            isTypeEmail = false;
                            errorEmail = "The input is not valid Email!";
                          });
                        } else {
                          setState(() {
                            isTypeEmail = true;
                          });
                        }
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: -15),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Visibility(
                      visible: !isTypeEmail,
                      child: Text(
                        errorEmail,
                        style: TextStyle(color: Colors.red),
                      )),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10),
                    child: TextButton(
                        onPressed: () {
                          if (isTypeEmail && emailController.text != "") {
                            callApiResetPassword(emailController.text);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueAccent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Đặt góc bo tròn
                            ),
                          ),
                        ),
                        child: Text(
                          "Reset password",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          "Go to Login?",
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 16),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void callApiResetPassword(String emailReset) async {
    try {
      final userRepository = UserRepository();
      await userRepository.resetPassword(
          email: emailReset,
          result: (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          });
    } finally {}
  }
}

import 'package:advanced_mobile/presentation/Register/Register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

import '../../main.dart';
import 'formLogin.dart';

class Login extends StatelessWidget {
  Login();

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
          margin: EdgeInsets.only(top: 15, right: 15, bottom: 0, left: 15),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text("Say hello to your English tutors",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 5,
              ),
              Text(
                "Become fluent faster through one on one video chat lessons tailored to your goals.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              FormLogin(),
              OrtherLogin()
            ],
          ),
        ),
      ),
    );
  }
}

class OrtherLogin extends StatelessWidget {
  const OrtherLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 25, bottom: 50),
            child: RichText(
              text: TextSpan(
                text: 'Not a member yet? ',
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: 'Sign up',
                    style: TextStyle(color: Colors.blueAccent),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        // Chuyển đến trang đăng ký khi nhấn vào "Sign up"
                        bool registered = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                        if (registered != null && registered) {
                          toastification.show(
                            context: context,
                            autoCloseDuration: const Duration(seconds: 3),
                            title: Text('Sign up successful!'),
                            description: Text(
                                'Please check your email to verify account.'),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            icon: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            ),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 35),
                            borderRadius: BorderRadius.circular(3),
                            closeOnClick: false,
                            pauseOnHover: true,
                          );
                        }
                      },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

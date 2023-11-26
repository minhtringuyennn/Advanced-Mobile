import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/account-dto.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  bool isTypeEmail = true;
  bool isTypePassword = true;
  String errorEmail = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Account account = context.watch<Account>();
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 40,
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
                contentPadding: EdgeInsets.only(top: -10),
                border: InputBorder.none,
              ),
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
            ),
          ),
          Visibility(
              visible: !isTypeEmail,
              child: Text(
                errorEmail,
                style: TextStyle(color: Colors.red),
              )),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Text(
              "Password",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
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
                  if (isTypePassword == true) {
                    setState(() {
                      isTypePassword = false;
                    });
                  }
                } else {
                  if (isTypePassword == false) {
                    setState(() {
                      isTypePassword = true;
                    });
                  }
                }
              },
              controller: passwordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 1),
                suffixIcon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.black54,
                  size: 20,
                ),
                border: InputBorder.none,
              ),
              obscureText: true,
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
            ),
          ),
          Visibility(
              visible: !isTypePassword,
              child: Text(
                "Please input your Password!",
                style: TextStyle(color: Colors.red),
              )),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20),
            child: TextButton(
                onPressed: () {
                  if (emailController.text != "" && isTypeEmail&&
                      passwordController.text != "") {
                    account.register(emailController.text, passwordController.text);
                    Navigator.pop(context, true);
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Đặt góc bo tròn
                    ),
                  ),
                ),
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}

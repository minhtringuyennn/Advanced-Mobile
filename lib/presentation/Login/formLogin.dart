import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../model/account-dto.dart';

class FormLogin extends StatefulWidget {
  FormLogin(this.callback);
  final LoginCallback callback;


  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  bool isSuccess=true;
  bool isTypeEmail = true;
  bool isTypePassword = true;
  String errorEmail = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Account account=context.watch<Account>();
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
                } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
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
          Visibility(
            visible: !isSuccess,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
              decoration: BoxDecoration(
                color: Color(0xFFfff2f0),
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  width: 1,
                  color: Color(0xFFffccc7),
                )
              ),
              child: Row(
                children: [
                  Icon(Icons.highlight_remove_sharp,color: Colors.red,size: 18,),
                  SizedBox(width: 5,),
                  Text("Log in failed! Incorrect email or password.")
                ],
              ),
            ),
          ),
          
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.blueAccent, fontSize: 16),
              )),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 5),
            child: TextButton(
                onPressed: () {
                  if(isTypeEmail&&emailController.text!=""&&passwordController.text!=""){
                    if(emailController.text==account.email&&passwordController.text==account.password)
                    {
                      setState(() {
                        isSuccess=true;
                      });
                      widget.callback(1);
                    }
                    else{
                      setState(() {
                        isSuccess=false;
                      });

                    }
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
                  "LOG IN",
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

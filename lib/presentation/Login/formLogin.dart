import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Home/Home.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({super.key});

  @override
  Widget build(BuildContext context) {
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
              //onChanged: (value)=>_runFilter(value),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: -10),
                border: InputBorder.none,
              ),
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
            ),
          ),
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
              //onChanged: (value)=>{},
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );

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

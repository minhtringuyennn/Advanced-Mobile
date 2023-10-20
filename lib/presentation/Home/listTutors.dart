import 'package:advanced_mobile/presentation/Home/tutor.dart';
import 'package:flutter/cupertino.dart';

class ListTutors extends StatelessWidget {
  const ListTutors({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommended Tutors",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
            textAlign: TextAlign.left,
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [Tutor(), Tutor(), Tutor()],
          ),
        ],
      ),
    );
  }
}

import 'package:advanced_mobile/model/tutor/tutor_model.dart';
import 'package:advanced_mobile/presentation/Home/tutor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

class ListTutors extends StatefulWidget {
  const ListTutors(this.tutors, this._favTutorsId, this.changeFavorite,
      {super.key});
  final List<TutorModel> tutors;
  final List<String> _favTutorsId;
  final ChangeFavorite changeFavorite;

  @override
  State<ListTutors> createState() => _ListTutorsState();
}

class _ListTutorsState extends State<ListTutors> {
  bool checkIfTutorIsFavorite(TutorModel tutor) {
    for (var element in widget._favTutorsId) {
      if (element == tutor.userId) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      margin: EdgeInsets.only(top: 15, bottom: 30),
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
          Visibility(
            visible: !widget.tutors.isEmpty,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.tutors.length,
              itemBuilder: (context, index) {
                return Tutor(
                    widget.tutors[index],
                    checkIfTutorIsFavorite(widget.tutors[index]),
                    widget.changeFavorite);
                // Add more customization here if needed
              },
            ),
          ),
          Visibility(
            visible: widget.tutors.isEmpty,
            child: Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.hourglass_empty,
                    color: Colors.grey.shade300,
                    size: 50,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Sorry we can't find any tutor with this keywords",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

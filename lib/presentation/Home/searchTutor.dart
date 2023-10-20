import 'package:advanced_mobile/presentation/Home/timeRange.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:get/get.dart';

class SearchTutor extends StatefulWidget {
  const SearchTutor({super.key});

  @override
  State<SearchTutor> createState() => _SearchTutorState();
}

List<Widget> generateWidgets(List<String> list) {
  List<Widget> widgets = [];
  Color backgroundColor = Color.fromARGB(255, 232, 232, 232);

  for (int i = 0; i < list.length; i++) {
    widgets.add(TextButton(
        onPressed: () {},
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
              Size(40, 30)), // Thay đổi width và height tùy ý
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
              horizontal: 10, vertical: 5)), // Điều chỉnh lề cho TextButton
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Đặt góc bo tròn
            ),
          ),
        ),
        child: Text(
          list[i],
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ))); // Thêm widget Text vào danh sách
  }

  return widgets;
}

class _SearchTutorState extends State<SearchTutor> {
  DateTime selectDate = DateTime.now();
  TextEditingController _textEditingDate = TextEditingController();
  List<String> _items = [
    "Foreign Tutor",
    "Vietnamese Tutor",
    "Native English Tutor"
  ];
  List<String> selectedOptionList = [];
  var selectedOption = ''.obs;
  @override
  Widget build(BuildContext context) {
    List<String> listFilters = [
      "All",
      "English for kids",
      "English for Business",
      "Conversational",
      "STARTERS",
      "MOVERS",
      "FLYERS",
      "KET",
      "PET",
      "IELTS",
      "TOEFL",
      "TOEIC"
    ];
    List<Widget> generatedWidgets = generateWidgets(listFilters);
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      margin: EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Find a tutor",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 15,
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
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              //onChanged: (value)=>_runFilter(value),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: -12, left: 5, right: 2),
                  border: InputBorder.none,
                  hintText: "Enter tutor name...",
                  hintStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w400)),
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: DropDownMultiSelect(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 15, right: 15),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Set the border radius
                  borderSide: BorderSide(
                    color: Colors.grey, // Set the border color
                    width: 1.0, // Set the border width
                  ),
                ),
              ),
              options: _items,
              whenEmpty: "Select tutor nationality",
              onChanged: (value) {
                selectedOptionList = value;
                selectedOption.value = "";
                selectedOptionList.forEach((element) {
                  selectedOption.value = selectedOption.value + ", " + element;
                });
              },
              selectedValues: selectedOptionList,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Select available tutoring time:",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 40,
            width: 160,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, // Màu của biên
                width: 1.0, // Độ rộng của biên
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _textEditingDate,
              onTap: () async {
                final DateTime? datetime = await showDatePicker(
                    context: context,
                    initialDate: selectDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(3000));
                if (datetime != null) {
                  setState(() {
                    _textEditingDate.text =
                        "${datetime.year}-${datetime.month}-${datetime.day}";
                    selectDate = datetime;
                  });
                }
              },
              //onChanged: (value)=>_runFilter(value),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 1, left: 13, right: 2),
                  border: InputBorder.none,
                  hintText: "Select a day",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.black54,
                    size: 20,
                  )),
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          TimeRangeSelector(),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 0),
            child: Wrap(
              spacing: 5,
              children: generatedWidgets,
            ),
          ),
          TextButton(
              onPressed: () {},
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  BorderSide(
                    color: Colors.blueAccent, // Border color
                    width: 1.0, // Border width
                  ),
                ),
                minimumSize: MaterialStateProperty.all(
                    Size(40, 30)), // Thay đổi width và height tùy ý
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5)), // Điều chỉnh lề cho TextButton
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Đặt góc bo tròn
                  ),
                ),
              ),
              child: Text(
                "Reset Filters",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueAccent),
              )),
        ],
      ),
    );
  }
}

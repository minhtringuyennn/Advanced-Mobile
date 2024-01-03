import 'package:advanced_mobile/presentation/Courses/Courses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/enum/app_enums.dart';
import 'package:multi_dropdown/models/chip_config.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class Filter extends StatefulWidget {
  const Filter(this.filterCallback, {super.key});
  final FilterCourseCallback filterCallback;

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String? valueSort;
  List<String> listLevel = [];

  MultiSelectController _controller = MultiSelectController();

  List<String> sort = ["Level decreasing", 'Level ascending'];
  List<Map<String, String>> level = [
    {"value": "0", "label": "Any level"},
    {"value": "1", "label": "Beginer"},
    {"value": "2", "label": "Upper-Beginer"},
    {"value": "3", "label": "Pre-Intermedicate"},
    {"value": "4", "label": "Intermedicate"},
    {"value": "5", "label": "Upper-Intermedicate"},
    {"value": "6", "label": "Pre-advanced"},
    {"value": "7", "label": "Advanced"},
    {"value": "8", "label": "Very advanced"},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          MultiSelectDropDown(
            hint: "Select category",
            hintStyle: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
            showClearIcon: true,
            controller: _controller,
            onOptionSelected: (options) {
              List<String> valuesList =
                  options.map((item) => item.value.toString()).toList();
              widget.filterCallback(valueSort ?? "", valuesList);
              setState(() {
                listLevel = valuesList;
              });
            },
            options: level
                .map((item) =>
                    ValueItem(label: item['label']!, value: item['value']!))
                .toList(),
            maxItems: level.length,
            selectionType: SelectionType.multi,
            chipConfig: const ChipConfig(
                wrapType: WrapType.wrap,
                runSpacing: 0,
                padding: EdgeInsets.only(left: 10, right: 0)),
            dropdownHeight: 300,
            optionTextStyle: const TextStyle(fontSize: 14),
            selectedOptionIcon: const Icon(Icons.check),
            borderRadius: 3,
            padding: EdgeInsets.only(left: 5),
          ),
          Container(
            margin: EdgeInsets.only(top: 7),
            height: 50,
            padding: EdgeInsets.only(left: 10, right: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(3)),
            child: DropdownButton(
                hint: Text(
                  'Sort by level',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.grey),
                ),
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(fontSize: 14, color: Colors.black),
                onChanged: (newValue) {
                  widget.filterCallback(newValue ?? "", listLevel);
                  setState(() {
                    valueSort = newValue;
                  });
                },
                items: sort.map((valueItem) {
                  return DropdownMenuItem(
                      child: Text(
                        valueItem,
                        style: TextStyle(fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      value: valueItem);
                }).toList(),
                value: valueSort),
          ),
        ],
      ),
    );
  }
}

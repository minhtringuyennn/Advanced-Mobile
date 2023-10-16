import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/enum/app_enums.dart';
import 'package:multi_dropdown/models/chip_config.dart';
import 'package:multi_dropdown/models/network_config.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multi_dropdown/widgets/hint_text.dart';
import 'package:multi_dropdown/widgets/selection_chip.dart';
import 'package:multi_dropdown/widgets/single_selected_item.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String? valueLevel;
  String? valueCategory;
  String? valueSort;

  final MultiSelectController _controller = MultiSelectController();

  List<String> category = [
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
  List<String> sort = ["Level decreasing", 'Level ascending'];
  List<String> level = [
    "Any level",
    "Beginer",
    "Upper-Beginer",
    "Pre-Intermedicate",
    "Intermedicate",
    "Upper-Intermedicate",
    "Pre-advanced",
    "Advanced",
    "Very advanced"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
         MultiSelectDropDown(
              hint: "Select level",
              hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
              showClearIcon: true,
              controller: _controller,
              onOptionSelected: (options) {
                debugPrint(options.toString());
              },
              padding: EdgeInsets.only(left: 5),
              options: level
                  .map((item) => ValueItem(label: item, value: item))
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
            ),

          SizedBox(
            height: 7,
          ),
          MultiSelectDropDown(
              hint: "Select category",
              hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
              showClearIcon: true,
              controller: _controller,
              onOptionSelected: (options) {
                debugPrint(options.toString());
              },
              options: category
                  .map((item) => ValueItem(label: item, value: item))
                  .toList(),
              maxItems: category.length,
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

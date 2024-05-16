import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';

class MultiselectDropdown extends StatelessWidget {
  final String title;
  final bool isRequired;
  final List<dynamic> dropdownList;
  final List<dynamic>? initiallySelectedList;
  final void Function(List<dynamic>) onChanged;
  final bool? isLarge;
  final bool? selectAll;
  final String compareData;
  final String showData;
  bool? isValidate;

  MultiselectDropdown({
    Key? key,
    required this.title,
    this.isRequired = true,
    this.selectAll = false,
    required this.dropdownList,
    this.isLarge = false,
    this.isValidate = false,
    this.showData = 'name',
    this.compareData = 'id',
    this.initiallySelectedList,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                color: appTheme.orange.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: MultiSelectDropdown(
              splashColor: Colors.grey,
              key: key,
              width: size.width,
              list: dropdownList,
              initiallySelected: initiallySelectedList ?? [],
              onChange: onChanged,
              label: showData,
              id: compareData,
              includeSearch: true,
              includeSelectAll: selectAll!,
              numberOfItemsLabelToShow: 5,
              boxDecoration: BoxDecoration(),
              isLarge: isLarge!,
              whenEmpty: "${title.capitalizeFirst}",
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.01,
              ),
              checkboxFillColor: appTheme.headerColor,
            ),
          ),
        ],
      ),
    );
  }
}

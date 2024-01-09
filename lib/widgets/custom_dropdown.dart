import 'package:dropdown_search/dropdown_search.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/utils/string_capitalization.dart';
import '../core/app_export.dart';

class CustomDropdown extends StatefulWidget {
  final String labelText;
  void Function(String?)? onSave;
  void Function(String?)? onChng;
  String? Function(String?)? validator;
  Function(List<dynamic>)? onChanged;
  bool isMultiselect = false;
  String? selectedItem;
  List<dynamic>? multiSelected;
  bool showSearchBox;
  bool? isValidate;
  void Function(List<dynamic>, dynamic)? popupOnItemAdded;
  void Function(List<dynamic>, dynamic)? popupOnItemRemoved;

  List<String> listName;
  CustomDropdown({
    this.onChng,
    this.multiSelected,
    this.popupOnItemRemoved,
    this.popupOnItemAdded,
    this.isValidate = true,
    required this.labelText,
    required this.listName,
    this.selectedItem,
    this.onSave,
    this.validator,
    this.isMultiselect = false,
    this.onChanged,
    this.showSearchBox = false,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? value = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _textLabel(),
        Stack(
          children: [
            Container(
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.01),
                    offset: const Offset(0, 0),
                    spreadRadius: 8)
              ], borderRadius: BorderRadius.circular(15)),
            ),
            DropdownSearch<String>(
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: widget.listName,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: widget.labelText,
                  hintText: widget.labelText,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  this.value = value;
                });
              },
              selectedItem: widget.selectedItem,
            )
          ],
        ),
      ],
    );
  }

  customInputDecoration(Color fillColor, String hintText, bool isPrefixIcon,
      {IconButton? iconButton,
      Widget? prefixIcon,
      Widget? suffixIcon,
      String? counterText,
      bool? offStage,
      bool? isDense,
      TextStyle? counterStyle,
      String? labelText,
      String? errorText}) {
    double radius = 10;
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10.v, horizontal: 20.v),
      labelText: labelText,
      counterStyle: counterStyle,
      counterText: counterText,
      isDense: isDense ?? false,
      errorText: errorText,
      hintText: hintText.toCapitalized(),
      hintStyle: CustomTextStyles.titleSmall_1,
      errorStyle: CustomTextStyles.titleMediumRed600d8,
      prefixIcon: isPrefixIcon == false
          ? null
          : Padding(
              padding: EdgeInsets.only(top: 20.v, bottom: 20.v),
              child: prefixIcon,
            ),
      suffixIcon: Padding(
        padding: EdgeInsets.only(
          top: 20.v,
          bottom: 20.v,
        ),
        child: suffixIcon,
      ),
      filled: true,
      fillColor: fillColor,
      counter: Offstage(
        offstage: offStage ?? true,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide:
            BorderSide(color: appTheme.orange.withOpacity(0.2), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide:
              BorderSide(color: appTheme.orange.withOpacity(0.2), width: 1)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: Colors.red.withOpacity(0.8), width: 1)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide:
              BorderSide(color: appTheme.orange.withOpacity(0.2), width: 1)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Colors.grey, width: 1)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Colors.grey, width: 1)),
    );
  }

  _textLabel() {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
            padding: EdgeInsets.only(bottom: 5.h, right: 15.h),
            child: Text(
              widget.labelText,
              style: CustomTextStyles.titleSmall_1,
            )),
      ],
    );
  }
}

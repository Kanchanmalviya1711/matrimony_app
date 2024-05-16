// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import '../core/app_export.dart';
// import 'text_label.dart';
// // ignore: unused_import
// import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';

// // ignore: must_be_immutable
// class CustomDropdown extends StatefulWidget {
//   final String labelText;
//   void Function(String?)? onSave;
//   void Function(String?)? onChng;
//   String? Function(String?)? validator;
//   Function(List<dynamic>)? onChanged;
//   bool isMultiselect = false;
//   String? selectedItem;
//   List<dynamic>? selectedItems;
//   bool showSearchBox;
//   bool? isValidate;
//   void Function(List<dynamic>, dynamic)? popupOnItemAdded;
//   void Function(List<dynamic>, dynamic)? popupOnItemRemoved;

//   List<String> listName;
//   CustomDropdown({
//     this.onChng,
//     this.selectedItems,
//     this.popupOnItemRemoved,
//     this.popupOnItemAdded,
//     this.isValidate = true,
//     required this.labelText,
//     required this.listName,
//     this.selectedItem,
//     this.onSave,
//     this.validator,
//     this.isMultiselect = false,
//     this.onChanged,
//     this.showSearchBox = false,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<CustomDropdown> createState() => _CustomDropdownState();
// }

// class _CustomDropdownState extends State<CustomDropdown> {
//   String? value = "";

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextLabel(
//           title: widget.labelText,
//           isRequired: true,
//         ),
//         Stack(
//           children: [
//             Container(
//               height: 50,
//               width: double.maxFinite,
//               decoration: BoxDecoration(boxShadow: [
//                 BoxShadow(
//                     blurRadius: 5,
//                     color: Colors.black.withOpacity(0.01),
//                     offset: const Offset(0, 0),
//                     spreadRadius: 8)
//               ], borderRadius: BorderRadius.circular(15)),
//             ),
//             widget.isMultiselect
//                 ? DropdownSearch.multiSelection(
//                     key: Mode.MENU,
//                     filterFn: true,
//                     hei: widget.listName.length <= 3 ? 200 : 400,
//                     dropdownBuilderSupportsNullItem: true,
//                     popupBackgroundColor: Colors.white,
//                     showFavoriteItems: true,
//                     favoriteItemsAlignment: MainAxisAlignment.start,
//                     dropdownSearchTextAlign: TextAlign.start,
//                     selectedItems: widget.selectedItems ?? [],
//                     popupElevation: 3,
//                     showClearButton: true,
//                     focusNode: FocusNode(),

//                     // for loading indicator
//                     loadingBuilder: (context, searchEntry) {
//                       return const CircularProgressIndicator();
//                     },
//                     // for error handling
//                     errorBuilder: (context, searchEntry, exception) {
//                       return const Center(
//                         child: Text("Error"),
//                       );
//                     },
//                     popupOnItemAdded: widget.popupOnItemAdded,

//                     popupOnItemRemoved: widget.popupOnItemRemoved,

//                     // to check validation
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select one or more option';
//                       }
//                       return null;
//                     },
//                     compareFn: (item, selectedItem) {
//                       return item == selectedItem;
//                     },
//                     filterFn: (item, filter) {
//                       return item.toLowerCase().contains(filter.toString());
//                     },

//                     // while the data is empty

//                     emptyBuilder: (context, searchEntry) {
//                       return const Center(
//                         child: Text("No data found"),
//                       );
//                     },
//                     // dropdown button icon props
//                     dropdownButtonProps: const IconButtonProps(
//                         icon: Icon(
//                       Icons.keyboard_arrow_down_outlined,
//                       color: Colors.black,
//                     )),

//                     // popup barrier color
//                     popupBarrierColor: Colors.black.withOpacity(0.2),
//                     onPopupDismissed: () {
//                       print('Popup dismissed');
//                     },
//                     // popup shape
//                     popupItemDisabled: (item) {
//                       return item == 'A' ? true : false;
//                     },
//                     // favorite items
//                     favoriteItemBuilder: (context, item, isSelected) {
//                       return Container(
//                         padding: const EdgeInsets.all(10),
//                         child: Row(
//                           children: [
//                             const Icon(
//                               Icons.favorite_sharp,
//                               color: Colors.red,
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               item.toString(),
//                               style: const TextStyle(fontSize: 16),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                     favoriteItems: (items) {
//                       return items.where((element) => element == 'B').toList();
//                     },

//                     // popup title
//                     popupTitle: const Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Select one or more option',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         Divider(
//                           thickness: 2,
//                         )
//                       ],
//                     ),

//                     popupShape: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide.none),
//                     searchFieldProps: TextFieldProps(
//                       decoration: customInputDecoration(
//                           Colors.white, "Search ${widget.labelText}...", false),
//                     ),
//                     dropdownSearchDecoration: customInputDecoration(
//                         Colors.white, "Select ${widget.labelText}", false),

//                     // selected data builder props
//                     showSearchBox: widget.showSearchBox,
//                     items: widget.listName,
//                     onChanged: widget.onChanged,
//                   )
//                 : DropdownSearch(
//                     selectedItem: widget.selectedItem,
//                     autoValidateMode: AutovalidateMode.onUserInteraction,
//                     mode: Mode.MENU,
//                     emptyBuilder: (context, searchEntry) {
//                       return const Center(
//                         child: Text("No data found"),
//                       );
//                     },
//                     validator: widget.isValidate!
//                         ? widget.validator ??
//                             (value) {
//                               if (value == null) {
//                                 return 'Please select ${widget.labelText.toLowerCase()}';
//                               }
//                               return null;
//                             }
//                         : null,
//                     maxHeight: widget.listName.length <= 3 ? 200 : 300,
//                     popupShape: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide.none),
//                     searchFieldProps: TextFieldProps(
//                       decoration: customInputDecoration(
//                           Colors.white, "Search ${widget.labelText}", false),
//                     ),
//                     dropdownSearchDecoration: customInputDecoration(
//                         Colors.white, "Select ${widget.labelText}", false),
//                     showClearButton: true,
//                     onSaved: widget.onSave,
//                     showSearchBox: widget.showSearchBox,
//                     items: widget.listName.toList(),
//                     onChanged: widget.onChng,
//                   ),
//           ],
//         ),
//       ],
//     );
//   }
// }

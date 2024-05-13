import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/allProfiles/controller/allProfiles_controller.dart';
import 'package:matrimony_app/presentation/register/controller/resgister_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_dropdown.dart';
import 'package:matrimony_app/widgets/custom_text_form_field.dart';
import 'package:matrimony_app/widgets/multiselect_dropdown.dart';

class AllProfilesForm extends StatefulWidget {
  const AllProfilesForm({Key? key}) : super(key: key);
  @override
  State<AllProfilesForm> createState() => _AllProfilesFormState();
}

class _AllProfilesFormState extends State<AllProfilesForm> {
  AllProfilesListController allProfilesListController =
      Get.put(AllProfilesListController());
  RegisterController registerController = Get.put(RegisterController());
  double minHeight = 5.0;
  double maxHeight = 7.0;
  double selectedHeight = 5.0;

  void initState() {
    allProfilesListController.getAllLanguages();
    allProfilesListController.getAllCity();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Center(child: Text("Profile Filter")),
            ),
            //Caste
            CustomTextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter Caste";
                }
                return null;
              },
              controller: allProfilesListController.casteFilter.value,
              labelText: "Caste",
            ),
            const SizedBox(
              height: 5,
            ),
            //Religion
            CustomTextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter Religion";
                }
                return null;
              },
              controller: allProfilesListController.religionController.value,
              labelText: "Religion",
            ),
            const SizedBox(
              height: 5,
            ),
            //Weight
            CustomTextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter min weight";
                }
                return null;
              },
              controller: allProfilesListController.minWeightController.value,
              labelText: "Min Weight",
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter max weight";
                }
                return null;
              },
              controller: allProfilesListController.maxWeightController.value,
              labelText: "Max Weight",
            ),
            const SizedBox(
              height: 5,
            ),
            //Height
            CustomTextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter min height";
                }
                return null;
              },
              controller: allProfilesListController.minHeightController.value,
              labelText: "Min Height",
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter max height";
                }
                return null;
              },
              controller: allProfilesListController.maxHeightController.value,
              labelText: "Max Height",
            ),
            const SizedBox(
              height: 5,
            ),
            //Age
            CustomTextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter min age";
                }
                return null;
              },
              controller: allProfilesListController.minAgeController.value,
              labelText: "Min Age",
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter max age";
                }
                return null;
              },
              controller: allProfilesListController.maxAgeController.value,
              labelText: "Max Age",
            ),
            const SizedBox(
              height: 5,
            ),
            //Income
            CustomTextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter min income";
                }
                return null;
              },
              controller:
                  allProfilesListController.minAnnualIncomeController.value,
              labelText: "Min Annual Income",
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter max annual income";
                }
                return null;
              },
              controller:
                  allProfilesListController.maxAnnualIncomeController.value,
              labelText: "Max Annual Income",
            ),
            const SizedBox(
              height: 5,
            ),
            //slect spoken languages
            Obx(() {
              if (allProfilesListController.languageList.isNotEmpty) {
                List<int> initiallySelectedIds = [];
                // Iterate through initiallySelectedList and extract IDs
                for (var item
                    in allProfilesListController.selectedCheckBoxValue) {
                  // Ensure item is a map with "id" key
                  if (item is Map && item.containsKey("id")) {
                    initiallySelectedIds.add(int.parse(item["id"].toString()));
                  }
                }
                return MultiselectDropdown(
                  title: 'Spoken Languages ',
                  initiallySelectedList: initiallySelectedIds,
                  dropdownList: allProfilesListController.languageList,
                  compareData: 'id',
                  showData: 'name',
                  onChanged: (selectedItems) {
                    allProfilesListController.selectedCheckBoxValue.clear();
                    for (var item in selectedItems) {
                      if (item is Map && item.containsKey("id")) {
                        // print("$item, item");
                        allProfilesListController.selectedCheckBoxValue
                            .add(int.parse(item["id"].toString()));
                      }
                      print(
                          "item ${allProfilesListController.selectedCheckBoxValue}");
                    }
                  },
                );
              } else {
                // You might want to display a loading indicator or an empty state
                return SizedBox();
              }
            }),

            const SizedBox(height: 10),

            //Cities  DropDown List [1,2,3]
            Obx(() {
              if (allProfilesListController.cityList.isNotEmpty) {
                List<int> initiallySelectedIds = [];
                // Iterate through initiallySelectedList and extract IDs
                for (var item in allProfilesListController.cityValue) {
                  // Ensure item is a map with "id" key
                  if (item is Map && item.containsKey("id")) {
                    initiallySelectedIds.add(int.parse(item["id"].toString()));
                  }
                }
                return MultiselectDropdown(
                  title: 'Interested City',
                  initiallySelectedList: initiallySelectedIds,
                  dropdownList: allProfilesListController.cityList,
                  compareData: 'id',
                  showData: 'name',
                  onChanged: (selectedItems) {
                    allProfilesListController.cityValue.clear();
                    for (var item in selectedItems) {
                      if (item is Map && item.containsKey("id")) {
                        // print("$item, item");
                        allProfilesListController.cityValue
                            .add(int.parse(item["id"].toString()));
                      }
                      print("item ${allProfilesListController.cityValue}");
                    }
                  },
                );
              } else {
                // You might want to display a loading indicator or an empty state
                return SizedBox();
              }
            }),

            SizedBox(height: 10.h),

            // CustomDropdown(
            //    isMultiselect: true,
            //    labelText: 'Select Permission',
            //    showSearchBox: true,
            //    selectedItems: data[0] != "isCreate"
            //    ? data[0]['permissions']
            //   .map((e) => e['name'].toString())
            //   .toList()
            //   : null,
            //   listName: roleController.permissionData
            //     .map((e) => e['name'].toString())
            //      .toList(),
            //     onChanged: (value) {
            //     var data = value.map((e) {
            //    return roleController.permissionData.firstWhere(
            //   (element) =>
            //   element['name'] == e.toString())['id'];
            //    }).toList();
            //   roleController.permissionList.value = data;
            //  },
            //  ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: appTheme.black900),
                    onPressed: () {
                      Get.offAndToNamed(AppRoutes.allProfilesScreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Apply Filter",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: appTheme.whiteA700),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appTheme.redColor,
                    ),
                    onPressed: () {
                      Get.back();
                      allProfilesListController.clearInputField();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Clear Filter",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                            color: appTheme.whiteA700),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// add two numbers program



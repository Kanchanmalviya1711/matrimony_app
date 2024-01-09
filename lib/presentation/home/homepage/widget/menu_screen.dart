import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/home/homepage/controller/homepage_controller.dart';
import 'package:matrimony_app/theme/theme_helper.dart';

//Flutter code sample for [MenuAcceleratorLabel].
class MyMenuBar extends StatelessWidget {
  final HomepageController controller;

  const MyMenuBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          if (controller.rxRequestStatus.value == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.rxRequestStatus.value == Status.success) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: PopupMenuButton<int>(
                    itemBuilder: (context) {
                      return List.generate(
                        controller.menusList.length,
                        (index) {
                          return PopupMenuItem<int>(
                            value: index,
                            child: Text(
                              controller.menusList[index]["menu"]["name"] ==
                                      null
                                  ? "No data"
                                  : controller.menusList[index]["menu"]
                                          ["name"] ??
                                      "No data",
                            ),
                          );
                        },
                      );
                    },
                    onSelected: (int index) {
                      print("Selected menu index: $index");
                    },
                    child: MenuBar(
                      style: const MenuStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                        elevation: MaterialStatePropertyAll(0),
                      ),
                      children: List.generate(
                        controller.menusList.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(5),
                          child: SubmenuButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                appTheme.activeBackgroundColor,
                              ),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            menuChildren: List.generate(
                              controller.menusList[index]["subMenu"].length,
                              (subIndex) => Container(
                                width: 130,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    controller.menusList[index]["subMenu"]
                                        [subIndex]["name"],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  controller.menusList[index]["menu"]["name"] ==
                                          null
                                      ? "No data"
                                      : controller.menusList[index]["menu"]
                                              ["name"] ??
                                          "No data",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  size: 24, // Set icon size
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("No data found"));
          }
        }),
      ],
    );
  }
}

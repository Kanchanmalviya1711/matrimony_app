import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/home/homepage/controller/homepage_controller.dart';

class MenuBarScreen extends StatefulWidget {
  const MenuBarScreen({Key? key}) : super(key: key);
  @override
  State<MenuBarScreen> createState() => _MenuBarScreenState();
}

class _MenuBarScreenState extends State<MenuBarScreen>
    with TickerProviderStateMixin {
  final HomepageController _controller = Get.put(HomepageController());
  @override
  Widget build(BuildContext context) {
    final TabController tabController =
        TabController(length: _controller.menusList.length, vsync: this);
    return Container(
      child: DefaultTabController(
        length: _controller.menusList.length,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              controller: tabController,
              tabs: List.generate(
                _controller.menusList.length,
                (index) => Tab(
                  child: Text(
                    _controller.menusList[index]["menu"]["name"].toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Container(
              height: 400,
              width: double.infinity,
              child: TabBarView(
                controller: tabController,
                children: List.generate(
                  _controller.menusList.length,
                  (index) => Container(
                    child: ListView.builder(
                      itemCount: _controller.menusList[index]['subMenu'].length,
                      itemBuilder: (context, subIndex) {
                        return ListTile(
                          title: Text(_controller.menusList[index]['subMenu']
                              [subIndex]["name"]),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Flutter code sample for [MenuAcceleratorLabel].

class MyMenuBar extends StatelessWidget {
  final HomepageController controller;
  const MyMenuBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: MenuBar(
              children: List.generate(
                controller.menusList.length,
                (index) => SubmenuButton(
                  menuChildren: List.generate(
                      controller.menusList[index]["subMenu"].length,
                      (subIndex) => MenuItemButton(
                            child: MenuAcceleratorLabel(controller
                                .menusList[index]["subMenu"][subIndex]["name"]),
                          )),
                  child: MenuAcceleratorLabel(
                      controller.menusList[index]["menu"]["name"] ?? ""),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

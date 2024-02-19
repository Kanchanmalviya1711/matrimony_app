import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
import 'package:matrimony_app/presentation/ourServices/controller/ourServices_controller.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';

class PageNotFound extends StatefulWidget {
  const PageNotFound({Key? key}) : super(key: key);
  @override
  _PageNotFoundState createState() => _PageNotFoundState();
}

class _PageNotFoundState extends State<PageNotFound> {
  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );
  var scaffoldKey = GlobalKey<ScaffoldState>();
  OurServicesController ourServicesController =
      Get.put(OurServicesController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
          centerTitle: true,
          leading: CustomIconButton(
            child: SvgPicture.asset(
              ImageConstant.menuIcon,
              color: appTheme.whiteA700,
            ),
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: "OUR SERVICES"),
      body: Column(
        children: [
          Expanded(
            child: PagedListView<int, dynamic>(
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate<dynamic>(
                itemBuilder: (context, item, index) {
                  return const Column(
                    children: [
                      Text("Page Not Found"),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      drawer: const SideMenu(),
    );
  }
}

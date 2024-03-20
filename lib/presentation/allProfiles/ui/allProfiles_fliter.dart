import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/allProfiles/controller/allProfiles_controller.dart';
import 'package:matrimony_app/presentation/allProfiles/ui/allProfiles.form.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/size_utils.dart';

class AllProfilesFilter extends StatefulWidget {
  const AllProfilesFilter({Key? key}) : super(key: key);

  @override
  State<AllProfilesFilter> createState() => _AllProfilesFilterFilterState();
}

class _AllProfilesFilterFilterState extends State<AllProfilesFilter> {
  final _formKey = GlobalKey<FormState>();
  late AllProfilesListController allProfilesListController;

  @override
  void initState() {
    super.initState();
    allProfilesListController = Get.put(AllProfilesListController());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: appTheme.gray.withOpacity(0.1),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 30.v),
            child: const SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AllProfilesForm(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

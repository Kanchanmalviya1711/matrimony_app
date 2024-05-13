import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/ProfileListScreen/controller/profileLists_controller.dart';
import 'package:matrimony_app/presentation/ProfileListScreen/ui/profileListForm.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/size_utils.dart';

class ProfileListFilter extends StatefulWidget {
  const ProfileListFilter({
    super.key,
  });
  @override
  State<ProfileListFilter> createState() => _ProfileListFilterState();
}

class _ProfileListFilterState extends State<ProfileListFilter> {
  final _formKey = GlobalKey<FormState>();
  late ProfileListController profileListController;
  @override
  void initState() {
    super.initState();
    profileListController = Get.put(ProfileListController());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(alignment: Alignment.center, children: [
      Container(
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: appTheme.gray.withOpacity(0.1)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.v),
          child: const SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileForm(),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}

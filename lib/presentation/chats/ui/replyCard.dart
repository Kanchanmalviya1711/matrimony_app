import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/theme/theme_helper.dart';

class ReplyCard extends StatefulWidget {
  const ReplyCard({super.key});
  @override
  State<ReplyCard> createState() => _ReplyCardState();
}

class _ReplyCardState extends State<ReplyCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
            elevation: 1,
            color: appTheme.whiteA700,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: const Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 10, top: 5, bottom: 20, right: 60),
                  child: Text("Hey there, ",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 3),
                        child: Text(
                          "20:29",
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

import 'package:matrimony_app/core/app_export.dart';

class ChatingCard extends StatefulWidget {
  const ChatingCard({super.key});

  @override
  State<ChatingCard> createState() => _ChatingCardState();
}

class _ChatingCardState extends State<ChatingCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: const Card(
            elevation: 1,
            color: Color(0xffdcf8c6),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 10, top: 5, bottom: 20, right: 60),
                  child: Text(
                      "fade afdgwsd sgfdwfr sdcwre fadewf adcwfg sdcwfg dcgfa afgdw wgardhetfr sgfegf sgfsf sgafdsgf sgfdsefg sgfgsdf sfsghf sgfdf vsdgsef sgfhg svfgdf vhgsfdsthese",
                      style: TextStyle(fontSize: 16)),
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
                      Icon(
                        Icons.done_all,
                        size: 16,
                        color: Colors.blue,
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/home/ui/home_screen.dart';

class BottomTabs extends StatefulWidget {
  const BottomTabs({super.key});

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int currentPageIndex = 0;

  final tabs = [
    const HomeScreen(),
    Center(child: Text("Search")),
    Center(child: Text("Profile"))
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentPageIndex,
        backgroundColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.segment),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        onTap: (int index) {
          setState(() => currentPageIndex = index);
        });
  }
}

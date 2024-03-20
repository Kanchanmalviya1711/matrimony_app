import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/login/login_screen.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
          duration: kTabScrollDuration, curve: Curves.ease);
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            _buildOnboardingPage(
              imageUrl: ImageConstant.couple1,
              width: 300,
              height: 300,
              title: "Welcome to Matrimony App",
              description:
                  "Welcome to Soulmate Matrimony, where hearts connect! Find your perfect match effortlessly. Start your journey now!",
            ),
            _buildOnboardingPage(
              imageUrl: ImageConstant.couple3,
              width: 300,
              height: 300,
              title: "Find Your Perfect Match",
              description:
                  "Find your perfect match. Begin your journey to love and companionship today!",
            ),
            _buildOnboardingPage(
              imageUrl: ImageConstant.wedding,
              width: 300,
              height: 300,
              title: "Ready to Get Started?",
              description: "Click 'Arrow' to proceed to login.",
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.white,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_circle_left,
                  size: 30,
                ),
                color: Colors.black,
                onPressed: () {
                  _pageController.previousPage(
                      duration: kTabScrollDuration, curve: Curves.ease);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_circle_right,
                  size: 30,
                ),
                color: Colors.red,
                onPressed: _nextPage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(
      {required String imageUrl,
      required String title,
      required String description,
      required double width,
      required double height}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: imageUrl,
            width: width,
            height: height,
          ),
          const SizedBox(height: 20.0),
          Text(
            title,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

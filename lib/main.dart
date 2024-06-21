import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_onboarding_2/dashboard_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

int introduction = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
  );
  await initIntroduction();
  runApp(const MyApp());
}

Future initIntroduction() async {
  final prefs = await SharedPreferences.getInstance();

  int? intro = prefs.getInt('introduction');
  print('intro : ${intro}');
  if (intro != null && intro == 1) {
    return introduction = 1;
  }
  prefs.setInt('introduction', 1);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: introduction == 0
            ? MyHomePage(title: 'Introduction')
            : DashboardScreen());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 19),
        bodyPadding: EdgeInsets.all(16));
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
            title: 'Fractional shares',
            body:
                'Instead of having to buy an entire share, invest any amount you want.',
            image: Image.network(
              'https://images.squarespace-cdn.com/content/v1/5d01440fc4bd93000125725d/1618502557280-0LCMJOM1UKE0NADLT37L/Recruiter-Illustration-KB-NoStroke.png',
              width: 350,
            ),
            decoration: pageDecoration),
        PageViewModel(
            title: 'Learn as you go',
            body:
                'Download the Stockpile app and master the market with our mini-lesson.',
            image: Image.network(
              'https://getcloud.com.br/wp-content/uploads/2019/10/desenvolvedora-web-php.png',
              width: 350,
            ),
            decoration: pageDecoration),
        PageViewModel(
          title: 'Kids and teens',
          body:
              'Kids and teens can track their stocks 24/7 and place trades that you approve',
          image: Image.network(
            'https://www.printgenie.com/images/setting/1563463544VYKkuDUP2HGBJubCeVdi-website-design-in-patna.png',
            width: 350,
          ),
          decoration: pageDecoration,
          footer: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (builder) {
                return DashboardScreen();
              }));
            },
            child: Text(
              'Get Started',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
      onDone: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (builder) {
          return DashboardScreen();
        }));
      },
      showSkipButton: true,
      showNextButton: true,
      showDoneButton: true,
      showBackButton: false,
      dotsFlex: 3,
      nextFlex: 1,
      skipOrBackFlex: 1,
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.bold)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
      dotsDecorator: const DotsDecorator(
          size: Size(10, 10),
          color: Colors.grey,
          activeSize: Size(22, 10),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)))),
    );
  }
}

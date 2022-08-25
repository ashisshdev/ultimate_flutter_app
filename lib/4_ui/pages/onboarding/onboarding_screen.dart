// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'package:ultimate_flutter_app/4_views/homepage/homepage.dart';
//
// class OnBoardingPage extends StatefulWidget {
//   const OnBoardingPage({Key? key}) : super(key: key);
//
//   @override
//   _OnBoardingPageState createState() => _OnBoardingPageState();
// }
//
// class _OnBoardingPageState extends State<OnBoardingPage> {
//   final introKey = GlobalKey<IntroductionScreenState>();
//
//   void _onIntroEnd(context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(builder: (_) => const HomePage()),
//     );
//   }
//
//   Widget _buildImage(String assetName, [double width = 350]) {
//     return Image.asset(assetName, width: width);
//   }
//
//   TextStyle titleTextStyle = getBoldTextStyle(color: ColorManager.backgroundColorLight);
//   TextStyle bodyTextStyle = getRegularTextStyle(color: ColorManager.backgroundColorLight);
//
//   @override
//   Widget build(BuildContext context) {
//     PageDecoration pageDecoration = PageDecoration(
//       titleTextStyle: titleTextStyle,
//       bodyTextStyle: bodyTextStyle,
//       bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//       pageColor: ColorManager.backgroundColorDark,
//       imagePadding: EdgeInsets.zero,
//     );
//
//     return IntroductionScreen(
//       key: introKey,
//       globalBackgroundColor: ColorManager.backgroundColorDark,
//       pages: [
//         PageViewModel(
//           title: "Onboarding Page Title 1",
//           body: "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum.",
//           image: _buildImage(AppAssets.onboardingImage1, 290),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Onboarding Page Title 2",
//           body: "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum.",
//           image: _buildImage(AppAssets.onboardingImage2),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Onboarding Page Title 3",
//           body: "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum.",
//           image: Padding(
//             padding: const EdgeInsets.only(top: 70),
//             child: _buildImage(AppAssets.splashIcon),
//           ),
//           footer: ElevatedButton(
//             onPressed: () {
//               //introKey.currentState?.animateScroll(0);
//               // change theme here instead of goinf back to page 1
//             },
//             child: const Text(
//               'Change App Theme ',
//               style: TextStyle(color: Colors.white),
//             ),
//             style: ElevatedButton.styleFrom(
//               primary: Colors.lightBlue,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//           ),
//           decoration: pageDecoration,
//         ),
//       ],
//       onDone: () => _onIntroEnd(context),
//       //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
//       showSkipButton: true,
//       //rtl: true, // Display as right-to-left
//       back: const Icon(Icons.arrow_back),
//       skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
//       next: const Icon(Icons.arrow_forward),
//       done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
//       curve: Curves.fastLinearToSlowEaseIn,
//       controlsMargin: const EdgeInsets.all(16),
//       controlsPadding: kIsWeb ? const EdgeInsets.all(12.0) : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
//       dotsDecorator: const DotsDecorator(
//         size: Size(10.0, 10.0),
//         color: Color(0xFFBDBDBD),
//         activeSize: Size(22.0, 10.0),
//         activeShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(25.0)),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:loginpage/common/config.dart';
//
// import 'loginPage.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(alignment: Alignment.bottomCenter, children: [
//         Center(
//           child: Container(
//             child: Image.asset(imageAssets.img2, fit: BoxFit.fill),
//             height: double.infinity,
//             width: double.infinity,
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             Get.to(
//               LoginPage(),
//               // transition: Transition.cupertinoDialog, duration: Duration(seconds: 3)
//             );
//           },
//           child: Container(
//             decoration: BoxDecoration(
//                 color: Color(0xffffc52a),
//                 border: Border.all(color: Color(0xffffc52a)),
//                 borderRadius: BorderRadius.circular(20)),
//             padding: EdgeInsets.only(top: 20, bottom: 20, left: 30),
//             margin: EdgeInsets.all(40),
//             child: Row(
//               children: [
//                 Text(
//                   "GET STARTED",
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 150),
//                   child: SvgPicture.asset(svgAssets.arrow),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }

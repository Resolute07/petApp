import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petapp/core/theme/colors.dart';
import 'package:petapp/screens/see_more_pages/ready_to_adopt.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight:ScreenUtil().screenHeight/2.5 ,minHeight:  ScreenUtil().screenHeight/2.8 ),
      height:MediaQuery.of(context).orientation==Orientation.portrait? 190.h:400.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(colors: [
          Color.fromARGB(255, 255, 171, 36),
          Color.fromARGB(255, 235, 144, 26)
        ]),
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.bottomRight,
              child: Image.asset("assets/images/no_bg/perAndPet_nobg.png")),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Find the best pets ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const Text(
                      "in your location",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: const WidgetStatePropertyAll(blue),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const ReadyToAdoptPage();
                            },
                          ));
                        },
                        child: const Text(
                          "View all",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

List<Color> gradientColors = [
  const Color.fromARGB(255, 255, 171, 36),
  const Color.fromARGB(255, 235, 144, 26)
];

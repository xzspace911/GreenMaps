import 'package:flutter/material.dart';
import 'package:flutter_maps/presentation/widgets/xelevated_button.dart';
import 'package:flutter_maps/utils/colors.dart';
import 'package:flutter_maps/utils/strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XColors.darkBackgroundColor,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 170),
                SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset("assets/images/travel.png"),
                ),
                SizedBox(height: 50),
                Text(
                  "Welcome to GreenMaps",
                  style: TextStyle(
                    color: XColors.extraLightColor,
                    fontFamily: XStrings.poppinsFont,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Navigate the world with a sleek dark theme and vibrant green highlights.",
                  style: TextStyle(
                    color: XColors.grey,
                    fontFamily: XStrings.poppinsFont,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                XElevatedButton(
                  onPressed: ()=> Navigator.of(context).pushNamed("/login"),
                  name: "Login",
                  color: XColors.extraLightColor,
                  width: double.infinity,
                  height: 60,
                  radius: 15,
                  txtColor: XColors.black,
                  fontSize: 24,
                  fontFamily: XStrings.poppinsFont,
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: ()=> Navigator.of(context).pushNamed("/createAnAccount"),
                  child: Text(
                    "Create an account",
                    style: TextStyle(
                      fontFamily: XStrings.poppinsFont,
                      color: XColors.extraLightColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

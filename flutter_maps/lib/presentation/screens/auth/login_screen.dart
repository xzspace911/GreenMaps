import 'package:flutter/material.dart';
import 'package:flutter_maps/presentation/widgets/connect_with.dart';
import 'package:flutter_maps/presentation/widgets/xelevated_button.dart';
import 'package:flutter_maps/utils/colors.dart';
import 'package:flutter_maps/utils/strings.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XColors.darkBackgroundColor,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset("assets/images/travel.png"),
                ),
                SizedBox(height: 15),
                Text(
                  "Welcome Back !",
                  style: TextStyle(
                    fontFamily: XStrings.poppinsFont,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: XColors.extraLightColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Navigate Your World, Seamlessly.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: XStrings.poppinsFont,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 25),
                _buildTextField("Username", Iconsax.user),
                SizedBox(height: 15),
                _buildTextField("Password", Iconsax.password_check),
                SizedBox(height: 20),
                XElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed("/home_screen"),
                  name: "Login",
                  color: XColors.extraLightColor,
                  width: double.infinity,
                  height: 60,
                  radius: 15,
                  txtColor: XColors.black,
                  fontSize: 21,
                  fontFamily: XStrings.poppinsFont,
                ),
                SizedBox(height: 8),
                Center(
                  child: TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed("/createAnAccount"),
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account ?  ",
                        style: TextStyle(
                          fontSize: 13,
                          color: XColors.white,
                          fontFamily: XStrings.poppinsFont,
                          fontWeight: FontWeight.w300,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              fontSize: 13,
                              color: XColors.extraLightColor,
                              fontFamily: XStrings.poppinsFont,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ConnectWith(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField(String label, IconData icon) {
  return TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: XColors.white,
          fontFamily: XStrings.poppinsFont,
        ),
      ),
      prefixIcon: Icon(
        icon,
        color: XColors.white,
      ),
    ),
  );
}

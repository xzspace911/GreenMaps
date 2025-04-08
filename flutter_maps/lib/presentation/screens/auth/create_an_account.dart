import 'package:flutter/material.dart';
import 'package:flutter_maps/presentation/widgets/connect_with.dart';
import 'package:flutter_maps/presentation/widgets/xelevated_button.dart';
import 'package:flutter_maps/utils/colors.dart';
import 'package:flutter_maps/utils/strings.dart';
import 'package:iconsax/iconsax.dart';

class CreateAnAccount extends StatefulWidget {
  const CreateAnAccount({super.key});

  @override
  State<CreateAnAccount> createState() => _CreateAnAccountState();
}

class _CreateAnAccountState extends State<CreateAnAccount> {
  bool passwordCheek = true;
  IconData iconData = Iconsax.eye;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XColors.darkBackgroundColor,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create an Account",
                    style: TextStyle(
                        color: XColors.extraLightColor,
                        fontFamily: XStrings.poppinsFont,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 200,
                          child: _buildTextField("First Name", Iconsax.user),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          width: 200,
                          child: _buildTextField("Last Name", Iconsax.user),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildTextField("Email", Iconsax.personalcard),
                  SizedBox(height: 20),
                  _buildTextField("Phone Number", Iconsax.call),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      label: Text(
                        "Password",
                        style: TextStyle(
                          color: XColors.white,
                          fontFamily: XStrings.poppinsFont,
                        ),
                      ),
                      prefixIcon: Icon(
                        Iconsax.password_check,
                        color: XColors.white,
                      ),
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            passwordCheek
                                ? iconData = Iconsax.eye_slash
                                : Iconsax.eye;
                          });
                        },
                        onTapCancel: () {
                          setState(() {
                            passwordCheek
                                ? iconData = Iconsax.eye
                                : Iconsax.eye_slash;
                          });
                        },
                        child: Icon(
                          iconData,
                          color: XColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      label: Text(
                        "Confirm Password",
                        style: TextStyle(
                          color: XColors.white,
                          fontFamily: XStrings.poppinsFont,
                        ),
                      ),
                      prefixIcon: Icon(
                        Iconsax.password_check,
                        color: XColors.white,
                      ),
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            passwordCheek
                                ? iconData = Iconsax.eye_slash
                                : Iconsax.eye;
                          });
                        },
                        onTapCancel: () {
                          setState(() {
                            passwordCheek
                                ? iconData = Iconsax.eye
                                : Iconsax.eye_slash;
                          });
                        },
                        child: Icon(
                          iconData,
                          color: XColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  XElevatedButton(
                    onPressed: () {},
                    name: "Sign Up",
                    color: XColors.extraLightColor,
                    width: double.infinity,
                    height: 60,
                    radius: 15,
                    txtColor: XColors.black,
                    fontSize: 20,
                    fontFamily: XStrings.poppinsFont,
                  ),
                  SizedBox(height: 4),
                  TextButton(
                        onPressed: ()=> Navigator.of(context).pushNamed("/login"),
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account ?  ",
                            style: TextStyle(
                              fontSize: 13,
                              color: XColors.white,
                              fontFamily: XStrings.poppinsFont,
                              fontWeight: FontWeight.w300,
                            ),
                            children: [
                              TextSpan(
                                text: "Log in",
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
                  SizedBox(height: 20),
                  ConnectWith()
                ],
              ),
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

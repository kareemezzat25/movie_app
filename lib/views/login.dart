import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/models/authservice.dart';
import 'package:movies_app/views/forgetpassword.dart';
import 'package:movies_app/views/home.dart';
import 'package:movies_app/views/signup.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LoginView extends StatefulWidget {
  static const String routeName = "Login";
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isObscure = true;

  void login() async {
    try {
      final response = await AuthService.login(
        emailController.text,
        passwordController.text,
      );
      Navigator.pushNamed(context, Home.routeName);
    } catch (e) {
      print("error in Login $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 118.h,
                      width: 121.w,
                    ),
                    SizedBox(
                      height: 66.h,
                    ),
                    TextFormField(
                      style: Theme.of(context).textTheme.titleSmall,
                      controller: emailController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF282A28),
                          labelText: "email".tr(),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          labelStyle: Theme.of(context).textTheme.titleMedium,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: const BorderSide(width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      style: Theme.of(context).textTheme.titleSmall,
                      controller: passwordController,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                          labelText: "password".tr(),
                          labelStyle: Theme.of(context).textTheme.titleMedium,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: const Color(0xFF282A28),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ForgetPasswordView.routeName);
                      },
                      child: Text(
                        textAlign: TextAlign.right,
                        "forget_password".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r))),
                        child: Text(
                          "login".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.black),
                        )),
                    SizedBox(
                      height: 24.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpView.routeName);
                      },
                      child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(children: [
                            TextSpan(
                                text: "don't_have-account".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontSize: 14, color: Colors.white)),
                            TextSpan(
                                text: "create_one".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor))
                          ])),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Theme.of(context).primaryColor,
                            indent: 45,
                            endIndent: 8,
                          ),
                        ),
                        Text(
                          "or".tr(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Theme.of(context).primaryColor,
                            indent: 8,
                            endIndent: 45,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ImageIcon(
                              AssetImage("assets/images/icon_google.png")),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            "login_with_google".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Center(
                      child: ToggleSwitch(
                        minWidth: 90.0,
                        initialLabelIndex:
                            context.locale.toString() == "en" ? 0 : 1,
                        cornerRadius: 20.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        totalSwitches: 2,
                        icons: const [
                          FontAwesomeIcons.flagUsa,
                          MdiIcons.abjadArabic
                        ],
                        activeBgColors: const [
                          [Colors.orange],
                          [Colors.black45]
                        ],
                        onToggle: (index) {
                          if (index == 1) {
                            context.setLocale(const Locale("ar"));
                          } else {
                            context.setLocale(const Locale("en"));
                          }
                        },
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }
}

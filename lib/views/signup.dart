import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/models/authservice.dart';
import 'package:movies_app/views/home.dart';
import 'package:movies_app/views/login.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SignUpView extends StatefulWidget {
  static const String routeName = "Signup";
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  List<String> imagesAvater = [
    "assets/images/gamer1.png",
    "assets/images/gamer2.png",
    "assets/images/gamer3.png",
    "assets/images/gamer4.png",
    "assets/images/gamer5.png",
    "assets/images/gamer6.png",
    "assets/images/gamer7.png",
    "assets/images/gamer8.png",
    "assets/images/gamer9.png",
  ];

  Color textFieldColor = const Color(0xFF282A28);

  int selectedAvatarId = 1;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isObscure = true;

  void signUp() async {
    try {
      final response = await AuthService.signUp(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        phone: phoneController.text.startsWith("+")
            ? phoneController.text
            : "+2${phoneController.text}",
        avatarId: selectedAvatarId,
      );
      Navigator.pushNamedAndRemoveUntil(
          context, LoginView.routeName, (route) => false);
    } catch (e) {
      print("error in Singup:$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "register".tr(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 180,
                      viewportFraction: 0.5,
                      enlargeFactor: 0.3,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          selectedAvatarId = index + 1;
                        });
                      },
                    ),
                    items: imagesAvater.asMap().entries.map((entry) {
                      int index = entry.key;
                      String imagePath = entry.value;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAvatarId = index + 1;
                          });
                        },
                        child: CircleAvatar(
                          radius: 150.r,
                          child: Image.asset(
                            imagePath,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "avater".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.titleSmall,
                    controller: nameController,
                    decoration: InputDecoration(
                        fillColor: textFieldColor,
                        filled: true,
                        labelText: "name".tr(),
                        labelStyle: Theme.of(context).textTheme.titleMedium,
                        prefixIcon: const Icon(
                          Icons.badge_outlined,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.titleSmall,
                    controller: emailController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: textFieldColor,
                        labelText: "email".tr(),
                        labelStyle: Theme.of(context).textTheme.titleMedium,
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r)),
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
                    decoration: InputDecoration(
                      fillColor: textFieldColor,
                      filled: true,
                      labelText: "password".tr(),
                      labelStyle: Theme.of(context).textTheme.titleMedium,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.titleSmall,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: textFieldColor,
                        labelText: "confirm_password".tr(),
                        labelStyle: Theme.of(context).textTheme.titleMedium,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      } else if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.titleSmall,
                    controller: phoneController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: textFieldColor,
                        labelText: "phone".tr(),
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        labelStyle: Theme.of(context).textTheme.titleMedium,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        signUp();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(398.w, 55.h),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r))),
                    child: Text(
                      "create_account".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: const Color(0xFF121312)),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginView.routeName);
                    },
                    child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(children: [
                          TextSpan(
                              text: "already_have_account".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Colors.white,
                                  )),
                          TextSpan(
                              text: "login".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.w900))
                        ])),
                  ),
                  SizedBox(
                    height: 18.h,
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
                  SizedBox(
                    height: 12.h,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/views/login.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SignUpView extends StatelessWidget {
  static const String routeName = "Signup";
  List<String> imagesAvater = [
    "assets/images/gamer1.png",
    "assets/images/gamer2.png",
    "assets/images/gamer3.png",
  ];
  Color textFieldColor = const Color(0xFF282A28);
  SignUpView({super.key});

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
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 180,
                    viewportFraction: 0.5,
                    enlargeFactor: 0.3,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: imagesAvater.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return CircleAvatar(
                          radius: 150,
                          backgroundImage: AssetImage(
                            i,
                          ),
                        );
                      },
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
                TextField(
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
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
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
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  decoration: InputDecoration(
                    fillColor: textFieldColor,
                    filled: true,
                    labelText: "password".tr(),
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: textFieldColor,
                      labelText: "confirm_password".tr(),
                      labelStyle: Theme.of(context).textTheme.titleMedium,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r))),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
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
                ),
                SizedBox(
                  height: 24.h,
                ),
                ElevatedButton(
                  onPressed: () {},
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
        ));
  }
}

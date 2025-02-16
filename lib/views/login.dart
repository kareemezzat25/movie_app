import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/views/signup.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LoginView extends StatelessWidget {
  static const String routeName = "Login";
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Image.asset(
              "assets/images/logo.png",
              height: 118.h,
              width: 121.w,
            ),
            SizedBox(
              height: 66.h,
            ),
            TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF282A28),
                  labelText: "email".tr(),
                  prefixIcon: Icon(
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
            ),
            SizedBox(
              height: 20.h,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "password".tr(),
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white,
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
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              textAlign: TextAlign.right,
              "forget_password".tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 14),
            ),
            SizedBox(
              height: 32.h,
            ),
            ElevatedButton(
                onPressed: () {},
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
                            .copyWith(fontSize: 14, color: Colors.white)),
                    TextSpan(
                        text: "create_one".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Theme.of(context).primaryColor))
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
                  const ImageIcon(AssetImage("assets/images/icon_google.png")),
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
                initialLabelIndex: context.locale.toString() == "en" ? 0 : 1,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                icons: [FontAwesomeIcons.flagUsa, MdiIcons.abjadArabic],
                activeBgColors: [
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
        ));
  }
}

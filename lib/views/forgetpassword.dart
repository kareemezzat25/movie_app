import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordView extends StatelessWidget {
  static const String routeName = "ForgetPassword";
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("forget_password_title".tr(),
            style: Theme.of(context).textTheme.titleSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          Image.asset(
            "assets/images/Forgotpassword.png",
            height: 430.h,
          ),
          SizedBox(
            height: 24.h,
          ),
          TextField(
            decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF282A28),
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
            height: 24.h,
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  minimumSize: Size(398.w, 56.h),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  )),
              child: Text(
                "verify_email".tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black),
              ))
        ]),
      ),
    );
  }
}

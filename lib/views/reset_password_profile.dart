import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/authservice.dart';

class ResetPassword extends StatefulWidget {
  static const String routeName = "resetPassword";

  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController oldPasswordController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  bool isObscure = true;

  String? errorMessage;

  void resetPassword() async {
    final authService = AuthService();
    String? responseMessage = await authService.resetPassword(
      oldPassword: oldPasswordController.text,
      newPassword: newPasswordController.text,
    );

    setState(() {
      errorMessage = responseMessage;
    });

    if (responseMessage != null &&
        responseMessage == "Password updated successfully") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              responseMessage,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            backgroundColor: Theme.of(context).primaryColor),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(responseMessage ?? "Something went wrong"),
            backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password",
            style: Theme.of(context).textTheme.titleSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(children: [
              Image.asset(
                "assets/images/Forgotpassword.png",
                height: 430.h,
              ),
              SizedBox(
                height: 24.h,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.titleSmall,
                controller: oldPasswordController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF282A28),
                    labelText: "Old Password",
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
                    return 'Please enter your Old Password';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 18.h,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.titleSmall,
                controller: newPasswordController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF282A28),
                    labelText: "New Password",
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
                    return 'Please enter your New Password';
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
                      resetPassword();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      minimumSize: Size(398.w, 56.h),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      )),
                  child: Text(
                    "Update Password",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}

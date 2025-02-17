import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/cache.dart';
import 'package:movies_app/models/userservice.dart';
import 'package:movies_app/views/login.dart';
import 'package:movies_app/views/reset_password_profile.dart';

class UpdateProfile extends StatefulWidget {
  static const String routeName = "Updateprofile";
  const UpdateProfile({super.key});

  @override
  UpdateProfileState createState() => UpdateProfileState();
}

class UpdateProfileState extends State<UpdateProfile> {
  String name = '';
  String phone = '';
  String avatarPath = 'assets/images/gamer1.png';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final userService = UserService(token: Cache.getToken()!);
    try {
      final response = await userService.fetchUserProfile();
      setState(() {
        name = response['data']['name'];
        phone = response['data']['phone'];
        int avatarId = response['data']['avaterId'];
        avatarPath = getAvatarImage(avatarId);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteAccount() async {
    final userService = UserService(token: Cache.getToken()!);
    try {
      await userService.deleteAccount();
      Cache.removeToken();
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginView.routeName,
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to delete the account. Please try again.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  String getAvatarImage(int avatarId) {
    switch (avatarId) {
      case 1:
        return 'assets/images/gamer1.png';
      case 2:
        return 'assets/images/gamer2.png';
      case 3:
        return 'assets/images/gamer3.png';
      default:
        return 'assets/images/gamer1.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Pick Avatar", style: Theme.of(context).textTheme.titleSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 120.r,
                      child: Image.asset(avatarPath,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(height: 34.h),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    tileColor: const Color(0xFF282A28),
                    leading: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  SizedBox(height: 18.h),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    tileColor: const Color(0xFF282A28),
                    leading: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    title: Text(
                      phone,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  SizedBox(height: 28.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ResetPassword.routeName);
                    },
                    child: Text(
                      "Reset Password",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      deleteAccount();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      minimumSize: Size(398.w, 56.h),
                      backgroundColor: const Color(0xFFE82626),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      "Delete Account",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      minimumSize: Size(398.w, 56.h),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      "Update Data",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: const Color(0xFF121312)),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

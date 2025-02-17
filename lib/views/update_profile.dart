import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/cache.dart';
import 'package:movies_app/models/userservice.dart';

class UpdateProfile extends StatefulWidget {
  static const String routeName = "updateProfile";

  @override
  UpdateProfileState createState() => UpdateProfileState();
}

class UpdateProfileState extends State<UpdateProfile> {
  String selectedAvatar = "assets/images/gamer1.png";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
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
        nameController.text = response['data']['name'];
        emailController.text = response['data']['email'];
        phoneController.text = response['data']['phone'];
        int avatarId = response['data']['avaterId'];
        selectedAvatar = getAvatarImage(avatarId);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateProfile() async {
    final userService = UserService(token: Cache.getToken()!);

    final Map<String, dynamic> requestBody = {};

    if (nameController.text.isNotEmpty) {
      requestBody["name"] = nameController.text;
    }
    if (emailController.text.isNotEmpty) {
      requestBody["email"] = emailController.text;
    }
    if (phoneController.text.isNotEmpty) {
      requestBody["phone"] = phoneController.text;
    }
    if (selectedAvatar.isNotEmpty) {
      int avatarId = avatars.indexOf(selectedAvatar) + 1;
      requestBody["avaterId"] = avatarId;
    }

    try {
      final response = await userService.updateUserProfile(requestBody);

      if (response['message'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response['message'],
              style: Theme.of(context).textTheme.titleMedium,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update profile")),
      );
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
      case 4:
        return 'assets/images/gamer4.png';
      case 5:
        return 'assets/images/gamer5.png';
      case 6:
        return 'assets/images/gamer6.png';
      case 7:
        return 'assets/images/gamer7.png';
      case 8:
        return 'assets/images/gamer8.png';
      case 9:
        return 'assets/images/gamer9.png';

      default:
        return 'assets/images/gamer1.png';
    }
  }

  final List<String> avatars = [
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

  void showAvatarSelection() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(10),
          height: 300,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: avatars.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = avatars[index];
                  });
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(avatars[index]),
                  radius: 40,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Profile",
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: showAvatarSelection,
                      child: CircleAvatar(
                        radius: 120.r,
                        child: Image.asset(
                          selectedAvatar,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    SizedBox(height: 34.h),
                    TextField(
                      controller: nameController,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        labelText: "Name",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white),
                        filled: true,
                        fillColor: const Color(0xFF282A28),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(16.r)),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: emailController,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        labelText: "Email",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white),
                        filled: true,
                        fillColor: const Color(0xFF282A28),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(16.r)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: phoneController,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        labelText: "Phone",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white),
                        filled: true,
                        fillColor: const Color(0xFF282A28),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(16.r)),
                      ),
                    ),
                    SizedBox(height: 34.h),
                    ElevatedButton(
                      onPressed: () {
                        updateProfile();
                        print(
                            "Saved: ${nameController.text}, ${emailController.text}, ${phoneController.text}");
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(398.w, 56.h),
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                      ),
                      child: Text("Save",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.black)),
                    ),
                  ],
                ),
              ),
      ),
      backgroundColor: Colors.black,
    );
  }
}

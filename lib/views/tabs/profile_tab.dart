import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/cache.dart';
import 'package:movies_app/models/userservice.dart';
import 'package:movies_app/views/login.dart';
import 'package:movies_app/views/editprofile.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String name = '';
  String avatarPath = 'assets/images/gamer1.png';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchProfile();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchProfile() async {
    final userService = UserService(token: Cache.getToken()!);
    try {
      final response = await userService.fetchUserProfile();
      setState(() {
        name = response['data']['name'];
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

  Future<void> _onRefresh() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    await fetchProfile();
  }

  void logout() {
    Cache.removeToken();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginView.routeName,
      (route) => false,
    );
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
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await fetchProfile();
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      color: const Color(0xFF212121),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 60.r,
                                    child: Image.asset(
                                      avatarPath,
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  SizedBox(height: 14.h),
                                  Text(name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w700)),
                                ],
                              ),
                              SizedBox(width: 20.w),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text("12",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(fontSize: 36.sp)),
                                      Text("Wish List",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                    ],
                                  ),
                                  SizedBox(width: 38.w),
                                  Column(
                                    children: [
                                      Text("10",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(fontSize: 36.sp)),
                                      Text("History",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(253.w, 56.h),
                                      backgroundColor:
                                          Theme.of(context).primaryColor),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, EditProfile.routeName);
                                  },
                                  child: Text("Edit Profile",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(color: Colors.black)),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(134.w, 56.h),
                                      backgroundColor: const Color(0xFFE82626)),
                                  onPressed: logout,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Exit",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                      SizedBox(width: 10.w),
                                      const Icon(Icons.logout,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          TabBar(
                            controller: _tabController,
                            indicatorColor: Theme.of(context).primaryColor,
                            labelStyle: Theme.of(context).textTheme.titleMedium,
                            unselectedLabelColor: Colors.white,
                            tabs: [
                              Tab(
                                icon: Icon(
                                  Icons.list,
                                  color: Theme.of(context).primaryColor,
                                ),
                                text: "Watch List",
                              ),
                              Tab(
                                  icon: Icon(
                                    Icons.folder,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  text: "History"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Center(
                              child: Icon(Icons.local_movies,
                                  size: 80,
                                  color: Theme.of(context).primaryColor)),
                          Center(
                              child: Icon(Icons.history,
                                  size: 80,
                                  color: Theme.of(context).primaryColor)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

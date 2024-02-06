import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_log/config/constants/api_endpoint.dart';
import 'package:travel_log/core/common/provider/is_dark_theme.dart';
import 'package:travel_log/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:travel_log/features/home/presentation/viewmodel/home_viewmodel.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  late bool isDark;

  @override
  void initState() {
    isDark = ref.read(isDarkThemeProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authState = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authViewModelProvider.notifier).getUserProfile();
            },
            icon: Icon(
              Icons.replay,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(homeViewModelProvider.notifier).logout(context);
            },
            icon: Icon(
              Icons.logout,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: authState.user.length,
          itemBuilder: (context, index) {
            var userDetail = authState.user[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(),
                  child: authState.user[index].image != null
                      ? Image.network(
                          ApiEndpoints.imageUrl + authState.user[index].image!,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Text("No Image"),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userDetail.username,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Eye button pressed for username
                              },
                              icon: const Icon(
                                Icons.remove_red_eye,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Edit button pressed for username
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userDetail.email,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Eye button pressed for email
                              },
                              icon: const Icon(
                                Icons.remove_red_eye,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Edit button pressed for email
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userDetail.phone,
                              style: const TextStyle(fontSize: 18),
                            ),
                            IconButton(
                              onPressed: () {
                                // Eye button pressed for phone
                              },
                              icon: const Icon(
                                Icons.remove_red_eye,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Edit button pressed for phone
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

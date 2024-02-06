import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_log/core/common/provider/is_dark_theme.dart';
import 'package:travel_log/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:travel_log/features/details/viewmodel/detail_view_model.dart';
import 'package:travel_log/features/details/presentation/view/enter_details.dart';
import 'package:travel_log/features/details/presentation/view/trip_view.dart';

import '../../../../config/router/app_route.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  late bool isDark;
  int _selectedindex = 0;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> lstbscreen = [
    const TripView(),
    const EnterDetails(),
  ];
  @override
  void initState() {
    isDark = ref.read(isDarkThemeProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authState = ref.watch(authViewModelProvider);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: _selectedindex == 0
            ? const Text('Your Links')
            : const Text('Create your Link'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(detailViewModelProvider.notifier).getAllDetails();
            },
            icon: Icon(
              Icons.replay,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu), // Hamburger icon
          onPressed: () {
            // Open the drawer when the hamburger icon is clicked
            scaffoldKey.currentState?.openDrawer();
          },
        ),

        centerTitle: true, // Center the title horizontally
      ),
      body: lstbscreen[_selectedindex],
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authState.user.isNotEmpty
                        ? authState.user[0].username
                        : 'Username',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Dark Mode / Light Mode Switch
            ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: isDark,
                onChanged: (value) {
                  // Toggle dark mode
                  setState(() {
                    isDark = value;
                    ref.read(isDarkThemeProvider.notifier).updateTheme(value);
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Edit Profile'),
              trailing: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.profileRoute);
                },
                child: Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: Icon(
                    Icons.settings,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 4.0,
        child: BottomNavigationBar(
          unselectedItemColor: isDark ? Colors.white : Colors.black,
          selectedItemColor: Colors.red,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'Add',
            ),
          ],
          currentIndex: _selectedindex,
          onTap: (index) {
            setState(() {
              _selectedindex = index;
            });
          },
        ),
      ),
    );
  }
}

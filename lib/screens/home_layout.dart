import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:merhab/controllers/auth_controller.dart';
import 'package:merhab/screens/chat_bot_screen.dart';
import 'package:merhab/theme/themes.dart';
import 'package:merhab/screens/home_screen.dart';
import 'package:merhab/screens/map_screen.dart';
import 'package:merhab/screens/profile_screen.dart';
import 'package:merhab/widgets/drawer.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final List<Widget> _screens = [
    const HomeScreen(),
    const MapScreen(),
    const ProfileScreen(),
    const ChatBotScreen(),
  ];

  late int currentPage;
  late TabController tabController;

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 4, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawer: AppDrawer(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatBotScreen(),
              ),
            );
          },
          backgroundColor: AppTheme.primaryLavenderColor,
          child: const Icon(Icons.chat),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      Text(
                        'Welcome, ${Get.find<AuthController>().userData.firstName ?? ''}!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkGreenColor,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          _key.currentState?.openEndDrawer();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BottomBar(
                    fit: StackFit.expand,
                    icon: (width, height) => Center(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: null,
                        icon: Icon(
                          Icons.arrow_upward_rounded,
                          color: Colors.white,
                          size: width,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(500),
                    duration: Duration(seconds: 1),
                    curve: Curves.decelerate,
                    showIcon: true,
                    width: MediaQuery.of(context).size.width * 0.8,
                    barColor: AppTheme.primaryGreenColor,
                    start: 2,
                    end: 0,
                    offset: 10,
                    barAlignment: Alignment.bottomCenter,
                    iconHeight: 35,
                    iconWidth: 35,
                    reverse: false,
                    hideOnScroll: true,
                    scrollOpposite: false,
                    onBottomBarHidden: () {},
                    onBottomBarShown: () {},
                    body: (context, controller) => TabBarView(
                      controller: tabController,
                      dragStartBehavior: DragStartBehavior.down,
                      physics: const BouncingScrollPhysics(),
                      children: _screens,
                    ),
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                      controller: tabController,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          color: AppTheme.secondaryLavenderColor,
                          width: 4,
                        ),
                        insets: EdgeInsets.fromLTRB(16, 0, 16, 8),
                      ),
                      tabs: [
                        SizedBox(
                          height: 55,
                          width: 40,
                          child: Center(
                              child: Icon(
                            Icons.home,
                            color: currentPage == 0
                                ? AppTheme.secondaryLavenderColor
                                : Colors.white,
                          )),
                        ),
                        SizedBox(
                          height: 55,
                          width: 40,
                          child: Center(
                              child: Icon(
                            Icons.search,
                            color: currentPage == 1
                                ? AppTheme.secondaryLavenderColor
                                : Colors.white,
                          )),
                        ),
                        SizedBox(
                          height: 55,
                          width: 40,
                          child: Center(
                              child: Icon(
                            Icons.map,
                            color: currentPage == 2
                                ? AppTheme.secondaryLavenderColor
                                : Colors.white,
                          )),
                        ),
                        SizedBox(
                          height: 55,
                          width: 40,
                          child: Center(
                              child: Icon(
                            Icons.settings,
                            color: currentPage == 3
                                ? AppTheme.secondaryLavenderColor
                                : Colors.white,
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Obx(() => Get.find<AuthController>().isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox()),
          ],
        ),
      ),
    );
  }
}

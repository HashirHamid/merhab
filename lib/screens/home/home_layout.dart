import 'package:flutter/material.dart';
import 'package:merhab/screens/chat/chat_bot_screen.dart';
import 'package:merhab/theme/themes.dart';
import 'package:merhab/screens/home/home_screen.dart';
import 'package:merhab/screens/home/map_screen.dart';
import 'package:merhab/screens/home/profile_screen.dart';
import 'package:merhab/screens/emergency/emergency_screen.dart';
import 'package:merhab/screens/travel/travel_info_screen.dart';
import 'package:merhab/screens/transportation/transportation_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _selectedIndex = 0;
  String _selectedLanguage = 'English';
  final _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final List<Widget> _screens = [
    const HomeScreen(),
    const MapScreen(),
    const ProfileScreen(),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      // Handle sign out
      // TODO: Implement sign out logic
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatBotScreen(),
            ),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.chat),
      ),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        toolbarHeight: 120,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Dropdown
            DropdownButton<String>(
              value: _selectedLanguage,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              elevation: 16,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                  ),
              underline: Container(
                height: 0,
              ),
              onChanged: (String? value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                // TODO: Implement language change logic
              },
              selectedItemBuilder: (context) => [
                Center(
                  child: Text(
                    'English',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                Center(
                  child: Text(
                    'Arabic',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
              items: ['English', 'Arabic']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(width: 16),
            // Search Field
            TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _key.currentState?.openEndDrawer();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Personal Info'),
              onTap: () {
                // TODO: Navigate to personal info
              },
            ),
            ListTile(
              leading: const Icon(Icons.flight),
              title: const Text('Travel Info'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TravelInfoScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.emergency),
              title: const Text('Emergency'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmergencyScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text('Transportation'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransportationScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sports_esports),
              title: const Text('Activities'),
              onTap: () {
                // TODO: Navigate to activities
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Market'),
              onTap: () {
                // TODO: Navigate to market
              },
            ),
            ListTile(
              leading: const Icon(Icons.archive),
              title: const Text('Archive'),
              onTap: () {
                // TODO: Navigate to archive
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_support),
              title: const Text('Contact Us'),
              onTap: () {
                // TODO: Navigate to contact us
              },
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Sign Out',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}

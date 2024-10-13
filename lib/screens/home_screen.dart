import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petapp/core/theme/colors.dart';
import 'package:petapp/screens/bottom_bar_pages.dart/favourite_page.dart';
import 'package:petapp/screens/bottom_bar_pages.dart/history_page.dart';
import 'package:petapp/screens/bottom_bar_pages.dart/home_content.dart';
import 'package:petapp/screens/bottom_bar_pages.dart/profile_page.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key,});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 

 late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    
    _pages = [
      const HomeContent(),
      const FavouritePage(),
      const HistoryPage(),
      const ProfilePage(),
    ];
  }
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?. openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: TextButton(
          onPressed: () {},
          child: const Row(
            children: [
              Icon(Icons.location_city),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text("Bengaluru, Karnataka "),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notification_add_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: TextButton(
                child: Hero(
                  tag: 'History',
                  child: Material(
                    child: Text(
                      "History",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const HistoryPage();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar:MediaQuery.of(context).orientation==Orientation.portrait || (kIsWeb) ? Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(30, 0, 0, 0),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(36),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: _buildAnimatedIcon(Icons.home, _currentIndex == 0),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildAnimatedIcon(Icons.favorite, _currentIndex == 1),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildAnimatedIcon(Icons.shopping_cart, _currentIndex == 2),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildAnimatedIcon(Icons.person, _currentIndex == 3),
              label: '',
            ),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ):SizedBox(),
    );
  }

  Widget _buildAnimatedIcon(IconData iconData, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isSelected ? 50 : 40, 
      height: isSelected ? 50 : 40, 
      decoration: BoxDecoration(
        color: isSelected ? blue : Colors.transparent,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(10),
      child: Icon(
        iconData,
        color: isSelected ? Colors.white : const Color.fromARGB(255, 110, 110, 110),
        size: isSelected ? 24 : 18, 
      ),
    );
  }
}

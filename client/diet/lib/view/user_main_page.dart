import 'package:diet/user/view/login_screen.dart';
import 'package:diet/user/view/profile_page.dart';
import 'package:diet/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserMainPage extends StatefulWidget {
  @override
  _UserMainPageState createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  int _selectedIndex = 0;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    4,
    (index) => GlobalKey<NavigatorState>(),
  );

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      _navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => _getPageForIndex(index),
          );
        },
      ),
    );
  }

  Widget _getPageForIndex(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return DietPage();
      case 2:
        return BlogPage();
      case 3:
        return ProfilePage();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: List.generate(
          _navigatorKeys.length,
          (index) => _buildOffstageNavigator(index),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Diet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Text('Home Page Content'),
      ),
    );
  }
}

class DietPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diet Page')),
      body: Center(
        child: Text('Diet Page Content'),
      ),
    );
  }
}


// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   void _logout(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Profile Page')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Profile Page Content'),
//             const SizedBox(height: 20),
//             CustomButton(
//               text: 'Logout',
//               onPressed: () => _logout(context),
//               backgroundColor: Colors.red,
//               textColor: Colors.white,
//               borderRadius: 8.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Profile Page')),
//       body: Center(
//         child: Text('Profile Page Content'),
//       ),
//     );
//   }
// }

class BlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blog Page')),
      body: Center(
        child: Text('Blog Page Content'),
      ),
    );
  }
}






// class SettingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Settings Page')),
//       body: Center(
//         child: Text('Settings Page Content'),
//       ),
//     );
//   }
// }






























// import 'package:flutter/material.dart';

// class UserMainPage extends StatefulWidget {
//   @override
//   _UserMainPageState createState() => _UserMainPageState();
// }

// class _UserMainPageState extends State<UserMainPage> {
//   int _selectedIndex = 0;
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text('Home Page Content'),
//     Text('Diet Page Content'),
//     Text('Profile Page Content'),
//     Text('Blog Page Content'),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Main Page'),
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.fastfood),
//             label: 'Diet',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.article),
//             label: 'Blog',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

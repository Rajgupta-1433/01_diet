import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Diet App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              elevation: 10,
              shadowColor: Colors.black,
              centerTitle: true,
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}





























// // import 'package:firebase_login/ui/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';  // This file will be generated
// import 'package:firebase_app_check/firebase_app_check.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     await FirebaseAppCheck.instance.activate(
//       androidProvider: AndroidProvider.playIntegrity,
//     );
//   } catch (e) {
//     print('Firebase initialization error: $e');
//   }
//   runApp(const ProviderScope(child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(360, 690), // Change to your design size
//       builder: (context, child) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Diet App',
//           theme: ThemeData(
//             colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//             useMaterial3: true,
//             appBarTheme: AppBarTheme(
//               backgroundColor: Colors.orange,
//               foregroundColor: Colors.white,
//               elevation: 10,
//               shadowColor: Colors.black,
//               centerTitle: true,
//             ),
//           ),
//           home: const MainScreen(),
//         );
//       },
//     );
//   }
// }

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;
//   final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
//     4,
//     (index) => GlobalKey<NavigatorState>(),
//   );

//   void _onItemTapped(int index) {
//     if (_selectedIndex == index) {
//       _navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
//     } else {
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
    
//       @override
//       Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//       }
//   }

//   Widget _buildOffstageNavigator(int index) {
//     return Offstage(
//       offstage: _selectedIndex != index,
//       child: Navigator(
//         key: _navigatorKeys[index],
//         onGenerateRoute: (routeSettings) {
//           return MaterialPageRoute(
//             builder: (context) => _getPageForIndex(index),
//           );
//         },
//       ),
//     );
//   }

//   Widget _getPageForIndex(int index) {
//     switch (index) {
//       case 0:
//         return HomePage();
//       case 1:
//         return DietPage();
//       case 2:
//         return ProfilePage();
//       case 3:
//         return BlogPage();
//       default:
//         return HomePage();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: List.generate(
//           _navigatorKeys.length,
//           (index) => _buildOffstageNavigator(index),
//         ),
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
//         backgroundColor: Colors.white,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// // Example main pages
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home Page')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Home Page Content'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DietPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Diet Page')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Diet Page Content'),
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
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Profile Page Content'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BlogPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Blog Page')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Blog Page Content'),
//           ],
//         ),
//       ),
//     );
//   }
// }

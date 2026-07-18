
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_daily_fitness_app_ui/index_page.dart';
import 'package:flutter_daily_fitness_app_ui/screen/login_screen.dart';
import 'firebase_options.dart'; // This will be generated when you run `flutterfire configure`

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase using the generated options
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Firebase initialization error: $e");
    // If firebase_options.dart is missing, it will throw an error.
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Daily Fitness App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // StreamBuilder listens to auth state changes to route appropriately
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            // User is signed in
            return IndexPage();
          }
          // User is not signed in
          return const LoginScreen();
        },
      ),
    );
  }
}

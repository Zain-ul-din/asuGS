import 'package:asugs/constants.dart';
import 'package:asugs/screens/data_entry.dart';
import 'package:asugs/screens/home.dart';
import 'package:asugs/screens/login.dart';
import 'package:asugs/screens/qrcode.dart';
import 'package:asugs/screens/splash.dart';
import 'package:asugs/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
            create: (ctx) => AuthService().getAuth().userChanges(),
            initialData: null)
      ],
      child: MaterialApp(
        title: 'Grid Scout',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: kPrimaryColor,
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (ctx) => SplashScreen(),
          '/login': (ctx) => const LoginScreen(),
          '/': (ctx) => const HomeScreen(),
          '/qrcode': (ctx) => const QrCode(),
          '/data_entry': (ctx) => const DataEntryPage()
        },
        // home: HomePage(),
      ),
    );
  }
}

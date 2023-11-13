import 'package:flutter/material.dart';
import 'package:flutter_application_1/Splashpage.dart';
import 'package:flutter_application_1/User_repository.dart';
import 'package:flutter_application_1/bloc/auth_bloc.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/firebaseprovider.dart';
import 'package:flutter_application_1/loginview.dart';
import 'package:flutter_application_1/profilepage.dart';
import 'package:flutter_application_1/registrationview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(UserRepository(FirebaseProvider())),
      child: MaterialApp(
        title: 'Flutter Firebase Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
       
      
    
      routes: {
        '/login': (context) => LoginView(),
        '/register': (context) => RegistrationView(),
        '/profile': (context) => ProfilePage(),
      },
    ),
    );
  }
}
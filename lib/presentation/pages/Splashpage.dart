import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/loginview.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  _navigateToNextPage() async {
    await Future.delayed(Duration(seconds: 3)); 
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginView())); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animate/edu1.json'), 
            SizedBox(height: 30), 
            Text(
              'BLUE',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple, 
              ),
            ),
            SizedBox(height: 10), 
            Text(
              'Добро пожаловать!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600], 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
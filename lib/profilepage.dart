import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String email = '';
  String name = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? '';
      name = prefs.getString('name') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile_picture.png'), 
                backgroundColor: Colors.deepPurple[100],
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Имя'),
                        subtitle: Text(name),
                        leading: Icon(Icons.person, color: Colors.deepPurple),
                      ),
                      ListTile(
                        title: Text('Электронная почта'),
                        subtitle: Text(email),
                        leading: Icon(Icons.email, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.edit),
                label: Text('Редактировать профиль'),
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
              ),
              TextButton.icon(
                icon: Icon(Icons.logout),
                label: Text('Выйти'),
                onPressed: () {
                  
                },
                style: TextButton.styleFrom(primary: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
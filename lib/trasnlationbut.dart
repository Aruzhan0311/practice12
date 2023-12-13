import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TranslationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.language),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Select Language'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    context.setLocale(Locale('en'));
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, 
                    textStyle: TextStyle(color: Colors.white), 
                  ),
                  child: Text('English'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.setLocale(Locale('ru'));
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  child: Text('Russian'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.setLocale(Locale('kk', ));
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  child: Text('Kazakh'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
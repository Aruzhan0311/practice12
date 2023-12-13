import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/colors.dart';

class CoursePostWidget extends StatelessWidget {
  final String title;
  final String imagePath;

  CoursePostWidget({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shadowColor: MYColors.blueGreyColor,
      elevation: 5,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            height: 200.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: MYColors.primaryColor,
              ),
            ),
          ),
          Divider(color: MYColors.primaryColor), 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text('Подробнее', style: TextStyle(color: MYColors.primaryColor)),
                  onPressed: () {
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: MYColors.primaryColor, 
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border, color: MYColors.primaryColor),
                  onPressed: () {
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
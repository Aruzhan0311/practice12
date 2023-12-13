import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/presentation/bloc/bloc/course_bloc.dart';
import 'package:flutter_application_1/presentation/bloc/bloc/course_state.dart';
import 'package:flutter_application_1/presentation/widgets/cards_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text('Курсы')),
        body: BlocBuilder<CoursesBloc, CourseState>(
          builder: (context, state) {
            if (state is CoursesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CoursesLoaded) {
              return ListView.builder(
                itemCount: state.courses.length,
                itemBuilder: (context, index) {
                  var course = state.courses[index];
                  return CoursePostWidget(
                    title: course.name,
                    imagePath: course.image_path,
                  );
                },
              );
            } else if (state is CoursesError) {
              return Center(child: Text('Ошибка: ${state.message}'));
            }
            return Center(child: Text('Добро пожаловать в список курсов'));
          },
        ),
    );
  }
}
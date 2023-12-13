import 'package:flutter_application_1/data/models/course_model.dart';

abstract class CourseState {}

class CoursesInitial extends CourseState {}

class CoursesLoading extends CourseState {}

class CoursesLoaded extends CourseState {
  final List<Course> courses;

  CoursesLoaded(this.courses);
}

class CoursesError extends CourseState {
  final String message;

  CoursesError(this.message);
}
import 'package:flutter_application_1/data/models/course_model.dart';
import 'package:flutter_application_1/data/repository/course_rep.dart';

class GetCoursesUseCase {
  final CoursesApi api;

  GetCoursesUseCase(this.api);

  Future<List<Course>> call() async {
    return await api.getCourses();
  }
}
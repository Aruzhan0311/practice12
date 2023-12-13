import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/models/course_model.dart';
import 'package:retrofit/retrofit.dart';


part 'course_rep.g.dart';

@RestApi(baseUrl: "https://education-27652-default-rtdb.firebaseio.com/")
abstract class CoursesApi {
  factory CoursesApi(Dio dio, {String baseUrl}) = _CoursesApi;

  @GET("/courses.json")
  Future<List<Course>> getCourses();
}
import 'package:flutter_application_1/domain/uses_case/use_case_course.dart';
import 'package:flutter_application_1/presentation/bloc/bloc/course_event.dart';
import 'package:flutter_application_1/presentation/bloc/bloc/course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesBloc extends Bloc<CourseEvent, CourseState> {
  final GetCoursesUseCase getCoursesUseCase;

  CoursesBloc(this.getCoursesUseCase) : super(CoursesInitial()) {
    on<LoadCourses>((event, emit) async {
      emit(CoursesLoading());
      try {
        final courses = await getCoursesUseCase();
        emit(CoursesLoaded(courses));
      } catch (e) {
        emit(CoursesError(e.toString()));
      }
    });
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repository/course_rep.dart';
import 'package:flutter_application_1/domain/uses_case/use_case_course.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/generated/codegen_loader.g.dart';
import 'package:flutter_application_1/presentation/bloc/bloc/course_bloc.dart';
import 'package:flutter_application_1/presentation/bloc/bloc/course_event.dart';
import 'package:flutter_application_1/presentation/pages/Splashpage.dart';
import 'package:flutter_application_1/presentation/pages/course.dart';
import 'package:flutter_application_1/presentation/pages/loginview.dart';
import 'package:flutter_application_1/presentation/pages/profilepage.dart';
import 'package:flutter_application_1/presentation/pages/registrationview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/repository/user_repository.dart';
import 'presentation/bloc/auth/auth_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final userRepository = UserRepository(
    FirebaseAuth.instance,
    FirebaseFirestore.instance,
  );

  final dio = Dio();
  final coursesApi = CoursesApi(dio);
  final getCoursesUseCase = GetCoursesUseCase(coursesApi);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('kk'), Locale('ru')],
      path: 'assets/translations', 
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
    child: MyApp(
    userRepository: userRepository, 
    getCoursesUseCase: getCoursesUseCase,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final GetCoursesUseCase getCoursesUseCase;

  MyApp({required this.userRepository, required this.getCoursesUseCase});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(userRepository),
        ),
       BlocProvider<CoursesBloc>(
          create: (context) => CoursesBloc(getCoursesUseCase)..add(LoadCourses()),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        routes: {
          '/register': (context) => RegistrationView(),
          '/profile': (context) => ProfilePage(),
          '/login': (context) => LoginView(),
          '/courses': (context) => CoursesScreen(),
        },
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:flutter_application_1/generated/locale_keys.g.dart';
import 'package:flutter_application_1/trasnlationbut.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_application_1/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_application_1/presentation/bloc/auth/auth_event.dart';
import 'package:flutter_application_1/presentation/bloc/auth/auth_state.dart';
import 'package:flutter_application_1/presentation/pages/profilepage.dart';


class RegistrationView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Registration.tr()),
        backgroundColor: MYColors.primaryColor,
        actions: [
            TranslationButton(),
          ], 
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ошибка: ${state.message}')),
                );
              }
              if (state is AuthSuccess) {
                saveUserData();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                  (Route<dynamic> route) => false,
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.Name.tr(),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите имя';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                 TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.Age.tr(),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите ваш возраст';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.Email.tr(),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => EmailValidator.validate(value ?? '')
                      ? null
                      : "Введите корректный адрес электронной почты",
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.Password.tr(),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите пароль';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MYColors.primaryColor 
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context).add(
                        AuthSignUpRequested(
                          emailController.text,
                          passwordController.text,
                          ageController.text,
                          nameController.text,
                        ),
                      );
                    }
                  },
                  child: Text(LocaleKeys.SignUp.tr()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveUserData() async {
    FirebaseFirestore.instance.collection('users').doc(emailController.text).set({
      'name': nameController.text,
      'email': emailController.text,
      'age': ageController.text, 
    });
  }
}
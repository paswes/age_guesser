import 'package:age_guesser/cubit/age_cubit.dart';
import 'package:age_guesser/pages/home_page.dart';
import 'package:age_guesser/api/age_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      title: 'Age Guesser',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => NameAgeCubit(ageApi: AgeApi()),
        child: const HomePage(),
      ),
    );
  }
}

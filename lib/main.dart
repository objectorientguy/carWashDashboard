import 'package:car_wash_dashboard/configs/app_route.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_module.dart';
import 'firebase_options.dart';
import 'modules/dashboard/bloc/bloc.dart';
import 'modules/dashboard/dashboard_top_bar.dart';

void main() async {
  await _initFirebase();
  await _initDependencies();
  runApp(const MyApp());
}

_initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

_initDependencies() async {
  configurableDependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            lazy: false, create: (BuildContext context) => DashboardBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Dashboard',
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DashboardScreen(),
      ),
    );
  }
}

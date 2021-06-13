import 'package:flutter/material.dart';
import 'package:lever/core/dependency_management/injection/InjectorProvider.dart';
import 'package:lever/core/dependency_management/injection/injector.dart';
import 'package:lever/features/hive_management/presentation/screens/hive_add_screen.dart';
import 'package:lever/features/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var injector = Injector();
  await injector.initiate();
  runApp(MyApp(
    injector: injector,
  ));
}

class MyApp extends StatelessWidget {
  final Injector injector;

  const MyApp({Key key, this.injector}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InjectorProvider(
      injector: this.injector,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.indigo,
            primaryVariant: Colors.deepPurple,
            onPrimary: Colors.white,
            secondary: Colors.amber,
            secondaryVariant: Colors.yellow,
            onSecondary: Colors.black54,
            surface: Colors.white,
            onSurface: Colors.black54,
            background: Colors.white,
            onBackground: Colors.black54,
            error: Colors.red,
            onError: Colors.white,
          ),
        ),
        routes: {
          '/': (BuildContext context) => HomeScreen(),
          'addHive': (BuildContext context) => AddHiveView(),
        },
      ),
    );
  }
}

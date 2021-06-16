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
    var textColor = Colors.blueGrey[900];
    var background = Colors.white;
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
            onPrimary: background,
            secondary: Colors.amber,
            secondaryVariant: Colors.yellow,
            onSecondary: textColor,
            surface: background,
            onSurface: textColor,
            background: background,
            onBackground: textColor,
            error: Colors.red,
            onError: background,
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

import 'package:flutter/material.dart';
import 'package:lever/core/dependency_management/injection/InjectorProvider.dart';
import 'package:lever/core/dependency_management/injection/injector.dart';

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
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

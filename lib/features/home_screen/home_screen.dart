import 'package:flutter/material.dart';
import 'package:lever/core/dependency_management/injection/InjectorProvider.dart';
import 'package:lever/core/dependency_management/injection/injector.dart';
import 'package:lever/features/home_screen/logic/home_screen_model.dart';
import 'package:provider/provider.dart';

import 'components/home_components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Injector _injector;
  @override
  Widget build(BuildContext context) {
    _injector = InjectorProvider.of(context).injector;
    return ChangeNotifierProvider<HomeScreenModel>(
      create: (context) => HomeScreenModel(
        _injector.getFetchHivesCmnd,
        _injector.getDeleteHiveCmnd,
        _injector.getSearchHiveCmnd,
        _injector.getFetchHiveCmnd,
      ),
      child: Scaffold(
        body: Container(
          child: Consumer<HomeScreenModel>(
            builder: (__, HomeScreenModel model, _) => HomeHivesList(
              model: model,
            ),
          ),
        ),
        bottomNavigationBar: HomeBottomNavigationBar(),
      ),
    );
  }
}

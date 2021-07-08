import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lever/core/components/global_view_components.dart';
import 'package:lever/core/dependency_management/injection/InjectorProvider.dart';
import 'package:lever/features/app/presentation/logic/app_view_logic.dart';
import 'package:lever/features/hive_management/presentation/components/hive_view_components.dart';
import 'package:lever/features/hive_management/presentation/components/visit_view_components.dart';
import 'package:lever/features/hive_management/presentation/logic/visit_hive_logic.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';

enum VisitMode { regularVisit, changeQueen, harvestHoney }

class VisitScreen extends StatefulWidget {
  const VisitScreen({Key key}) : super(key: key);

  @override
  _VisitScreenState createState() => _VisitScreenState();
}

class _VisitScreenState extends State<VisitScreen> {
  VisitMode visitMode = VisitMode.regularVisit;
  List<String> pictures=[];
  Map<String, dynamic> regularVisitData;

  Map<String, dynamic> changeQueenData;
  Map<String, dynamic> harvestHoneyData;

  @override
  void initState() {
    regularVisitData = {
      'hiveId': '',
      'date': DateTime.now(),
      'pictures': pictures,
      'description': '',
      'behavior': '',
      'queenSeen': false,
      'honeyMaking': '',
      'frames': 0,
      'stairs': 0,
      'status': '',
    };
    changeQueenData = {
      'hiveId': '',
      'date': DateTime.now(),
      'pictures': pictures,
      'description': '',
      'enterDate': DateTime(0),
      'breed': '',
      'backColor': 0,
    };
    harvestHoneyData = {
      'hiveId': '',
      'date': DateTime.now(),
      'pictures': pictures,
      'description': '',
      'describedAmount': '',
      'weight': 0,
      'frames': 0,
      'quality': '',
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _injector = InjectorProvider.of(context).injector;
    String hiveId =
        Provider.of<AppLogic>(context, listen: false).selectedHiveId;
    return WillPopScope(
      child: ChangeNotifierProvider<VisitHiveLogic>(create: (context) {
        return VisitHiveLogic(_injector.getRegularHiveVisitCmnd);
      }, builder: (context, _) {
        return Consumer<VisitHiveLogic>(builder: (context, model, _) {
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 120),
                    child: SingleChildScrollView(
                      child: buildInputs(context),
                    ),
                  ),
                  BottomButtonSet(
                      onBackPressed: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      rightActionChild: Icon(Icons.check),
                      rightAction: () {
                        switch (visitMode) {
                          case VisitMode.regularVisit:
                            regularVisitData['hiveId'] = hiveId;
                            model.saveRegularVisit(regularVisitData);
                            Navigator.of(context).pushReplacementNamed('/');
                            break;
                          case VisitMode.changeQueen:
                            // TODO: Handle this case.
                            break;
                          case VisitMode.harvestHoney:
                            // TODO: Handle this case.
                            break;
                        }
                      })
                ],
              ),
            ),
          );
        });
      }),
      onWillPop: () => Navigator.of(context).pushReplacementNamed('/'),
    );
  }

  Widget buildInputs(BuildContext context) {
    switch (visitMode) {
      case VisitMode.regularVisit:
        return buildRegularVisitInputs(context);
        break;
      case VisitMode.harvestHoney:
        return buildHarvestHoneyInputs(context);
        break;
      case VisitMode.changeQueen:
        return buildChangeQueenInputs(context);
        break;
    }
    return Container();
  }

  Column buildHarvestHoneyInputs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildDefaultVisitInputs(context),
      ],
    );
  }

  Column buildChangeQueenInputs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildDefaultVisitInputs(context),
      ],
    );
  }

  Column buildRegularVisitInputs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildDefaultVisitInputs(context),
        SizedBox(
          height: 20,
        ),
        StatusSection(
          setData: setRegularVisitData,
        ),
        SizedBox(
          height: 20,
        ),
        EggingStatusSection(setData: setRegularVisitData),
        SizedBox(
          height: 20,
        ),
        QueenSeenStatus(setData: setRegularVisitData),
        SizedBox(
          height: 20,
        ),
        //QueenCells(setData: setRegularVisitData), //TODO: add to entities
        HoneyStatus(setData: setRegularVisitData),
        SizedBox(
          height: 20,
        ),
        BehaviorStatus(setData: setRegularVisitData),
        SizedBox(
          height: 20,
        ),
        FrameStairsSection(setData: setRegularVisitData),
        SizedBox(
          height: 20,
        ),
        NotesSection(setData: setRegularVisitData),
      ],
    );
  }

  Column buildDefaultVisitInputs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildVisitModeButtonBar(context),
        SizedBox(
          height: 20,
        ),
        TakeVisitImagesSection(setData: setRegularVisitData),
        SizedBox(
          height: 20,
        ),
        buildVisitDateSection(),
      ],
    );
  }

  Column buildVisitDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'تاریخ'),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(_getNowDate()),
        )
      ],
    );
  }

  Row buildVisitModeButtonBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(
          shape: StadiumBorder(),
          color: visitMode == VisitMode.regularVisit
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          textColor: visitMode == VisitMode.regularVisit
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onSecondary,
          onPressed: () {
            setState(() {
              visitMode = VisitMode.regularVisit;
            });
          },
          child: Text('بازدید'),
        ),
        MaterialButton(
          shape: StadiumBorder(),
          color: visitMode == VisitMode.harvestHoney
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          textColor: visitMode == VisitMode.harvestHoney
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onSecondary,
          onPressed: () {
            setState(() {
              visitMode = VisitMode.harvestHoney;
            });
          },
          child: Text('برداشت عسل'),
        ),
        MaterialButton(
          shape: StadiumBorder(),
          color: visitMode == VisitMode.changeQueen
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          textColor: visitMode == VisitMode.changeQueen
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onSecondary,
          onPressed: () {
            setState(() {
              visitMode = VisitMode.changeQueen;
            });
          },
          child: Text('تعویض ملکه'),
        ),
      ],
    );
  }

  void setRegularVisitData(String key, value) {
    setState(() {
      regularVisitData[key] = value;
    });
  }

  String _getNowDate() {
    Jalali date = Jalali.now();
    return date.year.toString() +
        '/' +
        date.month.toString() +
        '/' +
        date.day.toString();
  }
}

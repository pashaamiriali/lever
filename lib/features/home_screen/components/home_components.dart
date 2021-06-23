import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lever/core/components/global_view_components.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/presentation/logic/hive_add_view_logic.dart';
import 'package:lever/features/home_screen/logic/home_screen_model.dart';

class HomeHivesList extends StatelessWidget {
  final HomeScreenModel model;
  const HomeHivesList({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hive>>(
        future: model.hives,
        builder: (context, snapshot) {
          Widget _child = CircularProgressIndicator();
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              _child = Center(child: Text('هنوز هیچ کندویی وجود ندارد'));
            } else {
              List<Hive> _hives = snapshot.data;
              _child = ListView.builder(
                  itemCount: _hives.length,
                  itemBuilder: (context, index) {
                    var hive = _hives[index];
                    return HomeHivesListItem(hive: hive, model: model);
                  });
            }
          } else if (snapshot.hasError) {
            print(snapshot.error);
            _child = Center(
              child: Text('خطا در بارگذاری'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: _child,
          );
        });
  }
}

class HomeHivesListItem extends StatefulWidget {
  const HomeHivesListItem({
    Key key,
    @required this.hive,
    this.model,
  }) : super(key: key);
  final HomeScreenModel model;
  final Hive hive;

  @override
  _HomeHivesListItemState createState() => _HomeHivesListItemState();
}

class _HomeHivesListItemState extends State<HomeHivesListItem> {
  bool _showContext = false;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onBackground,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(33),
        color: Colors.transparent,
      ),
      child: _isLoading?CircularProgressIndicator(): InkWell(
        onLongPress: () {
          setState(() {
            _showContext = true;
          });
        },
        child: _showContext
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        _showContext = false;
                      });
                    },
                    child: Icon(Icons.arrow_back_rounded),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                        widget.model.deleteHive(widget.hive.id);
                      });
                    },
                    child: Row(
                      children: [Icon(Icons.delete), Text('حذف')],
                    ),
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('وضعیت:' + widget.hive.populationInfo.status),
                      Text('آخرین بازدید:' +
                          widget.hive.visits.first.date.toString())
                    ],
                  ),
                  Text(
                    widget.hive.number.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: this._showHivePicture(widget.hive, context)),
                ],
              ),
      ),
    );
  }

  Widget _showHivePicture(Hive hive, BuildContext context) {
    if (hive.picture != null && hive.picture.isNotEmpty) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(55),
          image: DecorationImage(
            image: FileImage(
              File(hive.picture),
            ),
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.onBackground,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      );
    } else {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(55),
          border: Border.all(
            color: Theme.of(context).colorScheme.onBackground,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: Text('N/A'),
        ),
      );
    }
  }
}

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                color: Theme.of(context).colorScheme.background,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 1)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  shape: StadiumBorder(),
                  color: Theme.of(context).colorScheme.background,
                  elevation: 0,
                  highlightElevation: 0,
                  onPressed: () {},
                  child: Text('جستجو'),
                ),
                MaterialButton(
                  shape: StadiumBorder(),
                  color: Theme.of(context).colorScheme.background,
                  elevation: 0,
                  highlightElevation: 0,
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('addHive'),
                  child: Text('افزودن'),
                ),
              ],
            ),
          ),
        ),
        VoiceCommandButton(),
      ],
    );
  }
}

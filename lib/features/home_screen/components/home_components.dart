import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lever/core/components/global_view_components.dart';
import 'package:lever/features/app/presentation/logic/app_view_logic.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/home_screen/logic/home_screen_model.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';

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
  bool _showContextMenu = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onBackground,
          width: 1,
          style: BorderStyle.solid,
        ),
        image: (widget.hive.picture != null && widget.hive.picture.isNotEmpty)
            ? DecorationImage(
                image: FileImage(
                  File(widget.hive.picture),
                ),
                fit: BoxFit.cover,
              )
            : null,
        borderRadius: BorderRadius.circular(33),
        color: Colors.transparent,
      ),
      child: _isLoading
          ? CircularProgressIndicator()
          : InkWell(
              onTap: () {
                Provider.of<AppLogic>(context, listen: false).selectedHiveId =
                    widget.hive.id;
                Navigator.of(context).pushReplacementNamed('hiveDetails');
              },
              onLongPress: () {
                setState(() {
                  _showContextMenu = true;
                });
              },
              child: _showContextMenu
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          color: Theme.of(context).colorScheme.background,
                          textColor: Theme.of(context).colorScheme.onBackground,
                          shape:StadiumBorder(),
                          onPressed: () {
                            setState(() {
                              _showContextMenu = false;
                            });
                          },
                          child: Icon(Icons.arrow_back_rounded),
                        ),
                        MaterialButton(
                          color: Theme.of(context).colorScheme.background,
                          textColor: Theme.of(context).colorScheme.onBackground,
                          shape:StadiumBorder(),
                          onPressed: () {
                            showDeleteDialog(context);
                          },
                          child: Row(
                            children: [Icon(Icons.delete), Text('حذف')],
                          ),
                        ),MaterialButton(
                          color: Theme.of(context).colorScheme.background,
                          textColor: Theme.of(context).colorScheme.onBackground,
                          shape:StadiumBorder(),
                          onPressed: () {
                            Provider.of<AppLogic>(context,listen:false).selectedHiveId=widget.hive.id;
                            Navigator.of(context).pushReplacementNamed('visit');
                          },
                          child: Row(
                            children: [Icon(Icons.visibility_rounded), Text('بازدید')],
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(23)),
                                child: Text(
                                  'وضعیت: ' + widget.hive.populationInfo.status,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(23)),
                                  child: Text(
                                      'آخرین بازدید: ' + _getLastVisitDate()))
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius:
                                    BorderRadiusDirectional.circular(23)),
                            child: Text(
                              widget.hive.number.toString(),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
    );
  }

  Future<dynamic> showDeleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('حذف کندو'),
            content: Text('آیا از حذف کندو مطمئنید؟'),
            actions: [
              CancelButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('لغو'),
              ),
              PrimaryButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    widget.model.deleteHive(widget.hive.id);
                  });
                  Navigator.of(context).pop();
                },
                child: Text('حذف'),
              ),
            ],
          );
        });
  }

  String _getLastVisitDate() {
    Jalali date = Jalali.fromDateTime(widget.hive.visits.first.date);
    return date.year.toString() +
        '/' +
        date.month.toString() +
        '/' +
        date.day.toString();
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

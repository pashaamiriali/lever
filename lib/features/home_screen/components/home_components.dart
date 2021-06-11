import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
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
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onBackground,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(23),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text('وضعیت:' + hive.populationInfo.status),
                              Text('آخرین بازدید:' +
                                  hive.visits.first.date.toString())
                            ],
                          ),
                          Text(
                            hive.number.toString(),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          hive.picture != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(55),
                                      image: DecorationImage(
                                          image:
                                              FileImage(File(hive.picture)))))
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(55),
                                  ),
                                  child: Center(
                                    child: Text('N/A'),
                                  ),
                                ),
                        ],
                      ),
                    );
                  });
            }
          } else if (snapshot.hasError) {
            print(snapshot.error);
            _child = Center(
              child: Text('خطا در بارگذاری'),
            );
          }
          return _child;
        });
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
                      color: Theme.of(context).colorScheme.onBackground,
                      blurRadius: 5)
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
                  onPressed: () {},
                  child: Text('افزودن'),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 80,
          width: 80,
          margin: EdgeInsets.only(bottom: 30),
          child: MaterialButton(
            onPressed: () {},
            color: Colors.amber,
            elevation: 20,
            shape: StadiumBorder(),
            child: Center(child: Text('VO')),
          ),
        ),
      ],
    );
  }
}

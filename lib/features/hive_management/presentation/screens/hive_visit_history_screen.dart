import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lever/core/components/global_view_components.dart';
import 'package:lever/core/dependency_management/injection/InjectorProvider.dart';
import 'package:lever/features/app/presentation/logic/app_view_logic.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'hive_visit_history_detail_screen.dart';
//todo: loads visits from other hives
class HiveVisitHistoryScreen extends StatelessWidget {
  const HiveVisitHistoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 20, bottom: 70),
              child: Column(
                children: [
                  Expanded(
                      flex: 1, child: InputTitle(text: 'تاریخجه بازدید ها')),
                  Expanded(
                    flex: 1,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: [
                        SizedBox(
                          width: 90,
                          child: CancelButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.sort),
                                Text('ترتیب'),
                              ],
                            ),
                          ),
                        ),
                        CustomTextField(
                          widthInPercent: 0.6,
                          hintText: 'جستجو',
                          controller: TextEditingController(),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: FutureBuilder<List<Visit>>(
                        future: InjectorProvider.of(context)
                            .injector
                            .getFetchVisitsCmnd
                            .execute({
                          'hive_id':
                              Provider.of<AppLogic>(context).selectedHiveId
                        }),
                        builder: (context, snapshot) {
                          if (snapshot.hasData)
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                var visit = snapshot.data[index];
                                Widget _itemContent =
                                    Center(child: Text('بدون داده'));
                                if (visit is RegularVisit)
                                  _itemContent = Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text('وضعیت: ' +
                                              visit.populationInfo.status),
                                          Text('تاریخ: ' +
                                              _getPersianDate(visit.date)),
                                        ],
                                      ),
                                      Text(
                                        'بازدید',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      )
                                    ],
                                  );
                                if (visit is ChangeQueen)
                                  _itemContent = Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                              'نژاد: ' + visit.queenInfo.breed),
                                          Text('تاریخ: ' +
                                              _getPersianDate(visit.date)),
                                        ],
                                      ),
                                      Text(
                                        'تعویض ملکه',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      )
                                    ],
                                  );
                                if (visit is HarvestHoney)
                                  _itemContent = Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text('مقدار: ' +
                                              visit.weight.toString()),
                                          Text('تاریخ: ' +
                                              _getPersianDate(visit.date)),
                                        ],
                                      ),
                                      Text(
                                        'برداشت عسل',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      )
                                    ],
                                  );

                                return Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    image: (visit.pictures.isNotEmpty &&
                                            visit.pictures[0] != null &&
                                            visit.pictures[0].isNotEmpty)
                                        ? DecorationImage(
                                            image: FileImage(
                                              File(visit.pictures[0]),
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                    borderRadius: BorderRadius.circular(33),
                                    color: Colors.transparent,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              VisitDetailScreen(visit: visit),
                                        ),
                                      );
                                    },
                                    child: _itemContent,
                                  ),
                                );
                              },
                            );
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Center(
                                child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CircularProgressIndicator()));

                          return Center(child: Text('خطا در بار گزاری'));
                        }),
                  ),
                ],
              ),
            ),
            BottomButtonSet(
              onBackPressed: () {
                Navigator.of(context).pop();
              },
              rightAction: () {
               Navigator.of(context).pushReplacementNamed('visit');
              },
              rightActionChild: Icon(Icons.visibility_rounded),
            ),
          ],
        ),
      ),
    );
  }

  String _getPersianDate(DateTime dt) {
    Jalali date = Jalali.fromDateTime(dt);
    return date.year.toString() +
        '/' +
        date.month.toString() +
        '/' +
        date.day.toString();
  }
}

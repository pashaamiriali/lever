import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lever/core/components/global_view_components.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/presentation/components/hive_view_components.dart';
import 'package:shamsi_date/shamsi_date.dart';

class VisitDetailScreen extends StatelessWidget {
  const VisitDetailScreen({Key key, this.visit}) : super(key: key);
  final Visit visit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildTopPanel(context, visit),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildBottomPanel(context, visit),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 40,
                width: 80,
                margin: EdgeInsets.only(bottom: 30),
                child: MaterialButton(
                  onPressed: () => Navigator.of(context).pop(),
                  color: Theme.of(context).colorScheme.surface,
                  elevation: 10,
                  shape: StadiumBorder(),
                  child: Center(child: Icon(Icons.arrow_back)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildBottomPanel(BuildContext context, Visit visit) {
    List<Widget> infoBoxes = [Center(child: Text('هیچ داده ای وجود ندارد'))];
    if (visit is RegularVisit)
      infoBoxes = [
        VisitDetailInfoBox(title: 'وضعیت', info: visit.populationInfo.status),
        VisitDetailInfoBox(
            title: 'وضعيت ملكه',
            info: visit.queenSeen ? 'ديده شد' : 'دیده نشد'),
        VisitDetailInfoBox(
            title: 'تعداد قاب', info: visit.populationInfo.frames.toString()),
        VisitDetailInfoBox(
            title: 'تعداد طبق', info: visit.populationInfo.stairs.toString()),
        VisitDetailInfoBox(title: 'رفتار', info: visit.behavior),
        VisitDetailInfoBox(title: 'وضعیت تولید عسل', info: visit.honeyMaking),
        VisitDetailInfoBox(title: 'توضیحات', info: visit.description),
      ];
    if (visit is HarvestHoney)
      infoBoxes = [
        VisitDetailInfoBox(title: 'وزن به کیلو', info: visit.weight.toString()),
        VisitDetailInfoBox(title: 'مقدار توصیفی', info: visit.describedAmount),
        VisitDetailInfoBox(title: 'تعداد قاب', info: visit.frames.toString()),
        VisitDetailInfoBox(title: 'کیفیت', info: visit.quality),
        VisitDetailInfoBox(title: 'توضیحات', info: visit.description),
      ];
    if (visit is ChangeQueen)
      infoBoxes = [
        VisitDetailInfoBox(
            title: 'تاریخ ورود ملکه',
            info: _getPersianDate(visit.queenInfo.enterDate)),
        Column(
          children: [
            InputTitle(text: 'رنگ پشت ملکه'),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                border: Border.all(
                    color: Theme.of(context).colorScheme.onBackground,
                    width: 1,
                    style: BorderStyle.solid),
                color: visit.queenInfo != null &&
                        visit.queenInfo.backColor.isNotEmpty
                    ? Color(int.parse(visit.queenInfo.backColor))
                    : Colors.transparent,
              ),
              child: Text(visit.queenInfo != null &&
                      visit.queenInfo.backColor.isNotEmpty
                  ? getColorNameFromCode(int.parse(visit.queenInfo.backColor))
                  : 'وارد نشده'),
            ),
          ],
        ),
        VisitDetailInfoBox(
          title: 'نژاد',
          info: visit.queenInfo.breed,
        ),
        VisitDetailInfoBox(
          title: 'توضیحات',
          info: visit.description,
        ),
      ];

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.27),
      padding: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.63,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(23),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 120),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            runSpacing: 20,
            runAlignment: WrapAlignment.spaceBetween,
            spacing: 20,
            children: infoBoxes,
          ),
        ),
      ),
    );
  }

  Container buildTopPanel(
    BuildContext context,
    Visit visit,
  ) {
    String visitMode = '';
    if (visit is RegularVisit) visitMode = 'بازدید';
    if (visit is ChangeQueen) visitMode = 'تعویض ملکه';
    if (visit is HarvestHoney) visitMode = 'برداشت عسل';

    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: (visit.pictures.isEmpty || visit.pictures[0].isNotEmpty)
            ? null
            : DecorationImage(
                image: FileImage(File(visit.pictures[0])),
                fit: BoxFit.cover,
              ),
      ),
      child: Stack(
        children: [
          buildShowImageInkwell(context, visit),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputTitle(
                      text: _getPersianDate(visit.date),
                    ),SizedBox(width: 10),
                    Text(visitMode)
                  ],
                ),
              ),
              buildShowImagesSection(context, visit),
            ],
          ),
        ],
      ),
    );
  }

  MaterialButton buildShowImagesSection(BuildContext context, Visit visit) {
    return MaterialButton(
      color: Theme.of(context).colorScheme.background,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_context) =>
                ShowVisitPicturesScreen(pictures: visit.pictures),
          ),
        );
      },
      shape: StadiumBorder(),
      child: Text('نمایش تاریخچه'),
    );
  }

  InkWell buildShowImageInkwell(BuildContext context, Visit visit) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: (visit.pictures.isEmpty ||
                              visit.pictures[0].isNotEmpty)
                          ? null
                          : DecorationImage(
                              image: FileImage(File(visit.pictures[0])),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.only(bottom: 30),
                        child: MaterialButton(
                          onPressed: () => Navigator.of(context).pop(),
                          color: Theme.of(context).colorScheme.surface,
                          elevation: 10,
                          shape: StadiumBorder(),
                          child: Center(
                            child: Icon(Icons.close),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            });
      },
    );
  }
}

class VisitDetailInfoBox extends StatelessWidget {
  const VisitDetailInfoBox({
    Key key,
    @required this.title,
    @required this.info,
  }) : super(key: key);

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputTitle(text: title),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            border: Border.all(
                color: Theme.of(context).colorScheme.onBackground,
                width: 1,
                style: BorderStyle.solid),
          ),
          child: Text(
            info == null || info.isEmpty ? 'وارد نشده' : info,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }
}

String _getPersianDate(DateTime dt) {
  Jalali date = Jalali.fromDateTime(dt);
  return date.year.toString() +
      '/' +
      date.month.toString() +
      '/' +
      date.day.toString();
}

class ShowVisitPicturesScreen extends StatelessWidget {
  const ShowVisitPicturesScreen({Key key, this.pictures}) : super(key: key);
  final List<String> pictures;

  @override
  Widget build(BuildContext context) {
//TODO: sliding tabs
    return Container();
  }
}


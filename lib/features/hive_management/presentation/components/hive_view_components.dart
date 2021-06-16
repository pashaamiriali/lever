import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lever/core/components/global_view_components.dart';
import 'package:lever/core/dependency_management/injection/InjectorProvider.dart';
import 'package:lever/core/dependency_management/injection/injector.dart';
import 'package:lever/core/infrastructure/camera/take_picture_screen.dart';
import 'package:lever/features/hive_management/presentation/logic/hive_add_view_logic.dart';

class NotesSection extends StatelessWidget {
  final AddHiveViewLogic model;
  const NotesSection({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'یادداشت'),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            maxLines: 8,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(23)),
                hintText: 'توضیحات و یادداشت را اینجا بنویسید',
                hintTextDirection: TextDirection.rtl),
          ),
        ),
      ],
    );
  }
}

class AnnualHoneySection extends StatelessWidget {
  final AddHiveViewLogic model;
  const AnnualHoneySection({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'عسل سالیانه'),
        CustomTextField(
          widthInPercent: 0.4,
          hintText: 'وزن به کیلو',
          controller: TextEditingController(),
          inputType: TextInputType.number,
        ),
      ],
    );
  }
}

class StatusSection extends StatelessWidget {
  final AddHiveViewLogic model;
  const StatusSection({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'وضعیت'),
        Wrap(
          children: [
            MaterialButton(
              onPressed: () {
                //TODO: implement onpressed
              },
              child: Text('selectable button'),
              elevation: 0,
              focusElevation: 0,
              shape: StadiumBorder(),
            ),
          ],
        ),
      ],
    );
  }
}

class FrameStairsSection extends StatelessWidget {
  final AddHiveViewLogic model;
  const FrameStairsSection({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'قاب/طبق'),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomTextField(
              widthInPercent: 0.4,
              hintText: 'تعداد قاب',
              controller: TextEditingController(),
              inputType: TextInputType.number,
            ),
            SizedBox(
              width: 10,
            ),
            CustomTextField(
              widthInPercent: 0.4,
              hintText: 'تعداد طبق',
              controller: TextEditingController(),
              inputType: TextInputType.number,
            ),
          ],
        ),
      ],
    );
  }
}

class QueenBackColorSection extends StatelessWidget {
  final AddHiveViewLogic model;
  const QueenBackColorSection({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'رنگ پشت ملکه'),
        DropdownButton(items: [
          DropdownMenuItem(
              child: Row(
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.red),
              ),
              Text('قرمز')
            ],
          )),
        ]),
      ],
    );
  }
}

class QueenEnterDateSection extends StatelessWidget {
  final AddHiveViewLogic model;
  const QueenEnterDateSection({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'تاریخ ورود ملکه'),
        Wrap(
          children: [
            CustomTextField(
              widthInPercent: 0.3,
              hintText: 'سال',
              controller: TextEditingController(),
              inputType: TextInputType.number,
            ),
            SizedBox(
              width: 10,
            ),
            CustomTextField(
              widthInPercent: 0.3,
              hintText: 'ماه',
              controller: TextEditingController(),
              inputType: TextInputType.number,
            ),
            SizedBox(
              width: 10,
            ),
            CustomTextField(
              widthInPercent: 0.3,
              hintText: 'روز',
              controller: TextEditingController(),
              inputType: TextInputType.number,
            ),
          ],
        ),
      ],
    );
  }
}

class BreedSection extends StatelessWidget {
  final AddHiveViewLogic model;
  const BreedSection({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'نژاد'),
        Align(
            alignment: Alignment.centerRight,
            child: CustomTextField(
              widthInPercent: 0.7,
              hintText: 'نام نژاد را وارد کنید',
              controller: TextEditingController(),
            )),
        Wrap(
          children: [
            MaterialButton(
              onPressed: () {
                //TODO: implement onpressed
              },
              child: Text('selectable button'),
              elevation: 0,
              focusElevation: 0,
              shape: StadiumBorder(),
            ),
          ],
        ),
      ],
    );
  }
}

class HiveNumberSection extends StatelessWidget {
  final AddHiveViewLogic model;
  const HiveNumberSection({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'شماره کندو'),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              onPressed: () {
                //TODO: implement onpressed
              },
              child: Text('تولید شماره'),
              elevation: 0,
              focusElevation: 0,
              shape: StadiumBorder(),
            ),
            CustomTextField(
              widthInPercent: 0.4,
              hintText: 'وارد کنید',
              controller: TextEditingController(),
              inputType: TextInputType.number,
            ),
          ],
        ),
      ],
    );
  }
}

class TakeImageSection extends StatefulWidget {
  final AddHiveViewLogic model;
  const TakeImageSection({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _TakeImageSectionState createState() => _TakeImageSectionState();
}

class _TakeImageSectionState extends State<TakeImageSection> {
  File _picture;
  @override
  Widget build(BuildContext context) {
    Injector _injector = InjectorProvider.of(context).injector;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.onBackground,
                  width: 1,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(200),
              image: _picture != null
                  ? DecorationImage(
                      image: FileImage(_picture), fit: BoxFit.cover)
                  : null),
          child: Center(
            child: _picture == null ? Text('خالی') : Container(),
          ),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TakePictureScreen(
                      camera: _injector.camera,
                      captureMode: CaptureMode.forHive,
                      hivePictureTakenCallback: imageCapturedCallback,
                    )));
          },
          child: Text('گرفتن عکس'),
          elevation: 0,
          focusElevation: 0,
          shape: StadiumBorder(),
        ),
      ],
    );
  }

  void imageCapturedCallback(String imagePath) {
    setState(() {
      this._picture = File(imagePath);
      widget.model.picture = imagePath;
    });
  }
}

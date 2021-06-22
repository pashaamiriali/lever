import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lever/core/components/global_view_components.dart';
import 'package:lever/core/dependency_management/injection/InjectorProvider.dart';
import 'package:lever/core/dependency_management/injection/injector.dart';
import 'package:lever/core/infrastructure/camera/take_picture_screen.dart';
import 'package:lever/features/hive_management/presentation/logic/hive_add_view_logic.dart';
import 'package:shamsi_date/extensions.dart';

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

class QueenEnterDateSection extends StatefulWidget {
  final AddHiveViewLogic model;
  const QueenEnterDateSection({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _QueenEnterDateSectionState createState() => _QueenEnterDateSectionState();
}

class _QueenEnterDateSectionState extends State<QueenEnterDateSection> {
  TextEditingController _dayController, _monthController, _yearController;
  @override
  void initState() {
    super.initState();
    _dayController = TextEditingController();
    _monthController = TextEditingController();
    _yearController = TextEditingController();
    _dayController
        .addListener(() => _listenForValidation(_validateDayField, 'day'));
    _monthController
        .addListener(() => _listenForValidation(_validateMonthField, 'month'));
    _yearController
        .addListener(() => _listenForValidation(_validateYearField, 'year'));
  }

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
              controller: _yearController,
              inputType: TextInputType.number,
            ),
            SizedBox(
              width: 10,
            ),
            CustomTextField(
              widthInPercent: 0.3,
              hintText: 'ماه',
              controller: _monthController,
              inputType: TextInputType.number,
            ),
            SizedBox(
              width: 10,
            ),
            CustomTextField(
              widthInPercent: 0.3,
              hintText: 'روز',
              controller: _dayController,
              inputType: TextInputType.number,
            ),
          ],
        ),
      ],
    );
  }

  void _listenForValidation(Function validator, String fieldName) {
    if (!validator())
      widget.model.invalidFields.add(fieldName);
    else if (widget.model.invalidFields.contains(fieldName))
      widget.model.invalidFields.remove(fieldName);
  }

  bool _validateDayField() {
    try {
      int day = int.parse(_dayController.text);
      if (day > 0 && day < 32)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

  bool _validateMonthField() {
    try {
      int month = int.parse(_monthController.text);
      if (month > 0 && month < 13)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

  bool _validateYearField() {
    try {
      int year = int.parse(_yearController.text);
      if (year > 0 && year < Jalali.now().year + 1)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }
}

class BreedSection extends StatefulWidget {
  final AddHiveViewLogic model;
  const BreedSection({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _BreedSectionState createState() => _BreedSectionState();
}

class _BreedSectionState extends State<BreedSection> {
  TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(() => _setModelText());
    super.initState();
  }

  void _setModelText() {
    widget.model.breed = _controller.text;
  }

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
              controller: _controller,
            )),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<int>(
              future: model.generateHiveNumber(),
              builder: (context, snapshot) {
                var theme = Theme.of(context);
                if (snapshot.hasData)
                  return Center(
                    child: Text(snapshot.data.toString()),
                  );
                else if (snapshot.hasError)
                  return Center(
                    child: Text(
                      'خطا در تولید شماره',
                      style: theme.textTheme.headline6
                          .copyWith(color: theme.colorScheme.error),
                    ),
                  );
                return Center(child: CircularProgressIndicator());
              }),
        )
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

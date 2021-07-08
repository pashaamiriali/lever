import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lever/core/components/global_view_components.dart';
import 'package:lever/core/dependency_management/injection/InjectorProvider.dart';
import 'package:lever/core/dependency_management/injection/injector.dart';
import 'package:lever/core/infrastructure/camera/take_picture_screen.dart';
import 'package:lever/features/hive_management/presentation/logic/hive_add_view_logic.dart';
import 'package:shamsi_date/extensions.dart';

class NotesSection extends StatefulWidget {
  final Function setData;

  const NotesSection({
    Key key,
    @required this.setData,
  }) : super(key: key);

  @override
  _NotesSectionState createState() => _NotesSectionState();
}

class _NotesSectionState extends State<NotesSection> {
  TextEditingController notesController;

  @override
  void initState() {
    super.initState();
    notesController = TextEditingController();
    notesController.addListener(() {
      widget.setData('description', notesController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotesInput(notesController: notesController);
  }
}

class NotesInput extends StatelessWidget {
  const NotesInput({
    Key key,
    @required this.notesController,
  }) : super(key: key);

  final TextEditingController notesController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'یادداشت'),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            controller: notesController,
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

class AnnualHoneySection extends StatefulWidget {
  final Function setData;

  const AnnualHoneySection({
    Key key,
    @required this.setData,
  }) : super(key: key);

  @override
  _AnnualHoneySectionState createState() => _AnnualHoneySectionState();
}

class _AnnualHoneySectionState extends State<AnnualHoneySection> {
  TextEditingController annualHoneyController;
  String lastValidValue = '';

  @override
  void initState() {
    annualHoneyController = TextEditingController();
    annualHoneyController.addListener(() {
      if (annualHoneyController.text.isEmpty) return;
      if (validateField(annualHoneyController.text)) {
        widget.setData('annualHoney', int.parse(annualHoneyController.text));

        setState(() {
          lastValidValue = annualHoneyController.text;
        });
      } else {
        setState(() {
          annualHoneyController.text = lastValidValue;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnualHoneyInput(annualHoneyController: annualHoneyController);
  }

  bool validateField(String value) {
    try {
      int.parse(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class AnnualHoneyInput extends StatelessWidget {
  const AnnualHoneyInput({
    Key key,
    @required this.annualHoneyController,
  }) : super(key: key);

  final TextEditingController annualHoneyController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'عسل سالیانه'),
        CustomTextField(
          widthInPercent: 0.4,
          hintText: 'وزن به کیلو',
          controller: annualHoneyController,
          inputType: TextInputType.number,
        ),
      ],
    );
  }
}

class StatusSection extends StatefulWidget {
  final Function setData;

  const StatusSection({
    Key key,
    @required this.setData,
  }) : super(key: key);

  @override
  _StatusSectionState createState() => _StatusSectionState();
}

class _StatusSectionState extends State<StatusSection> {
  String _dropdownValue = 'متوسط';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'وضعیت'),
        DropdownButton(
            value: _dropdownValue,
            onChanged: (value) => _valueChanged(value),
            items: <String>['قوی', 'متوسط', 'ضعیف', 'بیمار']
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList())
      ],
    );
  }

  void _valueChanged(dynamic value) {
    setState(() {
      widget.setData('status', value);
      _dropdownValue = value;
    });
  }
}

class FrameStairsSection extends StatefulWidget {
  final Function setData;

  const FrameStairsSection({
    Key key,
    @required this.setData,
  }) : super(key: key);

  @override
  _FrameStairsSectionState createState() => _FrameStairsSectionState();
}

class _FrameStairsSectionState extends State<FrameStairsSection> {
  TextEditingController framesController;
  TextEditingController stairsController;
  String lastFramesData = '';
  String lastStairsData = '';

  @override
  void initState() {
    framesController = TextEditingController();
    stairsController = TextEditingController();
    framesController.addListener(() {
      if (framesController.text.isEmpty) return;
      if (validateField(framesController.text)) {
        widget.setData('frames', int.parse(framesController.text));
        setState(() {
          lastFramesData = framesController.text;
        });
      } else
        setState(() {
          framesController.text = lastFramesData;
        });
    });
    stairsController.addListener(() {
      if (stairsController.text.isEmpty) return;
      if (validateField(stairsController.text)) {
        widget.setData('stairs', int.parse(stairsController.text));
        setState(() {
          lastStairsData = stairsController.text;
        });
      } else {
        setState(() {
          stairsController.text = lastStairsData;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'قاب/طبق'),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          runSpacing: 10,
          children: [
            CustomTextField(
              widthInPercent: 0.4,
              hintText: 'تعداد قاب',
              controller: framesController,
              inputType: TextInputType.number,
            ),
            SizedBox(
              width: 10,
            ),
            CustomTextField(
              widthInPercent: 0.4,
              hintText: 'تعداد طبق',
              controller: stairsController,
              inputType: TextInputType.number,
            ),
          ],
        ),
      ],
    );
  }

  bool validateField(String value) {
    try {
      int.parse(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class QueenBackColorSection extends StatefulWidget {
  final Function setData;

  const QueenBackColorSection({Key key, @required this.setData})
      : super(key: key);

  @override
  _QueenBackColorSectionState createState() => _QueenBackColorSectionState();
}

class _QueenBackColorSectionState extends State<QueenBackColorSection> {
  int _dropdownValue = 0XFFFF0000;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'رنگ پشت ملکه'),
        DropdownButton(
          value: _dropdownValue,
          onChanged: (value) {
            setState(() {
              widget.setData('queenBackColor', value.toString());
              _dropdownValue = value;
            });
          },
          items:
              <int>[0XFFFF0000, 0XFFFFFFFF, 0XFF0000FF, 0XFFFFFF00, 0XFF00FF00]
                  .map(
                    (e) => DropdownMenuItem<int>(
                        value: e,
                        child: Row(
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(e)),
                            ),
                            Text(getColorNameFromCode(e))
                          ],
                        )),
                  )
                  .toList(),
        ),
      ],
    );
  }
}

String getColorNameFromCode(int colorCode) {
  switch (colorCode) {
    case (0XFFFF0000):
      return 'قرمز';
      break;
    case (0XFFFFFFFF):
      return 'سفید';
      break;
    case (0XFF0000FF):
      return 'آبی';
      break;
    case (0XFFFFFF00):
      return 'زرد';
      break;
    case (0XFF00FF00):
      return 'سبز';
      break;
    default:
      return 'خطا';
  }
}

class QueenEnterDateSection extends StatefulWidget {
  final Function setData;

  const QueenEnterDateSection({
    Key key,
    @required this.setData,
  }) : super(key: key);

  @override
  _QueenEnterDateSectionState createState() => _QueenEnterDateSectionState();
}

class _QueenEnterDateSectionState extends State<QueenEnterDateSection> {
  TextEditingController _dayController, _monthController, _yearController;
  Jalali _queenAddedDate = Jalali.now();
  String _lastDayValue, _lastMonthValue, _lastYearValue;

  @override
  void initState() {
    super.initState();
    _dayController = TextEditingController();
    _monthController = TextEditingController();
    _yearController = TextEditingController();
    _lastDayValue = '';
    _lastMonthValue = '';
    _lastYearValue = '';
    _dayController.addListener(() {
      if (_dayController.text.isEmpty) return;
      if (_validateDayField())
        setState(() {
          _lastDayValue = _dayController.text;
        });
      else
        setState(() {
          _dayController.text = _lastDayValue;
        });
    });
    _monthController.addListener(() {
      if (_monthController.text.isEmpty) return;
      if (_validateMonthField())
        setState(() {
          _lastMonthValue = _monthController.text;
        });
      else
        setState(() {
          _monthController.text = _lastMonthValue;
        });
    });
    _yearController.addListener(() {
      if (_yearController.text.isEmpty) return;
      if (_validateYearField())
        setState(() {
          _lastYearValue = _yearController.text;
        });
      else
        setState(() {
          _yearController.text = _lastYearValue;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'تاریخ ورود ملکه'),
        DateInput(
            yearController: _yearController,
            monthController: _monthController,
            dayController: _dayController),
      ],
    );
  }

  bool _validateDayField() {
    try {
      int day = int.parse(_dayController.text);
      if (day > 0 && day < 32) {
        setState(() {
          _queenAddedDate =
              Jalali(_queenAddedDate.year, _queenAddedDate.month, day);
          widget.setData('queenAddedDate', _queenAddedDate.toDateTime());
        });
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }

  bool _validateMonthField() {
    try {
      int month = int.parse(_monthController.text);
      if (month > 0 && month < 13) {
        setState(() {
          _queenAddedDate =
              Jalali(_queenAddedDate.year, month, _queenAddedDate.day);
          widget.setData('queenAddedDate', _queenAddedDate.toDateTime());
        });
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }

  bool _validateYearField() {
    try {
      int year = int.parse(_yearController.text);
      if (year > 0 && year < Jalali.now().year + 1) {
        setState(() {
          _queenAddedDate =
              Jalali(year, _queenAddedDate.month, _queenAddedDate.day);
          widget.setData('queenAddedDate', _queenAddedDate.toDateTime());
        });
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }
}

class DateInput extends StatelessWidget {
  const DateInput({
    Key key,
    @required TextEditingController yearController,
    @required TextEditingController monthController,
    @required TextEditingController dayController,
  })  : _yearController = yearController,
        _monthController = monthController,
        _dayController = dayController,
        super(key: key);

  final TextEditingController _yearController;
  final TextEditingController _monthController;
  final TextEditingController _dayController;

  @override
  Widget build(BuildContext context) {
    return Wrap(
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
    );
  }
}

class BreedSection extends StatefulWidget {
  final Function setData;

  const BreedSection({Key key, @required this.setData}) : super(key: key);

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
    widget.setData('breed', _controller.text);
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

class HiveNumberSection extends StatefulWidget {
  final AddHiveViewLogic model;

  const HiveNumberSection({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _HiveNumberSectionState createState() => _HiveNumberSectionState();
}

class _HiveNumberSectionState extends State<HiveNumberSection> {
  Future _generateNumberFuture;

  @override
  void initState() {
    _generateNumberFuture = widget.model.generateHiveNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'شماره کندو'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<int>(
              future: _generateNumberFuture,
              builder: (context, snapshot) {
                var theme = Theme.of(context);
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData)
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
  final Function setData;

  const TakeImageSection({
    Key key,
    @required this.setData,
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
        PrimaryButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TakePictureScreen(
                      camera: _injector.camera,
                      captureMode: CaptureMode.forHive,
                      hivePictureTakenCallback: imageCapturedCallback,
                    )));
          },
          child: Text('گرفتن عکس'),
        ),
      ],
    );
  }

  void imageCapturedCallback(String imagePath) {
    setState(() {
      this._picture = File(imagePath);
      widget.setData('picture', imagePath);
    });
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lever/core/components/global_view_components.dart';
import 'package:lever/core/dependency_management/injection/InjectorProvider.dart';
import 'package:lever/core/dependency_management/injection/injector.dart';
import 'package:lever/core/infrastructure/camera/take_picture_screen.dart';

class TakeVisitImagesSection extends StatefulWidget {
  final Function setData;

  const TakeVisitImagesSection({
    Key key,
    @required this.setData,
  }) : super(key: key);

  @override
  _TakeVisitImagesSectionState createState() => _TakeVisitImagesSectionState();
}

class _TakeVisitImagesSectionState extends State<TakeVisitImagesSection> {
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
                      captureMode: CaptureMode.forVisit,
                      visitPictureTakenCallback: imageCapturedCallback,
                    )));
          },
          child: Text('گرفتن عکس'),
        ),
      ],
    );
  }

  void imageCapturedCallback(List<String> imagePaths) {
    setState(() {
      this._picture = File(imagePaths[0]);
      widget.setData('pictures', imagePaths);
    });
  }
}

class EggingStatusSection extends StatefulWidget {
  final Function setData;

  const EggingStatusSection({
    Key key,
    @required this.setData,
  }) : super(key: key);

  @override
  _EggingStatusSectionState createState() => _EggingStatusSectionState();
}

class _EggingStatusSectionState extends State<EggingStatusSection> {
  String _dropdownValue = 'متوسط';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'تخم گذاری'),
        DropdownButton(
            value: _dropdownValue,
            onChanged: (value) => _valueChanged(value),
            items: <String>['عالی', 'خوب', 'متوسط', 'کم', 'خیلی کم']
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList())
      ],
    );
  }

  void _valueChanged(dynamic value) {
    setState(() {
      widget.setData('egging', value);
      _dropdownValue = value;
    });
  }
}

class QueenSeenStatus extends StatefulWidget {
  final Function setData;

  const QueenSeenStatus({
    Key key,
    @required this.setData,
  }) : super(key: key);

  @override
  _QueenSeenStatusState createState() => _QueenSeenStatusState();
}

class _QueenSeenStatusState extends State<QueenSeenStatus> {
  String _dropdownValue = 'ديده نشد';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'ديدن ملكه'),
        DropdownButton(
            value: _dropdownValue,
            onChanged: (value) => _valueChanged(value),
            items: <String>[
              'ديده نشد',
              'ديده شد',
            ]
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList())
      ],
    );
  }

  void _valueChanged(dynamic value) {
    setState(() {
      widget.setData('queenSeen', value == 'ديده شد' ? true : false);
      _dropdownValue = value;
    });
  }
}

class QueenCells extends StatefulWidget {
  final Function setData;

  const QueenCells({
    Key key,
    @required this.setData,
  }) : super(key: key);

  @override
  _QueenCellsState createState() => _QueenCellsState();
}

class _QueenCellsState extends State<QueenCells> {
  TextEditingController queenCellController;
  String lastValidValue = '';

  @override
  void initState() {
    queenCellController = TextEditingController();
    queenCellController.text = '0';
    queenCellController.addListener(() {
      if (queenCellController.text.isEmpty) return;
      if (validateField(queenCellController.text)) {
        widget.setData('queenCells', int.parse(queenCellController.text));

        setState(() {
          lastValidValue = queenCellController.text;
        });
      } else {
        setState(() {
          queenCellController.text = lastValidValue;
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
        InputTitle(text: 'تعداد سلول ملکه'),
        CustomTextField(
          widthInPercent: 0.4,
          hintText: 'تعداد',
          controller: queenCellController,
          inputType: TextInputType.number,
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

class HoneyStatus extends StatefulWidget {
  final Function setData;

  const HoneyStatus({
    Key key,
    @required this.setData,
  }) : super(key: key);

  @override
  _HoneyStatusState createState() => _HoneyStatusState();
}

class _HoneyStatusState extends State<HoneyStatus> {
  String _dropdownValue = 'متوسط';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'تولید عسل'),
        DropdownButton(
            value: _dropdownValue,
            onChanged: (value) => _valueChanged(value),
            items: <String>['عالی', 'خوب', 'متوسط', 'کم', 'خیلی کم']
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList())
      ],
    );
  }

  void _valueChanged(dynamic value) {
    setState(() {
      widget.setData('honeyMaking', value);
      _dropdownValue = value;
    });
  }
}

class BehaviorStatus extends StatefulWidget {
  final Function setData;

  const BehaviorStatus({
    Key key,
    @required this.setData,
  }) : super(key: key);

  @override
  _BehaviorStatusState createState() => _BehaviorStatusState();
}

class _BehaviorStatusState extends State<BehaviorStatus> {
  String _dropdownValue = 'آرام';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: 'رفتار'),
        DropdownButton(
            value: _dropdownValue,
            onChanged: (value) => _valueChanged(value),
            items: <String>[
              'آرام',
              'عصبانی',
            ]
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList())
      ],
    );
  }

  void _valueChanged(dynamic value) {
    setState(() {
      widget.setData('behavior', value);
      _dropdownValue = value;
    });
  }
}

class DropdownStatusInput extends StatefulWidget {
  final Function setData;
  final List<String> items;
  final String dataFieldName;
  final String title;

  const DropdownStatusInput({
    Key key,
    @required this.setData,
    @required this.items,
    @required this.dataFieldName,
    @required this.title,
  }) : super(key: key);

  @override
  _DropdownStatusInputState createState() => _DropdownStatusInputState();
}

class _DropdownStatusInputState extends State<DropdownStatusInput> {
  String _dropdownValue;

  @override
  void initState() {
    _dropdownValue = widget.items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: widget.title),
        DropdownButton(
            value: _dropdownValue,
            onChanged: (value) => _valueChanged(value),
            items: widget.items
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList())
      ],
    );
  }

  void _valueChanged(dynamic value) {
    setState(() {
      widget.setData(widget.dataFieldName, value);
      _dropdownValue = value;
    });
  }
}

class NumericInput extends StatefulWidget {
  final Function setData;
  final String title;
  final String hint;
  final String dataFieldName;

  const NumericInput({
    Key key,
    @required this.setData,
    @required this.title,
    @required this.hint,
    @required this.dataFieldName,
  }) : super(key: key);

  @override
  _NumericInputState createState() => _NumericInputState();
}

class _NumericInputState extends State<NumericInput> {
  TextEditingController inputController;
  String lastInput = '';

  @override
  void initState() {
    inputController = TextEditingController();
    inputController.addListener(() {
      if (inputController.text.isEmpty) return;
      if (validateField(inputController.text)) {
        widget.setData(widget.dataFieldName, int.parse(inputController.text));
        setState(() {
          lastInput = inputController.text;
        });
      } else
        setState(() {
          inputController.text = lastInput;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InputTitle(text: widget.title),
        CustomTextField(
          widthInPercent: 0.4,
          hintText: widget.hint,
          controller: inputController,
          inputType: TextInputType.number,
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

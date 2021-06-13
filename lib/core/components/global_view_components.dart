import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VoiceCommandButton extends StatelessWidget {
  const VoiceCommandButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class BottomButtonSet extends StatelessWidget {
  final Function onBackPressed;
  final Widget rightActionChild;
  final Function rightAction;
  const BottomButtonSet({
    Key key,
    @required this.onBackPressed,
    @required this.rightActionChild,
    @required this.rightAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: hide when the keyboard is open
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Transform.translate(
            offset: Offset(0, 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.only(bottom: 30),
                child: MaterialButton(
                  onPressed: () => onBackPressed,
                  color: Colors.grey,
                  elevation: 20,
                  shape: StadiumBorder(),
                  child: Center(child: Icon(Icons.arrow_back)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: VoiceCommandButton(),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 60,
              width: 60,
              margin: EdgeInsets.only(bottom: 30),
              child: MaterialButton(
                  onPressed: rightAction,
                  color: Colors.grey,
                  elevation: 20,
                  shape: StadiumBorder(),
                  child: rightActionChild),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final double widthInPercent;
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  const CustomTextField({
    Key key,
    @required this.widthInPercent,
    @required this.hintText,
    @required this.controller,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textDirection = TextDirection.rtl;
    var textAlign = TextAlign.right;
    if (inputType == TextInputType.number) {
      textDirection = TextDirection.ltr;
      textAlign = TextAlign.center;
    }
    return Container(
      width: MediaQuery.of(context).size.width * widthInPercent,
      child: TextField(
        textDirection: textDirection,
        textAlign: textAlign,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(23)),
          hintText: hintText,
          hintTextDirection: textDirection,
        ),
      ),
    );
  }
}

class InputTitle extends StatelessWidget {
  final String text;
  const InputTitle({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        child: Text(text, style: Theme.of(context).textTheme.headline6));
  }
}

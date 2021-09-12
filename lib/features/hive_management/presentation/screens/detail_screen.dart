import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lever/core/components/global_view_components.dart';
import 'package:lever/core/dependency_management/injection/InjectorProvider.dart';
import 'package:lever/core/dependency_management/injection/injector.dart';
import 'package:lever/core/infrastructure/camera/take_picture_screen.dart';
import 'package:lever/core/infrastructure/qr_provider/save_qr.dart';
import 'package:lever/features/app/presentation/logic/app_view_logic.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/presentation/components/hive_view_components.dart';
import 'package:lever/features/hive_management/presentation/logic/hive_details_view_logic.dart';
import 'package:lever/features/hive_management/presentation/screens/hive_visit_history_screen.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/extensions.dart';

class HiveDetailScreen extends StatefulWidget {
  const HiveDetailScreen({Key key}) : super(key: key);

  @override
  _HiveDetailScreenState createState() => _HiveDetailScreenState();
}

class _HiveDetailScreenState extends State<HiveDetailScreen> {
  Hive hive;

  @override
  Widget build(BuildContext context) {
    Injector injector = InjectorProvider.of(context).injector;
    return ChangeNotifierProvider<HiveDetailLogic>(
        create: (context) => HiveDetailLogic(
              injector.getEditHiveCmnd,
              injector.getFetchHiveCmnd,
              injector.getDeleteHiveCmnd,
            ),
        builder: (context, _) {
          return Consumer<HiveDetailLogic>(builder: (context, model, _) {
            return FutureBuilder<Hive>(
                future: model.fetchHive(
                    Provider.of<AppLogic>(context, listen: false)
                        .selectedHiveId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) hive = snapshot.data;
                  return WillPopScope(
                    onWillPop: () async {
                      await Navigator.of(context).pushReplacementNamed('/');
                      return true;
                    },
                    child: Scaffold(
                      body: Stack(
                        children: [
                          buildTopPanel(context, snapshot, model),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: buildBottomPanel(context, snapshot),
                          ),
                          BottomButtonSet(
                            onBackPressed: () =>
                                Navigator.of(context).pushReplacementNamed('/'),
                            rightActionChild: Icon(Icons.remove_red_eye),
                            rightAction: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('visit');
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
          });
        });
  }

  Container buildBottomPanel(
      BuildContext context, AsyncSnapshot<Hive> snapshot) {
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
        child: snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: Container(
                    height: 60, width: 50, child: CircularProgressIndicator()))
            : (!snapshot.hasData)
                ? Center(child: Text('خطا در بارگذاری'))
                : Padding(
                    padding: const EdgeInsets.only(bottom: 120),
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      runSpacing: 20,
                      runAlignment: WrapAlignment.spaceBetween,
                      spacing: 20,
                      children: [
                        buildQueenBackColorSection(context),
                        buildBreedSection(context),
                        buildStatusSection(context),
                        buildAnnualHoneySection(context),
                        buildQueenEnterDateSection(context),
                        buildStairFramesSection(context),
                        buildDetailsSection(context),
                      ],
                    ),
                  ),
      ),
    );
  }

  HiveDetailInfoBox buildDetailsSection(BuildContext context) {
    return HiveDetailInfoBox(
      title: 'توضیحات',
      info: hive.description,
      onPressed: () => showDialog(
        context: context,
        builder: (_) {
          var descriptions;
          return EditDialog(
            content: NotesSection(
              setData: (_, value) {
                descriptions = value;
              },
            ),
            editAction: () {
              Provider.of<HiveDetailLogic>(context, listen: false).updateHive(
                  _generateNewHive(hive, 'description', null, descriptions));
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }

  HiveDetailInfoBox buildStairFramesSection(BuildContext context) {
    return HiveDetailInfoBox(
      title: 'قاب/طبق',
      info: 'قاب: ' +
          (hive.populationInfo != null && hive.populationInfo.frames != null
              ? hive.populationInfo.frames.toString()
              : 'وارد نشده') +
          ' / ' +
          'طبق: ' +
          (hive.populationInfo != null && hive.populationInfo.stairs != null
              ? hive.populationInfo.stairs.toString()
              : 'وارد نشده'),
      onPressed: () => showDialog(
        context: context,
        builder: (_) {
          var frames;
          var stairs;

          return EditDialog(
            content: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: FrameStairsSection(
                setData: (key, value) {
                  if (key == 'frames') frames = value;
                  if (key == 'stairs') stairs = value;
                },
              ),
            ),
            editAction: () {
              if (frames != null && stairs != null) {
                var newHive = _generateNewHive(
                  hive,
                  'populationInfo',
                  'stairs',
                  stairs,
                );
                newHive = _generateNewHive(
                  newHive,
                  'populationInfo',
                  'frames',
                  frames,
                );
                Provider.of<HiveDetailLogic>(context, listen: false)
                    .updateHive(newHive);
              } else if (frames != null) {
                var newHive = _generateNewHive(
                  hive,
                  'populationInfo',
                  'frames',
                  frames,
                );
                Provider.of<HiveDetailLogic>(context, listen: false)
                    .updateHive(newHive);
              } else if (stairs != null) {
                var newHive = _generateNewHive(
                  hive,
                  'populationInfo',
                  'stairs',
                  stairs,
                );

                Provider.of<HiveDetailLogic>(context, listen: false)
                    .updateHive(newHive);
              }
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }

  HiveDetailInfoBox buildQueenEnterDateSection(BuildContext context) {
    return HiveDetailInfoBox(
      title: 'تاریخ ورود ملکه',
      info: _getQueenEnterDate(hive),
      onPressed: () => showDialog(
          context: context,
          builder: (_context) {
            var queenEnterDate;
            return EditDialog(
              content: Container(
                width: MediaQuery.of(_context).size.width * 0.9,
                child: QueenEnterDateSection(
                  setData: (_, value) {
                    queenEnterDate = value;
                  },
                ),
              ),
              editAction: () {
                Provider.of<HiveDetailLogic>(context, listen: false).updateHive(
                  _generateNewHive(hive, 'queenInfo', 'enterDate',
                      queenEnterDate.millisecondsSinceEpoch),
                );
                Navigator.of(_context).pop();
              },
            );
          }),
    );
  }

  HiveDetailInfoBox buildAnnualHoneySection(BuildContext context) {
    return HiveDetailInfoBox(
        title: 'عسل سالیانه',
        info: hive.annualHoney != null && hive.annualHoney != null
            ? hive.annualHoney.toString()
            : 'وارد نشده',
        onPressed: () => showDialog(
              context: context,
              builder: (_) {
                var annualHoney;

                return EditDialog(
                  content: AnnualHoneySection(
                    setData: (_, value) {
                      annualHoney = value;
                    },
                  ),
                  editAction: () {
                    Provider.of<HiveDetailLogic>(context, listen: false)
                        .updateHive(
                      _generateNewHive(hive, 'annualHoney', null, annualHoney),
                    );
                    Navigator.of(context).pop();
                  },
                );
              },
            ));
  }

  HiveDetailInfoBox buildStatusSection(BuildContext context) {
    return HiveDetailInfoBox(
      title: 'وضعیت',
      info: hive.populationInfo != null && hive.populationInfo.status.isNotEmpty
          ? hive.populationInfo.status
          : 'وارد نشده',
      onPressed: () => showDialog(
        context: context,
        builder: (_) {
          var status;
          return EditDialog(
            content: StatusSection(
              setData: (_, value) {
                status = value;
              },
            ),
            editAction: () {
              Provider.of<HiveDetailLogic>(context, listen: false).updateHive(
                  _generateNewHive(hive, 'populationInfo', 'status', status));
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }

  HiveDetailInfoBox buildBreedSection(BuildContext context) {
    return HiveDetailInfoBox(
      title: 'نژاد',
      info:
          hive.queenInfo.breed.isNotEmpty ? hive.queenInfo.breed : 'وارد نشده',
      onPressed: () => showDialog(
        context: context,
        builder: (_) {
          var breed;
          return EditDialog(content: BreedSection(
            setData: (key, value) {
              breed = value;
            },
          ), editAction: () {
            Provider.of<HiveDetailLogic>(context, listen: false).updateHive(
                _generateNewHive(hive, 'queenInfo', 'breed', breed));
            Navigator.of(context).pop();
          });
        },
      ),
    );
  }

  InkWell buildQueenBackColorSection(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            var queenColor;
            return EditDialog(content: QueenBackColorSection(
              setData: (key, value) {
                queenColor = value;
              },
            ), editAction: () {
              Provider.of<HiveDetailLogic>(context, listen: false).updateHive(
                  _generateNewHive(hive, 'queenInfo', 'backColor', queenColor));
              Navigator.of(context).pop();
            });
          },
        );
      },
      child: Column(
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
              color:
                  hive.queenInfo != null && hive.queenInfo.backColor.isNotEmpty
                      ? Color(int.parse(hive.queenInfo.backColor))
                      : Colors.transparent,
            ),
            child: Text(
                hive.queenInfo != null && hive.queenInfo.backColor.isNotEmpty
                    ? getColorNameFromCode(int.parse(hive.queenInfo.backColor))
                    : 'وارد نشده'),
          ),
        ],
      ),
    );
  }

  Container buildTopPanel(BuildContext context, AsyncSnapshot<Hive> snapshot,
      HiveDetailLogic model) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: snapshot.hasData
            ? hive.picture.isEmpty
                ? null
                : DecorationImage(
                    image: FileImage(File(hive.picture)),
                    fit: BoxFit.cover,
                  )
            : null,
      ),
      child: snapshot.connectionState == ConnectionState.waiting
          ? Center(
              child: Container(
                  height: 60, width: 50, child: CircularProgressIndicator()))
          : (!snapshot.hasData)
              ? Center(child: Text('خطا در بارگذاری'))
              : Stack(
                  children: [
                    buildShowImageInkwell(context),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: buildDeleteButton(context, model),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: buildHiveNumberSection(context),
                        ),
                        buildShowHistorySection(context),
                      ],
                    ),
                  ],
                ),
    );
  }

  MaterialButton buildShowHistorySection(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).colorScheme.background,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_context) => HiveVisitHistoryScreen(),
          ),
        );
      },
      shape: StadiumBorder(),
      child: Text('نمایش تاریخچه'),
    );
  }

  Row buildHiveNumberSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 50,
          child: MaterialButton(
            color: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: () async {
              await saveQrCode(hive.id, hive.number.toString());
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        scrollable: true,
                        title: Text(
                          'ذخیره شد',
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                        content: Center(
                          child: Column(
                            children: [
                              Text(
                                'کد QR کندو در گالری ذخیره شد. لطفا بعد از پرینت کردن آن را روی کندو بچسبانید تا برای دسترسی راحت تر اسکن کنید',
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                'لطفا شماره کندو(' +
                                    hive.number.toString() +
                                    ') را روی کندو بنویسید تا فراموش نشود',
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              )
                            ],
                          ),
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed('/');
                            },
                            child: Text('تایید'),
                          )
                        ],
                      ),
                  barrierDismissible: false);
            },
            shape: StadiumBorder(),
            child: Text('QR'),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.7),
                )
              ],
              borderRadius: BorderRadius.circular(500)),
          child: InputTitle(
            text: hive.number.toString(),
          ),
        )
      ],
    );
  }

  Widget buildDeleteButton(BuildContext context, HiveDetailLogic model) {
    return Container(
      width: 60,
      child: MaterialButton(
        color: Theme.of(context).colorScheme.error,
        textColor: Theme.of(context).colorScheme.onError,
        onPressed: () {
          showDialog(
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
                        model.deleteHive(hive.id);
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      child: Text('حذف'),
                    ),
                  ],
                );
              });
        },
        shape: StadiumBorder(),
        child: Center(child: Icon(Icons.delete_rounded)),
      ),
    );
  }

  InkWell buildShowImageInkwell(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: hive.picture.isEmpty
                          ? null
                          : DecorationImage(
                              image: FileImage(File(hive.picture)),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MaterialButton(
                              onPressed: () => Navigator.of(context).pop(),
                              color: Theme.of(context).colorScheme.surface,
                              elevation: 10,
                              shape: StadiumBorder(),
                              child: Center(
                                child: Icon(Icons.close),
                              ),
                            ),
                            CancelButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_context) => TakePictureScreen(
                                        camera: InjectorProvider.of(context)
                                            .injector
                                            .camera,
                                        captureMode: CaptureMode.forHive,
                                        hivePictureTakenCallback:
                                            (String imagePath) {
                                          Provider.of<HiveDetailLogic>(context,
                                                  listen: false)
                                              .updateHive(
                                            _generateNewHive(hive, 'picture',
                                                null, imagePath),
                                          );
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.edit),
                                    Text('تعویض'),
                                  ],
                                ))
                          ],
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

  String _getQueenEnterDate(Hive hive) {
    try {
      return hive.queenInfo != null && hive.queenInfo.enterDate != null
          ? Jalali.fromDateTime(hive.queenInfo.enterDate).year.toString() +
              '/' +
              Jalali.fromDateTime(hive.queenInfo.enterDate).month.toString() +
              '/' +
              Jalali.fromDateTime(hive.queenInfo.enterDate).day.toString()
          : 'وارد نشده';
    } catch (e) {
      return 'وارد نشده';
    }
  }

  Hive _generateNewHive(
      Hive hive, String newKey, String newSecondKey, dynamic newValue) {
    var newMap = hive.toMap();
    if (newSecondKey == null)
      newMap[newKey] = newValue;
    else
      newMap[newKey][newSecondKey] = newValue;
    return Hive.fromMap(newMap);
  }
}

class HiveDetailInfoBox extends StatelessWidget {
  const HiveDetailInfoBox({
    Key key,
    @required this.title,
    @required this.info,
    @required this.onPressed,
  }) : super(key: key);

  final String title;
  final String info;
  final Function onPressed;

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
          child: InkWell(
            onTap: () => onPressed.call(),
            child: Text(
              info == null || info.isEmpty ? 'وارد نشده' : info,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      ],
    );
  }
}

class EditDialog extends StatelessWidget {
  const EditDialog({Key key, @required this.content, @required this.editAction})
      : super(key: key);
  final Widget content;
  final Function editAction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('ویرایش'),
      content: Container(height: 350, child: content),
      scrollable: true,
      actions: [
        CancelButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('لغو'),
        ),
        PrimaryButton(
          onPressed: editAction,
          child: Text('ویرایش'),
        ),
      ],
    );
  }
}

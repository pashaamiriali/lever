import 'package:flutter/material.dart';
import 'package:lever/core/components/global_view_components.dart';
import 'package:lever/core/dependency_management/injection/InjectorProvider.dart';
import 'package:lever/features/hive_management/presentation/components/hive_view_components.dart';
import 'package:lever/features/hive_management/presentation/logic/hive_add_view_logic.dart';
import 'package:provider/provider.dart';

class AddHiveView extends StatelessWidget {
  const AddHiveView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _injector = InjectorProvider.of(context).injector;

    return WillPopScope(
      onWillPop: () => Navigator.of(context).pushReplacementNamed('/'),
      child: Scaffold(
        body: ChangeNotifierProvider<AddHiveViewLogic>(
          create: (context) => AddHiveViewLogic(
              _injector.getAddHiveCmnd, _injector.getGenerateHiveNumberCmnd),
          child: Consumer<AddHiveViewLogic>(
            builder: (__, model, _) => Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TakeImageSection(model: model),
                          SizedBox(
                            height: 20,
                          ),
                          HiveNumberSection(model: model),
                          SizedBox(
                            height: 20,
                          ),
                          BreedSection(model: model),
                          SizedBox(
                            height: 20,
                          ),
                          QueenEnterDateSection(model: model),
                          SizedBox(
                            height: 20,
                          ),
                          QueenBackColorSection(model: model),
                          SizedBox(
                            height: 20,
                          ),
                          FrameStairsSection(model: model),
                          SizedBox(
                            height: 20,
                          ),
                          StatusSection(model: model),
                          SizedBox(
                            height: 20,
                          ),
                          AnnualHoneySection(model: model),
                          SizedBox(
                            height: 20,
                          ),
                          NotesSection(model: model),
                          SizedBox(
                            height: 250,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                BottomButtonSet(
                  onBackPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/'),
                  rightActionChild: Center(child: Icon(Icons.check)),
                  rightAction: () {
                    if (model.invalidFields.isNotEmpty)
                      showDialog(
                          context: context,
                          builder: (context) {
                            List<String> fieldNames =
                                model.invalidFields.map((e) {
                              if (e == 'day') return 'روز';
                              if (e == 'month') return 'ماه';
                              if (e == 'year') return 'سال';
                              return '(یکی از روز ها)';
                            }).toList();
                            return AlertDialog(
                              content: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: double.parse(
                                    (model.invalidFields.length * 30)
                                        .toString()),
                                child: ListView.builder(
                                    itemCount: fieldNames.length,
                                    itemBuilder: (context, index) {
                                      return Text('لطفا فیلد ' +
                                          fieldNames[index] +
                                          " را درست وارد نمایید ");
                                    }),
                              ),
                              actions: [
                                MaterialButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  child: Text('تایید'),
                                  shape: StadiumBorder(),
                                )
                              ],
                            );
                          });
                    model.saveHivePressed();
                    if (model.processState == ProcessState.loading)
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Container(
                                  width: 50,
                                  height: 50,
                                  margin: EdgeInsets.all(20),
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          barrierDismissible: false);
                    if (model.processState == ProcessState.loading)
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Text('انجام شد'),
                                actions: [
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed('/');
                                    },
                                    child: Text('تایید'),
                                  )
                                ],
                              ),
                          barrierDismissible: false);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

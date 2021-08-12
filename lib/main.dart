import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'main_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ストップウォッチ',
      home: ChangeNotifierProvider<MainModel>(
        create: (context) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('ストップウォッチ'),
          ),
          body: Consumer<MainModel>(
            builder: (context, model, child) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        if (!model.isEditTimeEnabled) return;
                        Picker(
                          adapter: DateTimePickerAdapter(
                            type: PickerDateTimeType.kHMS,
                            value: model.timerTime,
                            customColumnType: [3, 4, 5],
                          ),
                          title: Text("Select Time"),
                          onConfirm: (Picker, List values) {
                            model.changeTimerTime(DateTime.utc(
                                0, 0, 0, values[0], values[1], values[2]));
                          },
                        ).showModal(context);
                      },
                      child: Text(DateFormat.Hms().format(model.timerTime),
                          style: TextStyle(
                            fontSize: 80,
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                              onPressed: !model.isStartEnabled
                                  ? null
                                  : () {
                                      model.startTimer();
                                    },
                              icon: Icon(Icons.play_arrow),
                              label: Text('START')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                              onPressed: !model.isStopEnabled
                                  ? null
                                  : () {
                                      model.stopTimer();
                                    },
                              icon: Icon(Icons.stop),
                              label: Text('STOP')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                              onPressed: !model.isResetEnabled
                                  ? null
                                  : () {
                                      model.resetTimerTime();
                                    },
                              icon: Icon(Icons.clear),
                              label: Text('RESET')),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

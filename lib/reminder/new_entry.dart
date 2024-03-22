import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:test_cam_1/notification/notification1.dart';

import 'package:test_cam_1/reminder/convert_time.dart';
import 'package:test_cam_1/reminder/errors.dart';
import 'package:test_cam_1/reminder/global_bloc.dart';
import 'package:test_cam_1/reminder/medicine.dart';
import 'package:test_cam_1/reminder/new_entry_bloc.dart';
import 'package:test_cam_1/reminder/success_screen.dart';
import 'package:test_cam_1/reminder/notification_helper.dart';
import 'package:test_cam_1/test.dart';

// ignore: camel_case_types
class new_entry extends StatefulWidget {
  const new_entry({
    super.key,
  });
  @override
  State<new_entry> createState() => _new_entryState();
}

class _new_entryState extends State<new_entry> {
  late TextEditingController namecontroller;
  late TextEditingController dosagecontroller;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late NewEntryBloc _newEntryBloc;
  late GlobalKey<ScaffoldState> _scaffoldkey;

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    dosagecontroller.dispose();
    _newEntryBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    namecontroller = TextEditingController();
    dosagecontroller = TextEditingController();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _scaffoldkey = GlobalKey<ScaffoldState>();
    _newEntryBloc = NewEntryBloc();
    initializeErrorListen();
    // initializeNotifications();
  }

  @override
  Widget build(BuildContext context) {
    //final GlobalBloc globalBloc = Provider.of<GlobalBloc>();
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);

    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text(
            'Add New',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Provider<NewEntryBloc>.value(
        value: _newEntryBloc,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const paneltitle(
                title: 'Medicine Name',
                isrequired: true,
              ),
              TextFormField(
                controller: namecontroller,
                maxLength: 20,
              ),

              const paneltitle(title: 'dosage in mg', isrequired: false),
              TextFormField(
                controller: dosagecontroller,
                keyboardType: TextInputType.number,
                maxLength: 5,
              ),
              const paneltitle(title: 'Medicine Type', isrequired: false),

              StreamBuilder<MedicineType>(
                  stream: _newEntryBloc.selectedMedicineType,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MedicineTypeColumn(
                            name: 'pill',
                            icon: 'lib/counter/pills1.png',
                            selected: snapshot.data == MedicineType.pill
                                ? true
                                : false,
                            medicineType: MedicineType.pill),
                        MedicineTypeColumn(
                            name: 'injection',
                            icon: 'lib/counter/inge.png',
                            selected: snapshot.data == MedicineType.injection
                                ? true
                                : false,
                            medicineType: MedicineType.injection),
                        MedicineTypeColumn(
                            name: 'bottle',
                            icon: 'lib/counter/bottle1.png',
                            selected: snapshot.data == MedicineType.bottle
                                ? true
                                : false,
                            medicineType: MedicineType.bottle),
                      ],
                    );
                  }),
              // SizedBox(height: 10,),
              const paneltitle(title: 'interval section', isrequired: true),

              const interval_section(),

              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: paneltitle(title: 'starting time', isrequired: true),
              ),
              const select_time(),
              Padding(
                padding: const EdgeInsets.only(right: 50, left: 50, bottom: 15),
                child: SizedBox(
                  height: 60,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const StadiumBorder()),
                    onPressed: () {
                      String? medicineName;
                      int? dosage;
                      //medicineName
                      if (namecontroller.text == "") {
                        _newEntryBloc.submitError(EntryError.nameNull);
                        return;
                      }
                      if (namecontroller.text != "") {
                        medicineName = namecontroller.text;
                      }
                      //dosage
                      if (dosagecontroller.text == "") {
                        dosage = 0;
                      }
                      if (dosagecontroller.text != "") {
                        dosage = int.parse(dosagecontroller.text);
                      }
                      for (var medicine in globalBloc.medicineList$!.value) {
                        if (medicineName == medicine.medicineName) {
                          _newEntryBloc.submitError(EntryError.nameDuplicate);
                          return;
                        }
                      }
                      if (_newEntryBloc.selectedIntervals!.value == 0) {
                        _newEntryBloc.submitError(EntryError.interval);
                        return;
                      }
                      if (_newEntryBloc.selectedTimeOfDays$!.value == 'None') {
                        _newEntryBloc.submitError(EntryError.startTime);
                        return;
                      }
                      if (_newEntryBloc.selectedTimeOfDays$!.value == 0) {
                        _newEntryBloc.submitError(EntryError.startTime);
                        return;
                      }
                      // **************************
                      if (_clicked == false) {
                        _newEntryBloc.submitError(EntryError.startTime);
                        return;
                      }

                      String medicineType = _newEntryBloc
                          .selectedMedicineType!.value
                          .toString()
                          .substring(13);

                      int interval = _newEntryBloc.selectedIntervals!.value;
                      String startTime =
                          _newEntryBloc.selectedTimeOfDays$!.value;

                      List<int> intIDs = makeIDs(
                        24 / _newEntryBloc.selectedIntervals!.value,
                      );
                      List<String> notificationIDs =
                          intIDs.map((i) => i.toString()).toList();
                      // notificationIDs============================================

                      Medicine newEntryMedicine = Medicine(
                        notificationIDs: notificationIDs,
                        medicineName: medicineName,
                        dosage: dosage,
                        medicineType: medicineType,
                        interval: interval,
                        startTime: startTime,
                      );

                      //update medcine list via global bloc
                      globalBloc.updateMedicineList(newEntryMedicine);
                      // scheduleNotification(newEntryMedicine);

                      // go to success screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SuccessScreen()));

                      _createMedicineAlarm(newEntryMedicine);

                    },
                    child: const Center(
                      child: Text(
                        'confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void initializeErrorListen() {
    _newEntryBloc.errorState$!.listen((EntryError error) {
      switch (error) {
        case EntryError.nameNull:
          displayError("please enter the medicine name");
          break;

        case EntryError.nameDuplicate:
          displayError("Medicine name already exisits");
          break;

        case EntryError.dosage:
          displayError("please enter the dosage required");
          break;

        case EntryError.interval:
          displayError("please select the reminder interval");
          break;

        case EntryError.startTime:
          displayError("please select the reminder starting time");
          break;

        default:
      }
    });
  }

  void displayError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(error),
      duration: const Duration(milliseconds: 2000),
    ));
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];

    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }

    return ids;
  }

  void _createMedicineAlarm(Medicine medicine) {
    // int hour=int.parse(startTimem);
    String dateTime = DateTime.now().toString();
    List dateTime2 = dateTime.split(" ");
    List dateTime3 = dateTime2[0].split("-");

    print("8********************************");
    print(dateTime);
    DateTime initialtime = DateTime(
        int.parse(dateTime3[0]),
        int.parse(dateTime3[1]),
        int.parse(dateTime3[2]),
        int.parse(medicine.startTime!.substring(0, 2)),
        int.parse(medicine.startTime!.substring(2)));
    print(initialtime);
    double lenghtt = 24 / medicine.interval!;
    int increment = 0;
    for (int i = 0; i < lenghtt; i++) {
      NotificationServicesHelper.instance.dailyRoutine(
          id: int.parse(medicine.notificationIDs![i]),

          title: "Time for ${medicine.medicineName} dosage",
          body: "yor dosage ${medicine.dosage} mg" as String,
          vibrate: true,
          scheduledNotificationDateTime:
              initialtime.add(Duration(hours: increment)));

      increment += medicine.interval!;
    }
  }
}

bool _clicked = false;

class select_time extends StatefulWidget {
   
  const select_time({
    super.key,
  });

  @override
  State<select_time> createState() => _select_timeState();
}
class _select_timeState extends State<select_time> {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 00);

  //  bool _clicked = false;

  Future<TimeOfDay?> _sselectTime() async {
    final NewEntryBloc newEntryBloc =
        Provider.of<NewEntryBloc>(context, listen: false);

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
      useRootNavigator: false,
    );

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;

        newEntryBloc.updateTime(convertTime(_time.hour.toString()) +
            convertTime(_time.minute.toString()));
      });
    }
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        left: 20,
        bottom: 15,
      ),
      child: SizedBox(
        height: 60,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            _sselectTime();
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? 'select time'
                  : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

//interval
class interval_section extends StatefulWidget {
  const interval_section({super.key});

  @override
  State<interval_section> createState() => _interval_sectionState();
}

class _interval_sectionState extends State<interval_section> {
  final _intervals = [1, 6, 8, 12, 24];
  var selected = 0;
  @override
  Widget build(BuildContext context) {
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Remind me every'),
          DropdownButton(
            hint: selected == 0 ? const Text('select interval') : null,
            value: selected == 0 ? null : selected,
            items: _intervals.map(
              (int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              },
            ).toList(),
            onChanged: (newval) {
              setState(() {
                selected = newval!;
                newEntryBloc.updateInterval(newval);
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(selected == 1 ? 'hour' : 'hours'),
          )
        ],
      ),
    );
  }
}

//medicine tybe
class MedicineTypeColumn extends StatelessWidget {
//static medicine_type none;

  const MedicineTypeColumn(
      {super.key,
      required this.name,
      required this.icon,
      required this.selected,
      required this.medicineType});

  final String name;
  final String icon;
  final bool selected;
  final MedicineType medicineType;
  @override
  Widget build(BuildContext context) {
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        newEntryBloc.updateSelectedMedicine(medicineType);
      },
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                // color: Colors.white30,
                borderRadius: BorderRadius.circular(30),
                color: selected
                    ? const Color.fromARGB(255, 192, 209, 223)
                    : Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.asset(icon),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            // height: 30,
            // width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: selected
                  ? const Color.fromARGB(255, 192, 209, 223)
                  : Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(name)),
            ),
          )
        ],
      ),
    );
  }
}

enum MedicineType { bottle, pill, injection, none }

class paneltitle extends StatelessWidget {
  const paneltitle({super.key, required this.title, required this.isrequired});
  final String title;
  final bool isrequired;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text.rich(TextSpan(children: <TextSpan>[
        TextSpan(
          text: title,
        ),
        TextSpan(
          text: isrequired ? '*' : '',
        )
      ])),
    );
  }
}

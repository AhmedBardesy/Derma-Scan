import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_cam_1/notification/notification1.dart';
import 'package:test_cam_1/reminder/global_bloc.dart';
import 'package:test_cam_1/reminder/medicine.dart';
import 'package:test_cam_1/reminder/new_entry.dart';
import 'package:intl/intl.dart';
import 'package:test_cam_1/reminder/new_entry_bloc.dart';
import 'package:test_cam_1/reminder/notification_helper.dart';
import 'package:test_cam_1/reminder/sha.dart';

class MedicineDetails extends StatefulWidget {
  const MedicineDetails(this.medicine, {super.key});
  final Medicine medicine;
  @override
  State<MedicineDetails> createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  late NewEntryBloc _newEntryBloc;
  void dispose() {
    super.dispose();

    _newEntryBloc.dispose();
  }

  void initState() {
    super.initState();

    _newEntryBloc = NewEntryBloc();
  }

  @override
  Widget build(BuildContext context) {
    //Medicine medicine;
//List<Medicine> medicines = await getMedicinesFromPreferences();

    final GlobalBloc _globalbloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Details',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Column(
        children: [
          MainSection(
            medicine: widget.medicine,
          ),

          ExtendSection(
            medicine: widget.medicine,
          ),

          /// Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: SizedBox(
                height: 60,
                width: 320,
                child: 
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () async {
                    openAlertBox(context, _globalbloc);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          )
        ],
      ),
    );
  }

  openAlertBox(BuildContext context, GlobalBloc _globalbloc) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          title: const Text('Delete this Reminder? '),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                )),
            TextButton(
                onPressed: () {
                  setState(() {
                    Cancell == true;
                  });
                  _globalbloc.removeMedicine(widget.medicine);
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text('OK', style: TextStyle(color: Colors.red))),
          ],
        );
      },
    );
  }

  bool Cancell = false;
}

class MainSection extends StatelessWidget {
  const MainSection({super.key, this.medicine});
  final Medicine? medicine;

  Hero makeIcon() {
    if (medicine!.medicineType == 'bottle') {
      return Hero(
          tag: medicine!.medicineName! + medicine!.medicineType!,
          child: Image.asset('lib/counter/bottle1.png'));
    } else if (medicine!.medicineType == 'injection') {
      return Hero(
          tag: medicine!.medicineName! + medicine!.medicineType!,
          child: Image.asset(
            'lib/counter/inge2.png',
            //width: 150,
          ));
    } else if (medicine!.medicineType == 'pill') {
      return Hero(
          tag: medicine!.medicineName! + medicine!.medicineType!,
          child: Image.asset('lib/counter/pills1.png'));
    }
    return Hero(
        tag: medicine!.medicineName! + medicine!.medicineType!,
        child: const Icon(Icons.error));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          child: makeIcon(),
          height: 80,
        ),
        // Image.asset('lib/counter/bottle1.png',
        // height: 80,
        // ),
        Column(
          children: [
            Hero(
              tag: medicine!.medicineName!,
              child: MainInfoTab(
                fieldTitle: 'Medicine Name',
                fieldInfo: medicine!.medicineName!,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MainInfoTab(
              fieldTitle: 'Dosage',
              fieldInfo: medicine!.dosage == 0
                  ? "Not Specified"
                  : "${medicine!.dosage}mg",
            ),
          ],
        )
      ],
    );
  }
}

class MainInfoTab extends StatelessWidget {
  const MainInfoTab(
      {super.key, required this.fieldTitle, required this.fieldInfo});
  final String fieldTitle;
  final String fieldInfo;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 230,
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fieldTitle,
                  style: const TextStyle(
                    fontSize: 27,
                  ),
                ),
                Text(
                  fieldInfo,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExtendInfoTab extends StatelessWidget {
  const ExtendInfoTab(
      {super.key, required this.fieldTitle, required this.fieldInfo});
  final String fieldTitle;
  final String fieldInfo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldTitle,
            style: const TextStyle(
              fontSize: 27,
            ),
          ),
          Text(
            fieldInfo,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w300, color: Colors.red),
          )
        ],
      ),
    );
  }
}

class ExtendSection extends StatelessWidget {
  const ExtendSection({super.key, required this.medicine});
  final Medicine medicine;
  @override
  Widget build(BuildContext context) {
    String x = ':';

    return SizedBox(
      height: 300,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExtendInfoTab(
                      fieldTitle: 'Medicine Type',
                      fieldInfo: medicine.medicineType! == 'None'
                          ? 'Not specified'
                          : medicine.medicineType!),
                  ExtendInfoTab(
                      fieldTitle: 'Dose Interval',
                      fieldInfo:
                          'Every ${medicine.interval} hours | ${medicine.interval == 24 ? "one time a day" : " ${(24 / medicine.interval!).floor()} times a day"}'),
                  ExtendInfoTab(
                      fieldTitle: 'Start Time',
                      fieldInfo:
                          '${medicine.startTime![0]}${medicine.startTime![1]} ${x} ${medicine.startTime![2]}${medicine.startTime![3]}'),
                  Text(
                    'Day ${DateFormat('EEEE').format(DateTime.now())}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Date ${DateFormat('MMMM d, yyyy').format(DateTime.now())}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.red),
                  ),
                ],
              )),
    );
  }
}

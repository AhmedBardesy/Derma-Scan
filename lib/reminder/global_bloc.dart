import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_cam_1/reminder/medicine.dart';

 
class GlobalBloc {
  BehaviorSubject<List<Medicine>>? _medicineList$;
  BehaviorSubject<List<Medicine>>? get medicineList$ => _medicineList$;
  GlobalBloc(){
    _medicineList$ = BehaviorSubject<List<Medicine>>.seeded([]);
    makeMedicineList();
  }

  Future removeMedicine(Medicine tobeRemoved)async{
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    SharedPreferences sharedUser = await SharedPreferences.getInstance();

    List<String> medicineJsonList = [];
    var blocList = _medicineList$!.value;
    blocList.removeWhere((medicine) => medicine.medicineName == tobeRemoved.medicineName);
    
     for (int i = 0; i < (24 / tobeRemoved.interval!).floor(); i++) {
      flutterLocalNotificationsPlugin
          .cancel(int.parse(tobeRemoved.notificationIDs![i]));
    }



    if(blocList.isNotEmpty){
      for (var blocMedicine in blocList){
        String medicineJson = jsonEncode(blocMedicine.toJson());
        medicineJsonList.add(medicineJson);
      }
    }
    sharedUser.setStringList('medicines', medicineJsonList);
    _medicineList$!.add(blocList);
  }

  Future updateMedicineList(Medicine newMedicne)async{
    var blocList = _medicineList$!.value;
    blocList.add(newMedicne);
    _medicineList$!.add(blocList);

    Map<String ,dynamic> tempMap = newMedicne.toJson();
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    String newMedicneJson = jsonEncode(tempMap);
    List<String> medicineJsonList = [];
    if(sharedUser.getStringList('medicines')==null){
      medicineJsonList.add(newMedicneJson);
    }else{
      medicineJsonList = sharedUser.getStringList('medicines')!;
      medicineJsonList.add(newMedicneJson);
    }
    sharedUser.setStringList('medicines', medicineJsonList);
  }

  Future makeMedicineList() async{
    SharedPreferences? sharedUser =  await SharedPreferences.getInstance();
    List<String>? jsonList = sharedUser.getStringList('medicines');
    
    List<Medicine> prefList = [];

    if (jsonList ==  null){
      return;
    }else{
      for (String jsonMedicine in jsonList){
        dynamic userMap = jsonDecode(jsonMedicine);
        Medicine tempMedicine = Medicine.fromJson(userMap);
        prefList.add(tempMedicine);
      }
      //set state
      _medicineList$!.add(prefList);
    }

  }
  
  void dispose(){
    _medicineList$!.close();
  }
}
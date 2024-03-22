import 'package:rxdart/rxdart.dart';
import 'package:test_cam_1/reminder/errors.dart';
import 'package:test_cam_1/reminder/new_entry.dart';
class NewEntryBloc{
 BehaviorSubject<MedicineType>? _selectedMedicineType$;
 ValueStream<MedicineType>? get selectedMedicineType =>
 _selectedMedicineType$!.stream; 

 BehaviorSubject<int>? _selectedInterval$;
 BehaviorSubject<int>? get selectedIntervals => _selectedInterval$ ; 

 BehaviorSubject<String>? _selectedTimeOfDays$;
 BehaviorSubject<String>? get selectedTimeOfDays$ => _selectedTimeOfDays$;

 BehaviorSubject<EntryError>? _errorState$;
 BehaviorSubject <EntryError>? get errorState$ => _errorState$;

 NewEntryBloc(){
  _selectedMedicineType$ =
      BehaviorSubject<MedicineType>.seeded(MedicineType.none);

  _selectedTimeOfDays$ =BehaviorSubject<String>.seeded('none');
  _selectedInterval$ = BehaviorSubject<int>.seeded(0);
  _errorState$ = BehaviorSubject<EntryError>();

}
void dispose (){
  _selectedMedicineType$!.close();
  _selectedInterval$!.close();
  _selectedTimeOfDays$!.close();
}
void submitError(EntryError error){
  _errorState$!.add(error);
}

void updateInterval(int interval){
  _selectedInterval$!.add(interval);
}

void updateTime(String time){
  _selectedTimeOfDays$!.add(time); 
}

void updateSelectedMedicine(MedicineType type){
  MedicineType _tempType = _selectedMedicineType$!.value;
  if(type == _tempType){
    _selectedMedicineType$!.add(MedicineType.none);
  }else{
    _selectedMedicineType$!.add(type);
  }
}

}
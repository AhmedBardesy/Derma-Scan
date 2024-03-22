String convertTime(String minute){
  if(minute.length==1)  {
    return "0$minute";
  }
  else {
    return minute;
  }
}
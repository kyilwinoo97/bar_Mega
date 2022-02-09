class Utils{
  static final String type = "debug";
  static void Log(String message){
    if(type == "debug"){
      print("bar mega => " + message);
    }
  }
}
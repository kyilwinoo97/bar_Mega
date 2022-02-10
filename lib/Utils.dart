import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as intl;

class Utils{
  static Utils _instance;
  Utils._internal(){
    _instance = this;
  }
  factory Utils() => _instance ?? Utils._internal();
static const String All ="All";
static const String MainMenu ="Main Menu";
static const String SoftDrink ="Soft Drink";
static const String AlcoholicDrink ="Alcoholic Drink";
static const String Desserts ="Desserts";
static const List<String> categoryList = [All,MainMenu,SoftDrink,AlcoholicDrink,Desserts];


static const String dish ="dish";
static const String bottle ="bottle";
static const String cup ="cup";
static const List<String> unitList = [dish,bottle,cup];

  static bool validatePhone(String phone) {
    final regex = new RegExp(r"^(09|\+?950?9|\+?95950?9)\d{7,9}$$", multiLine: false);
    return regex.hasMatch(phone);
  }
  static  bool isEqualDateFilter(DateTime objDate, DateTime fromDate, DateTime toDate) {
    String fromDateString =  formatDate(fromDate);
    String toDateString =  formatDate(toDate);
    return objDate.compareTo(new intl.DateFormat("dd-MM-yyyy").parse(fromDateString)) >= 0 && objDate.compareTo(new intl.DateFormat("dd-MM-yyyy").parse(toDateString)) <= 0;

  }
  static String getCurrentDate(){
    DateTime now = new DateTime.now();
    var formatter = new intl.DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
  static String formatDate(DateTime dateTime){
    var formatter = new intl.DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }
  static String formatTime(DateTime dateTime){
    var formatter = new intl.DateFormat('hh:mm a');
    return formatter.format(dateTime);
  }
}
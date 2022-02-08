class Utils{
  static Utils _instance;
  Utils._internal(){
    _instance = this;
  }
  factory Utils() => _instance ?? Utils._internal();
static const String MainMenu ="Main Menu";
static const String SoftDrink ="Soft Drink";
static const String AlcoholicDrink ="Alcoholic Drink";
static const String Desserts ="Desserts";
static const List<String> categoryList = [MainMenu,SoftDrink,AlcoholicDrink,Desserts];
}
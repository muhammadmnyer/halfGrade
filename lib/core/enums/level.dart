enum Level{
  hard,
  medium,
  easy;

  static Level fromString(String text){
    switch(text.toLowerCase().trim()){
      case "hard":
        return Level.hard;
      case "medium":
        return Level.medium;
      case "easy":
        return Level.easy;
      default:
        throw "unimplemented error";
    }
  }
}
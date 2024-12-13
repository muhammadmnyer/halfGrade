abstract class Validate{

  static String? emptinessValidation(String? value){

    if(value == null || value.trim().isEmpty){
      return "this field can't be empty";
    }
    return null;
  }

  static String? emailValidation(String? value){

    if(emptinessValidation(value)!= null){
      return emptinessValidation(value);
    }

    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!)){
      return "invalid email";
    }
    return null;
  }

  static String? passwordValidation(String? value){

    if(emptinessValidation(value)!= null){
      return emptinessValidation(value);
    }

    if(value!.length<8){
      return "password must be at least 8 characters";
    }
    return null;
  }

  static String? passwordConfirmationValidation(String? confirmedPassword,String? password){

    if(emptinessValidation(confirmedPassword)!= null){
      return emptinessValidation(confirmedPassword);
    }

    if(password != null && password != confirmedPassword){
      return 'passwords doesn\'t match';
    }
    return null;
  }

  static String deepLinkValidation(String route){

    if (route.contains('muhammadmnyer')){
      if(route.contains("#")){
        route = route.split("#")[1];
      }
      else{
        route = '/';
      }
    }
    else{
      try{
        route = route.split("#")[1];
      } on RangeError{
        /// will be thrown when the app runs normally without any deep links
      }

    }

    return route;
  }

}
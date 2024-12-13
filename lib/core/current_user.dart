class CurrentUser{

  final String uuid;
  final List<int> solvedExams;
  String username;
  String schoolName;
  final String city;
  int points;

  static CurrentUser? instance;

  CurrentUser._internal({
    required this.points,
    required this.solvedExams,
    required this.uuid,
    required this.username,
    required this.schoolName,
    required this.city
  });


  static void initialize({
    required int points,
    required List<int> solvedExams,
    required String uuid,
    required String username,
    required String schoolName,
    required String city
  }){
    assert(instance == null,'current user is already initialized');
    instance = CurrentUser._internal(
        points: points,
        solvedExams: solvedExams,
        uuid: uuid,
        username: username,
        schoolName: schoolName,
        city: city
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'points': points,
      'solved_exams': solvedExams,
      'username': username,
      'school_name': schoolName
    };
  }
}
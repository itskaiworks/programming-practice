import 'dart:io';

void main() {
  print('\n ===== STUDENT GRADE CALCULATOR =====');
  stdout.write(" Enter Full Name: ");
  String? fullName = stdin.readLineSync();
  stdout.write(" Enter Quiz Score: ");
  int quiz = int.parse(stdin.readLineSync()!);
  stdout.write(" Enter Assignment Score: ");
  int assignment = int.parse(stdin.readLineSync()!);
  stdout.write(" Enter Exam Score: ");
  int exam = int.parse(stdin.readLineSync()!);

  double average = calculateAverage(quiz, assignment, exam);

  print(
    '\n --------- RESULT ---------' +
        '\n Name      : $fullName     ' +
        '\n Quiz      : $quiz         ' +
        '\n Assignment: $assignment   ' +
        '\n Exam      : $exam         ' +
        '\n --------------------------' +
        '\n Average   : $average      ' +
        '\n Standing  : ' +
        determineGrade(average) +
        '\n --------------------------',
  );
}

double calculateAverage(int quiz, int assignment, int exam) {
  return (quiz * 0.30) + (assignment * 0.20) + (exam * 0.50);
}

String determineGrade(double average) {
  String letterGrade;
  if (average > 75) {
    letterGrade = "A";
  } else if (average > 65 && average < 74) {
    letterGrade = "B";
  } else if (average > 55 && average < 64) {
    letterGrade = "C";
  } else {
    letterGrade = "F";
  }
  return letterGrade;
}

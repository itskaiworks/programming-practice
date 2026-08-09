import 'dart:io';

void main() {
  print(
    '\n\n ========================================='
    '\n       FILL OUT STUDENT INFORMATION       '
    '\n =========================================',
  );

  stdout.write('\n Student Name: ');
  var studentName = stdin.readLineSync();
  stdout.write(' Student Number: ');
  var studentNumber = int.parse(stdin.readLineSync() ?? '0');
  stdout.write(' Student Course: ');
  var course = stdin.readLineSync();
  stdout.write(' Section: ');
  var section = stdin.readLineSync();

  print(
    '\n -----------------------------------------'
    '\n ENTER GRADES PER SUBJECT                 '
    '\n -----------------------------------------',
  );
  stdout.write('\n Mathematics: ');
  var math = double.parse(stdin.readLineSync() ?? '0.0');
  stdout.write(' English: ');
  var english = double.parse(stdin.readLineSync() ?? '0.0');
  stdout.write(' Science: ');
  var science = double.parse(stdin.readLineSync() ?? '0.0');
  stdout.write(' Filipino: ');
  var filipino = double.parse(stdin.readLineSync() ?? '0.0');
  stdout.write(' Computer Programming: ');
  var comprog = double.parse(stdin.readLineSync() ?? '0.0');
  stdout.write(' PE: ');
  var pe = double.parse(stdin.readLineSync() ?? '0.0');
  stdout.write(' NSTP: ');
  var nstp = double.parse(stdin.readLineSync() ?? '0.0');

  //CALCULATION
  var totalGrades = math + english + science + filipino + comprog + pe + nstp;
  var averageGrade = totalGrades / 7;
  averageGrade.toStringAsFixed(2);

  //CLASIFICATION
  var letterGrade = '';
  if (averageGrade >= 95 && averageGrade <= 100) {
    letterGrade = 'A';
  } else if (averageGrade >= 90 && averageGrade <= 94.99) {
    letterGrade = 'B';
  } else if (averageGrade >= 85 && averageGrade <= 89.99) {
    letterGrade = 'C';
  } else if (averageGrade >= 80 && averageGrade <= 84.99) {
    letterGrade = 'D';
  } else {
    letterGrade = 'F';
  }

  //REMARKS
  var remarks = '';
  if (averageGrade >= 80) {
    remarks = 'PASSED';
  } else {
    remarks = 'FAILED';
  }

  //EVEN or ODD
  var evenOdd = '';
  if (averageGrade % 2 == 0) {
    evenOdd = 'Even';
  } else {
    evenOdd = 'Odd';
  }

  //PERFORMANCE MESSAGE
  var performanceMess = '';
  if (averageGrade >= 95 && averageGrade <= 100) {
    performanceMess = 'Outstanding Performance!';
  } else if (averageGrade >= 90 && averageGrade <= 94) {
    performanceMess = 'Excellent Work!';
  } else if (averageGrade >= 85 && averageGrade <= 89) {
    performanceMess = 'Good Job!';
  } else if (averageGrade >= 80 && averageGrade <= 84) {
    performanceMess = 'Needs Improvement.';
  } else {
    performanceMess = 'Study Harder Next Time.';
  }

  //DISPLAY RESULTS
  print(
    '\n ========================================='
    '\n          STUDENT GRADE DETAILS           '
    '\n -----------------------------------------'
    '\n Name                 : $studentName      '
    '\n Student Number       : $studentNumber    '
    '\n Course               : $course           '
    '\n Section              : $section          '
    '\n -----------------------------------------'
    '\n GRADE PER SUBJECT                        '
    '\n -----------------------------------------'
    '\n Mathematics          : $math             '
    '\n English              : $english          '
    '\n Science              : $science          '
    '\n Filipino             : $filipino         '
    '\n Computer Programming : $comprog          '
    '\n PE                   : $pe               '
    '\n NSTP                 : $nstp             '
    '\n -----------------------------------------'
    '\n GRADE STANDING | [$letterGrade]          '
    '\n -----------------------------------------'
    '\n Total                : $totalGrades      '
    '\n Average              : $averageGrade | $evenOdd'
    '\n Remarks              : $remarks          '
    '\n Performance Message  : $performanceMess  '
    '\n =========================================\n\n',
  );
}

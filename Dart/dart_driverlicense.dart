import 'dart:io';

void main() {
  print('\n\n ==== DRIVERS LICENSE ASSESSMENT SYSTEM ==== ');

  stdout.write('\n Enter Drivers Name: ');
  var name = stdin.readLineSync();

  stdout.write(' Enter Age: ');
  var age = int.parse(stdin.readLineSync() ?? '0');

  if (age > 100) {
    print('\n NOTIF: Invalid age input. Try again.\n');
    return;
  }

  //FUNCTIONS
  var licenseType = '';
  var score = 0;

  if (age >= 18 && age <= 100) {
    stdout.write(' Enter Exam Score (0 - 100): ');
    score = int.parse(stdin.readLineSync() ?? '0');

    if (score > 100) {
      print('\n NOTIF: Invalid score input. Try again.\n');
      return;
    }

    if (score < 75) {
      licenseType = "No License Qualification";
    } else if (score >= 75 && score <= 79) {
      licenseType = "Type A | Motorcycle";
    } else if (score >= 80 && score <= 89) {
      licenseType = "Type B | Private Car";
    } else {
      licenseType = "Type C | Commercial Vehicle";
    }
  } else {
    print('\n NOTIF: Age not qualified. Try again after years.\n');
    return;
  }

  print(
    '\n --------------------------------------------'
    '\n         DRIVERS LICENSURE RESULTS           '
    '\n --------------------------------------------'
    '\n Applicant Name     : $name                  '
    '\n Age                : $age                   '
    '\n Examination Score  : $score                 '
    '\n --------------------------------------------'
    '\n Qualification Type : $licenseType           '
    '\n --------------------------------------------\n\n',
  );
}

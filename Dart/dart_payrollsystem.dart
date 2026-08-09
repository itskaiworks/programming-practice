import 'dart:io';

void main() {
  int id, type, hours, rate, years, overtime, bonus, regularPay = 0;
  double overtimePay, grossPay, tax, netPay = 0;
  String? name;
  String employeeType = "Contractual";
  print(
    '\n\n ============================='
    '\n    EMPLOYEE PAYROLL SYSTEM   '
    '\n =============================',
  );

  stdout.write("\n Enter Employee Name: ");
  name = stdin.readLineSync();
  stdout.write(" Employee ID: ");
  id = int.parse(stdin.readLineSync()!);

  print(
    '\n CHOOSE EMPLOYEE TYPE: '
    '\n [1] Regular           '
    '\n [2] Contractual       ',
  );
  stdout.write("\n\n Enter Choice: ");
  type = int.parse(stdin.readLineSync()!);

  if (type == 1) {
    employeeType = "Regular";
  } 

  stdout.write("\n Enter Hours Worked: ");
  hours = int.parse(stdin.readLineSync()!);
  stdout.write(" Enter Hourly Rate: ");
  rate = int.parse(stdin.readLineSync()!);
  stdout.write(" Enter Years of Service: ");
  years = int.parse(stdin.readLineSync()!);

  //CALCULATIONS
  if (hours > 40) {
    regularPay = 40 * rate;
  } else {
    regularPay = hours * rate;
  }

  overtimePay = 0;

  if (hours > 40) { //FOR OVERTIME PAY
    overtime = hours - 40;
    overtimePay = overtime * rate * 1.5;
  } else {
    overtimePay = 0;
  }

  grossPay = regularPay + overtimePay;

  bonus = 0;

  if (type == 1) { //FOR BONUS APPLICATION
    if (years >= 10) {
      bonus = 10000;
    } else if (years >= 5 && years < 10) {
      bonus = 5000;
    } else {
      bonus = 2000;
    }
  } else if (type == 2) {
    if (years >= 5) {
      bonus = 3000;
    } else {
      bonus = 0;
    }
  }

  tax = 0;

  if (grossPay > 50000) { //FOR TAX APPLICATION
    if (type == 1) {
      tax = grossPay * 0.12; 
    } else {
      tax = grossPay * 0.08;
    }
  } else {
    tax = grossPay * 0.05; 
  }

  netPay = grossPay + bonus - tax;

  //PRINT PAYROLL REPORT
  print(
    '\n ============================='
    '\n         PAYROLL REPORT       '
    '\n ============================='
    '\n\n Employee Name    : $name     '
    '\n Employee ID      : $id       '
    '\n Employment Type  : $employeeType'
    '\n\n Hours Worked     : $hours    '
    '\n Hourly Rate      : $rate     '
    '\n\n Gross Pay        : P$grossPay'
    '\n Bonus            : P$bonus   '
    '\n Tax              : P$tax     '
    '\n\n Net Pay          : P$netPay  \n '
    '\n =============================\n',
  );
}

import 'dart:io';

void main(List<String> arguments) {
  List<Employee> employee = [];

  String empName;
  int choice, hoursWork, empId;
  double hourlyRate;

  while (true) {
    stdout.write(
      '\n ==================================== '
      '\n         PAYROLL SYSTEM MENU          '
      '\n ==================================== '
      '\n [1] Add Employee                     '
      '\n [2] Display Payroll                  '
      '\n [0] Exit System                      '
      '\n ==================================== '
      '\n\n Enter Choice: ',
    );
    choice = int.tryParse(stdin.readLineSync()!) ?? 0;

    switch (choice) {
      case 1:
        stdout.write(
          '\n ------------------------------------ '
          '\n FILL OUT EMPLOYEE INFORMATION        '
          '\n ------------------------------------ '
          '\n ID: ',
        );
        empId = int.tryParse(stdin.readLineSync()!) ?? 0;

        stdout.write(' Full Name: ');
        empName = stdin.readLineSync() ?? '';

        stdout.write(' Hourly Rate: ');
        hourlyRate = double.tryParse(stdin.readLineSync()!) ?? 0.0;

        stdout.write(' Hours Work: ');
        hoursWork = int.tryParse(stdin.readLineSync()!) ?? 0;

        if (hoursWork <= 40) {
          employee.add(RegularEmployee(empId, empName, hourlyRate, hoursWork));
        } else {
          employee.add(OvertimeEmployee(empId, empName, hourlyRate, hoursWork));
        }

        print('\n [SUCCESS]: Employee added successfully! \n');
        break;

      case 2:
        for (Employee payroll in employee) {
          print(payroll.displayPayroll());
        }
        break;

      case 0:
        print('\n [System Exiting...] Thank you for using the system!\n\n');
        return;

      default:
        print('\n [OOPS...] Wrong input. Please enter 0-2 choice only.\n');
        break;
    }
  }
}

//ABSTRACT CLASS - Employee ----------------------------------------------------

abstract class Employee {
  int? _empId;
  String? _empName;
  double? _hourlyRate;
  int? _hoursWork;

  Employee(int empId, String empName, double hourlyRate, int hoursWork) {
    this._empId = empId;
    this._empName = empName;
    this._hourlyRate = hourlyRate;
    this._hoursWork = hoursWork;
  }

  //Getters
  int getEmpId() {
    return _empId!;
  }

  String getEmpName() {
    return _empName!;
  }

  double getHourlyRate() {
    return _hourlyRate!;
  }

  int getHoursWork() {
    return _hoursWork!;
  }

  //Setters
  void setEmpId(int empId) {
    this._empId = empId;
  }

  void setEmpName(String empName) {
    this._empName = empName;
  }

  void setHourlyRate(double hourlyRate) {
    this._hourlyRate = hourlyRate;
  }

  void setHoursWork(int hoursWork) {
    this._hoursWork = hoursWork;
  }

  //Abstract Methods
  double calculateGrossSalary();

  double calculateDeduction();

  double calculateNetSalary();

  String displayPayroll();
}

//INHERITANCE CLASS - Regular --------------------------------------------------

class RegularEmployee extends Employee {
  RegularEmployee(int empId, String empName, double hourlyRate, int hoursWork)
    : super(empId, empName, hourlyRate, hoursWork);

  @override
  double calculateGrossSalary() {
    return getHourlyRate() * getHoursWork();
  }

  @override
  double calculateDeduction() {
    double deduction = 0;

    if (calculateGrossSalary() >= 20000) {
      deduction = calculateGrossSalary() * 0.10;
    } else if (calculateGrossSalary() >= 10000 &&
        calculateGrossSalary() < 20000) {
      deduction = calculateGrossSalary() * 0.05;
    } else if (calculateGrossSalary() < 10000) {
      deduction = calculateGrossSalary() * 0.02;
    }

    return deduction;
  }

  @override
  double calculateNetSalary() {
    return calculateGrossSalary() - calculateDeduction();
  }

  @override
  String displayPayroll() {
    return '\n ==================================== '
        '\n          EMPLOYEE PAYSLIP            '
        '\n ==================================== '
        '\n ID            : ${getEmpId()}        '
        '\n Full Name     : ${getEmpName()}      '
        '\n Type          : Regular              '
        '\n Hourly Rate   : ${getHourlyRate()}   '
        '\n Hours Worked  : ${getHoursWork()}    '
        '\n ------------------------------------ '
        '\n ------------------------------------ '
        '\n Regular Pay   : ${calculateGrossSalary()} '
        '\n Overtime Pay  : 0.00                      '
        '\n Gross Salary  : ${calculateGrossSalary()} '
        '\n Deduction     : ${calculateDeduction()}   '
        '\n Net Salary    : ${calculateNetSalary()}   '
        '\n ====================================      ';
  }
}

//INHERITANCE CLASS - Overtime -------------------------------------------------

class OvertimeEmployee extends Employee {
  OvertimeEmployee(int empId, String empName, double hourlyRate, int hoursWork)
    : super(empId, empName, hourlyRate, hoursWork);

  double calculateOvertimePay() {
    int overtimeHours = getHoursWork() - 40;
    double overtimeRate = getHourlyRate() * 1.5;

    return overtimeHours * overtimeRate;
  }

  double calculateRegularPay() {
    return getHoursWork() * getHourlyRate();
  }

  @override
  double calculateGrossSalary() {
    double regularPay = getHoursWork() * getHourlyRate();

    return calculateRegularPay() + calculateOvertimePay();
  }

  @override
  double calculateDeduction() {
    double deduction = 0;

    if (calculateGrossSalary() >= 20000) {
      deduction = calculateGrossSalary() * 0.10;
    } else if (calculateGrossSalary() >= 10000 &&
        calculateGrossSalary() < 20000) {
      deduction = calculateGrossSalary() * 0.05;
    } else if (calculateGrossSalary() < 10000) {
      deduction = calculateGrossSalary() * 0.02;
    }

    return deduction;
  }

  @override
  double calculateNetSalary() {
    return calculateGrossSalary() - calculateDeduction();
  }

  @override
  String displayPayroll() {
    return '\n ==================================== '
        '\n          EMPLOYEE PAYSLIP            '
        '\n ==================================== '
        '\n ID            : ${getEmpId()}        '
        '\n Full Name     : ${getEmpName()}      '
        '\n Type          : Overtime             '
        '\n Hourly Rate   : ${getHourlyRate()}   '
        '\n Hours Worked  : ${getHoursWork()}    '
        '\n ------------------------------------ '
        '\n ------------------------------------ '
        '\n Regular Pay   : ${calculateRegularPay()} '
        '\n Overtime Pay  : ${calculateOvertimePay()} '
        '\n Gross Salary  : ${calculateGrossSalary()} '
        '\n Deduction     : ${calculateDeduction()}   '
        '\n Net Salary    : ${calculateNetSalary()}   '
        '\n ====================================      ';
  }
}

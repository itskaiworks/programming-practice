import 'dart:io';

void main(List<String> arguments) {
  var result = [];

  while (true) {
    print(
      '\n ======================================'
      '\n      ARITHMETIC CALCULATOR SYSTEM     '
      '\n ======================================'
      '\n [1] Addition                          '
      '\n [2] Subtraction                       '
      '\n [3] Multiplication                    '
      '\n [4] Division                          '
      '\n [5] Modulus                           '
      '\n [6] View Calculation History          '
      '\n [7] Search Result                     '
      '\n [8] Clear History                     '
      '\n [9] Exit                              '
      '\n ======================================',
    );

    stdout.write('\n Enter Choice: ');
    var choice = int.tryParse(stdin.readLineSync() ?? '');

    var num1;
    var num2;

    if (choice != null && choice >= 1 && choice <= 5) {
      stdout.write(
        '\n --------------------------------------'
        '\n ENTER TWO NUMBERS                     '
        '\n --------------------------------------'
        '\n Num 1: ',
      );

      num1 = double.tryParse(stdin.readLineSync() ?? '');

      stdout.write(' Num 2: ');
      num2 = double.tryParse(stdin.readLineSync() ?? '');

      if (num1 == null || num2 == null) {
        print('\n [OOPS...] Please enter valid numbers only.');
        continue;
      }
    }

    switch (choice) {
      case 1:
        var answer = calcAddition(num1, num2);

        print('\n Result: $answer');

        result.add(answer);
        break;

      case 2:
        var answer = calcSubtraction(num1, num2);

        print('\n Result: $answer');

        result.add(answer);
        break;

      case 3:
        var answer = calcMultiplication(num1, num2);

        print('\n Result: $answer');

        result.add(answer);
        break;

      case 4:
        if (num1 == 0) {
          num1 = getNonZeroNumber();
        } else if (num2 == 0) {
          num2 = getNonZeroNumber();
        }

        var answer = calcDivision(num1, num2);

        print('\n Result: $answer');

        result.add(answer);
        break;

      case 5:
        if (num2 == 0) {
          num2 = getNonZeroNumber();
        }

        var answer = calcModulus(num1, num2);

        print('\n Result: $answer');

        result.add(answer);
        break;

      case 6:
        print(viewCalculationHistory(result));
        break;

      case 7:
        if (result.isEmpty) {
          print(
            '\n [MESSAGE]: Calculation history is empty. Cannot proceed to search.',
          );
          break;
        }

        print(
          '\n --------------------------------------'
          '\n SEARCH CALCULATION RESULT             '
          '\n --------------------------------------',
        );

        var searchNum;

        do {
          stdout.write('\n Enter Number: ');
          searchNum = double.tryParse(stdin.readLineSync() ?? '');

          if (searchNum == null) {
            print('\n [OOPS...]: Please enter a valid number.');
          }

        } while (searchNum == null);

        print(searchResult(searchNum, result));
        break;

      case 8:
        if (result.isEmpty) {
          print('\n [MESSAGE]: Calculation history is already empty.');
          break;
        }

        print(
          '\n [CLEARING...]'
          '\n Calculation history cleared successfully!',
        );

        result.clear();
        break;

      case 9:
        print(
          '\n [EXITING...]'
          '\n Thank you for using the Arithmetic Calculator System!'
          '\n',
        );

        return;

      default:
        print(
          '\n [OOPS..]: Wrong choice.'
          '\n Please input a valid whole number between 1 - 9 only.',
        );

        break;
    }
  }
}

// CALCULATIONS FUNCTION

double calcAddition(double num1, double num2) {
  return num1 + num2;
}

double calcSubtraction(double num1, double num2) {
  return num1 > num2 ? num1 - num2 : num2 - num1;
}

double calcMultiplication(double num1, double num2) {
  return num1 * num2;
}

double calcDivision(double num1, double num2) {
  return num1 > num2 ? num1 / num2 : num2 / num1;
}

double calcModulus(double num1, double num2) {
  return num1 % num2;
}

// VIEW HISTORY & SEARCH RESULT FUNCTION

String viewCalculationHistory(dynamic result) {
  if (!result.isEmpty) {
    var history = '';

    for (var index = 0; index < result.length; index++) {
          history +=
          '\n [${index + 1}]: ${result[index]}'
          '\n --------------------------------------';
    }

    return  '\n ======================================'
            '\n          CALCULATION HISTORY          '
            '\n --------------------------------------'
            '$history'
            '\n ======================================';
  }

  return  '\n ====================================== '
          '\n          CALCULATION HISTORY           '
          '\n -------------------------------------- '
          '\n No calculations have been recorded yet.'
          '\n ====================================== ';
}

String searchResult(double searchNum, dynamic result) {
  for (var index = 0; index < result.length; index++) {
    if (result[index] == searchNum) {
      return '\n [SEARCHING...]'
             '\n Result Found: ${result[index]}';
    }
  }

  return '\n [SEARCHING...]'
         '\n Result Not Found.';
}

// ADDITIONAL

double getNonZeroNumber() {
  print(
    '\n [OOPS...]'
    '\n Cannot proceed. The number must not be zero.',
  );

  var newNum;

  do {
    stdout.write('\n Enter New Number: ');

    newNum = double.tryParse(stdin.readLineSync() ?? '');

    if (newNum == null || newNum == 0) {
      print(
        '\n [OOPS...] Wrong input.'
        '\n Please enter any valid number except zero.',
      );
    }
  } while (newNum == null || newNum == 0);

  return newNum;
}

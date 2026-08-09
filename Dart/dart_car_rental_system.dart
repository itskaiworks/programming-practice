import 'dart:io';

void main(List<String> arguments) {
  print(
    '\n\n ======================================'
    '\n           CAR RENTAL SYSTEM             '
    '\n ======================================  '
    '\n\n  >> ENTER REQUIRED INFORMATION <<     ',
  );
  stdout.write('\n Customer Name: ');
  var customer = stdin.readLineSync();

  stdout.write(' Number of Rental Days: ');
  var days = int.parse(stdin.readLineSync() ?? '0');

  stdout.write(
    '\n CHOOSE CAR TYPE: '
    '\n > Sedan          '
    '\n > SUV            '
    '\n > Van            '
    '\n\n Enter Type: ',
  );
  var type = stdin.readLineSync();

  print(displayReceipt(customer!, days, type!));
}

int dailyRentalRate(String type) {
  var rentalRate = 0;

  switch (type) {
    case "Sedan":
      rentalRate = 2000;
      break;
    case "SUV":
      rentalRate = 3000;
      break;
    case "Van":
      rentalRate = 4500;
      break;
    default:
      break;
  }

  return rentalRate;
}

double calculateDiscount(int days, String type) {
  var discount = 0.0;

  if (days > 5) {
    if (type == "SUV" || type == "Van") {
      discount = 0.15;
    } else if (type == "Sedan") {
      discount = 0.10;
    } else {
      discount = 0;
    }
  }

  return discount;
}

int calculateRentalCost(int days, String type) {
  return days * dailyRentalRate(type);
}

double calculateFinalPayment(int days, String type) {
  return calculateRentalCost(days, type) -
      (calculateRentalCost(days, type) * calculateDiscount(days, type));
}

String displayReceipt(String customer, int days, String type) {
  return '\n ======================================  '
      '\n             RENTAL RECEIPT              '
      '\n --------------------------------------  '
      '\n Customer     : $customer                '
      '\n Rental Days  : $days                    '
      '\n Car Type     : $type                    '
      '\n --------------------------------------  '
      '\n Daily Rate   : ${dailyRentalRate(type)} '
      '\n Discount     : ${calculateDiscount(days, type) * 100} % '
      '\n Sub Total    : ${calculateRentalCost(days, type)}       '
      '\n --------------------------------------                  '
      '\n Final Amount : ${calculateFinalPayment(days, type)}     '
      '\n ======================================\n\n              ';
}

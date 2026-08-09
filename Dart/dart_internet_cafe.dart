import 'dart:io';

void main(List<String> arguments) {
  print(
    '\n\n ======================================== '
    '\n           INTERNET CAFE SYSTEM             '
    '\n ========================================   '
    '\n > Welcome! Please be quiet. Thank you! < ',
  );
  stdout.write('\n Customer Name : ');
  var customer = stdin.readLineSync();

  stdout.write(' Hours Stay    : ');
  var hours = int.parse(stdin.readLineSync() ?? '0');

  stdout.write(
    '\n COMPUTER TYPE: '
    '\n > Standard     '
    '\n > Gaming       '
    '\n > VIP          '
    '\n\n Enter Type : ',
  );
  var type = stdin.readLineSync();

  print(displayReceipt(customer!, hours, type!));

  var payment = 0.0;
  do {
    stdout.write('\n ENTER PAYMENT: ');
    payment = double.parse(stdin.readLineSync()!);

    if (payment < calculateFinalPayment(hours, type)) { 

      print('\n Insufficient payment. Please enter a valid amount.');

    } else if (payment > calculateFinalPayment(hours, type)) {

      print ('\n ---------------------------------------- '
             '\n CHANGE: ${calculateexchange(payment, hours, type)}'
             '\n ---------------------------------------- ');

    }

  } while (payment < calculateFinalPayment(hours, type));

  print('\n NOTIF: Payment paid successfully! Thank you. \n\n');
}

int getHourlyRate(String type) {
  var rate = 0;

  switch (type) {
    case "Standard":
      rate = 30;
      break;
    case "Gaming":
      rate = 50;
      break;
    case "VIP":
      rate = 80;
      break;
    default:
      break;
  }

  return rate;
}

double getDiscount(int hours, String type) {
  var discount = 0.0;

  if (hours > 8) {
    if (type == "VIP") {
      discount = 0.20;
    } else if (type == "Gaming") {
      discount = 0.10;
    } else if (type == "Standard") {
      discount = 0.05;
    } else {
      discount = 0.0;
    }
  }

  return discount;
}

int calculateUsageFee(int hours, String type) {
  var total = 0;
  for (int index = 0; index < hours; index++) {
    total += getHourlyRate(type);
  }
  return total;
}

double calculateFinalPayment(int hours, String type) {
  return calculateUsageFee(hours, type) -
      (calculateUsageFee(hours, type) * getDiscount(hours, type));
}

double calculateexchange(double payment, int hours, String type) {
  return payment - calculateFinalPayment(hours, type);
}

String displayReceipt(String customer, int hours, String type) {
  return '\n ======================================== '
      '\n              CAFE RECIEPT                '
      '\n ---------------------------------------- '
      '\n Customer      : $customer                '
      '\n Hours Stay    : $hours                   '
      '\n Compute Type  : $type                    '
      '\n ---------------------------------------- '
      '\n Hourly Rate   : ${getHourlyRate(type)}   '
      '\n Discount      : ${getDiscount(hours, type) * 100} %   '
      '\n Sub Total     : ${calculateUsageFee(hours, type)}     '
      '\n ----------------------------------------              '
      '\n Amount to Pay : ${calculateFinalPayment(hours, type)} '
      '\n ======================================== \n           ';
}

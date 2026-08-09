import 'dart:io';

List<String> itemNames = [];
List<int> itemQuantities = [];
List<double> itemPrices = [];

void main() {
  print(
    "\n\n >>  WELCOME TO THE GROCERY INVENTORY  <<"
    "\n >>        MANAGEMENT SYSTEM!          <<  ",
  );

  while (true) {
    printMenu();

    stdout.write("\n Enter Choice: ");
    String? input = stdin.readLineSync();

    int? choice = int.tryParse(input ?? "");

    if (choice == null) {
      print(
        errorMessage(
          "Invalid input. Choice must be a whole number from 0 to 7.",
        ),
      );
      continue;
    }

    switch (choice) {
      case 1:
        addNewItem();
        break;

      case 2:
        viewInventory();
        break;

      case 3:
        searchItem();
        break;

      case 4:
        updateItemName();
        break;

      case 5:
        updateItemQuantity();
        break;

      case 6:
        deleteItem();
        break;

      case 7:
        inventorySummary();
        break;

      case 0:
        print(
          "\n >>  Thank you for using the Grocery   << "
          "\n >>         Inventory System!          << "
          "\n >>            Come Again!             << \n\n",
        );
        return;
      default:
        print(
          errorMessage(
            "Invalid choice. Please enter a number between 0 and 7.",
          ),
        );
        break;
    }
  }
}

// MENU ------------------------------------------------------------------------

void printMenu() {
  print(
    "\n =========================================  "
    "\n            GROCERY SYSTEM MENU             "
    "\n =========================================  "
    "\n [1] Add New Item                           "
    "\n [2] View Inventory                         "
    "\n [3] Search Item                            "
    "\n [4] Update Item Name                       "
    "\n [5] Update Item Quantity                   "
    "\n [6] Delete Item                            "
    "\n [7] Inventory Summary                      "
    "\n [0] Exit                                   "
    "\n =========================================  ",
  );
}

// FUNCTIONS -------------------------------------------------------------------

void addNewItem() {
  print(subHeader("FILL OUT NEW ITEM DETAILS"));

  // ITEM NAME INPUT VALIDATION
  String itemName = "";
  RegExp validNamePattern = RegExp(r'^[a-zA-Z ]+$');

  bool validName = false;

  do {
    stdout.write(" Name: ");
    String? nameInput = stdin.readLineSync();

    if (nameInput == null || nameInput.trim().isEmpty) {
      print(errorMessage("Item name cannot be empty. Please try again."));
      continue;
    }

    itemName = nameInput.trim();

    if (!validNamePattern.hasMatch(itemName)) {
      print(
        errorMessage(
          "Item name can only contain letters and spaces. Please try again.",
        ),
      );
      continue;
    }

    bool exists = itemNames.any(
      (name) => name.toLowerCase() == itemName.toLowerCase(),
    );

    if (exists) {
      print(
        errorMessage(
          "Item already exists. Please enter a different item name.",
        ),
      );
      continue;
    }

    validName = true;
  } while (!validName);

  // ITEM QUANTITY INPUT VALIDATION
  int quantity = 0;
  bool validQuantity = false;

  do {
    stdout.write(" Quantity: ");
    String? qtyInput = stdin.readLineSync();
    int? qty = int.tryParse(qtyInput ?? "");

    if (qty == null) {
      print(
        errorMessage("Quantity cannot be empty. Please enter a whole number."),
      );
      continue;
    } else if (qty < 0) {
      print(
        errorMessage("Quantity cannot be negative. Please enter 0 or greater."),
      );
      continue;
    }

    quantity = qty;
    validQuantity = true;
  } while (!validQuantity);

  // ITEM PRICE INPUT VALIDATION
  double itemPrice = 0;
  bool validPrice = false;

  do {
    stdout.write(" Unit Price: ");
    String? priceInput = stdin.readLineSync();
    double? price = double.tryParse(priceInput ?? "");

    if (price == null) {
      print(errorMessage("Invalid price. Please enter a valid number."));
      continue;
    } else if (price <= 0) {
      print(errorMessage("Price must be greater than 0. Please try again."));
      continue;
    }

    itemPrice = price;
    validPrice = true;
  } while (!validPrice);

  itemNames.add(itemName);
  itemQuantities.add(quantity);
  itemPrices.add(itemPrice);

  print(successMessage("'$itemName' has been added to the inventory!"));
}

// -----------------------------------------------------------------------------

void viewInventory() {
  if (itemNames.isEmpty) {
    print(
      "\n --------------------------------------------------------------- "
      "\n |                       INVENTORY LIST                        | "
      "\n --------------------------------------------------------------- "
      "\n | No. | Item Name           | Quantity |     Price |    Total | "
      "\n --------------------------------------------------------------- "
      "\n No items have been recorded yet.\n",
    );
    return;
  }

  print(
    "\n --------------------------------------------------------------- "
    "\n |                       INVENTORY LIST                        | "
    "\n --------------------------------------------------------------- "
    "\n | No. | Item Name           | Quantity |     Price |    Total |"
    "\n --------------------------------------------------------------- ",
  );

  for (int index = 0; index < itemNames.length; index++) {
    double total = itemQuantities[index] * itemPrices[index];

    print(
      " | ${(index + 1).toString().padRight(3)} "
      "| ${itemNames[index].padRight(19)} "
      "| ${itemQuantities[index].toString().padLeft(8)} "
      "| ${itemPrices[index].toStringAsFixed(2).padLeft(9)} "
      "| ${total.toStringAsFixed(2).padLeft(8)} |",
    );
  }

  print(" ---------------------------------------------------------------\n ");
}

// -----------------------------------------------------------------------------

void searchItem() {
  print(subHeader("SEARCH ITEM"));

  if (itemNames.isEmpty) {
    print(
      errorMessage("Cannot proceed to search an item. Inventory is empty."),
    );
    return;
  }

  String keyword = "";
  bool validInput = false;

  // ITEM NAME VALIDATION BEFORE SEARCHING
  do {
    stdout.write(" Enter Item Name: ");
    String? input = stdin.readLineSync();

    if (input == null || input.trim().isEmpty) {
      print(
        errorMessage("Search item name cannot be empty. Please try again."),
      );
      continue;
    }

    keyword = input.trim();
    validInput = true;
  } while (!validInput);

  String searchKey = keyword.toLowerCase();
  List<int> matches = [];

  for (int index = 0; index < itemNames.length; index++) {
    if (itemNames[index].toLowerCase().contains(searchKey)) {
      matches.add(index);
    }
  }

  if (matches.isEmpty) {
    print(errorMessage("No item matching '$keyword' was found."));
    return;
  }

  print(
    "\n Found ${matches.length} matching item(s):"
    "\n --------------------------------------------------------- "
    "\n | No. | Item Name        | Quantity | Price |  Subtotal | "
    "\n --------------------------------------------------------- ",
  );

  int number = 1;

  for (int index in matches) {
    String itemNumber = number.toString().padLeft(1);
    String name = itemNames[index].padRight(15);
    String quantity = itemQuantities[index].toString().padLeft(7);
    String price = itemPrices[index].toStringAsFixed(2).padLeft(4);
    String total = (itemQuantities[index] * itemPrices[index])
        .toStringAsFixed(2)
        .padLeft(7);

    print(" | $itemNumber   | $name  | $quantity  | $price | $total   |");

    number++;
  }

  print(" ---------------------------------------------------------\n");
}

// -----------------------------------------------------------------------------

void updateItemName() {
  print(subHeader("UPDATE ITEM - Name"));

  if (itemNames.isEmpty) {
    print(
      errorMessage("Cannot proceed to update item name. Inventory is empty."),
    );
    return;
  }

  stdout.write(" Enter Current Item Name: ");
  String? currentName = stdin.readLineSync();

  if (currentName == null || currentName.trim().isEmpty) {
    print(errorMessage("Current item name cannot be empty."));
    return;
  }

  currentName = currentName.trim();

  int index = findItemIndex(currentName);

  if (index == -1) {
    print(errorMessage("Item '$currentName' was not found."));
    return;
  }

  String newName = "";
  bool validName = false;

  RegExp validNamePattern = RegExp(r'^[a-zA-Z ]+$');

  do {
    stdout.write(" Enter New Item Name: ");
    String? input = stdin.readLineSync();

    if (input == null || input.trim().isEmpty) {
      print(errorMessage("New item name cannot be empty. Please try again."));
    } else if (!validNamePattern.hasMatch(input.trim())) {
      print(
        errorMessage(
          "Item name can only contain letters and spaces. Please try again.",
        ),
      );
    } else if (itemNames.any(
      (name) => name.toLowerCase() == input.trim().toLowerCase(),
    )) {
      print(
        errorMessage(
          "Item name already exists. Please enter a different name.",
        ),
      );
    } else {
      newName = input.trim();
      validName = true;

      itemNames[index] = newName;

      print(successMessage("Item name updated successfully!"));
    }
  } while (!validName);
}

// -----------------------------------------------------------------------------

void updateItemQuantity() {
  print(subHeader("UPDATE ITEM - Quantity"));

  if (itemNames.isEmpty) {
    print(
      errorMessage(
        "Cannot proceed to update item quantity. Inventory is empty.",
      ),
    );
    return;
  }

  stdout.write(" Enter Item Name: ");
  String? itemName = stdin.readLineSync();

  if (itemName == null || itemName.trim().isEmpty) {
    print(errorMessage("Item name cannot be empty."));
    return;
  }

  itemName = itemName.trim();

  int index = findItemIndex(itemName);

  if (index == -1) {
    print(errorMessage("Item '$itemName' was not found."));
    return;
  }

  int? newQuantity;

  do {
    stdout.write(" Enter New Quantity: ");
    String? input = stdin.readLineSync();

    newQuantity = int.tryParse(input ?? "");

    if (newQuantity == null) {
      print(errorMessage("Invalid quantity. Please enter a whole number."));
    } else if (newQuantity < 0) {
      print(
        errorMessage("Quantity cannot be negative. Please enter 0 or greater."),
      );
    }
  } while (newQuantity == null || newQuantity < 0);

  itemQuantities[index] = newQuantity;

  print(successMessage("Item quantity updated successfully!"));
}

// -----------------------------------------------------------------------------

void deleteItem() {
  print(subHeader("DELETE ITEM"));

  if (itemNames.isEmpty) {
    print(
      errorMessage("Cannot proceed to delete an item. Inventory is empty."),
    );
    return;
  }

  stdout.write(" Enter Item Name: ");
  String? itemName = stdin.readLineSync();

  if (itemName == null || itemName.trim().isEmpty) {
    print(errorMessage("Item name cannot be empty."));
    return;
  }

  int index = findItemIndex(itemName);

  if (index == -1) {
    print(errorMessage("Item '$itemName' was not found."));
    return;
  }

  String confirm = "";
  bool validConfirmation = false;

  do {
    stdout.write(
      "\n [CONFIRMATION]: "
      "\n Are you sure you want to delete '${itemNames[index]}'? (Y/N): ",
    );

    String? input = stdin.readLineSync();

    if (input == null || input.trim().isEmpty) {
      print(errorMessage("Confirmation cannot be empty. Please enter Y or N."));
      continue;
    }

    confirm = input.trim().toUpperCase();

    if (confirm != "Y" && confirm != "N") {
      print(errorMessage("Invalid input. Please enter Y or N."));
      continue;
    }

    validConfirmation = true;
  } while (!validConfirmation);

  if (confirm == "Y") {
    itemNames.removeAt(index);
    itemQuantities.removeAt(index);
    itemPrices.removeAt(index);

    print(successMessage("Item deleted successfully!"));
  } else {
    print("\n [CANCEL]: Item deletion has been cancelled.\n");
  }
}

// -----------------------------------------------------------------------------

void inventorySummary() {
  print(
    "\n ========================================="
    "\n            INVENTORY SUMMARY             "
    "\n -----------------------------------------",
  );

  if (itemNames.isEmpty) {
    print(errorMessage("Inventory is empty. Add items to view the summary."));
    return;
  }

  int totalItems = itemNames.length;
  int totalQuantity = 0;
  double totalValue = 0;

  int highest = itemQuantities[0];
  int lowest = itemQuantities[0];

  String highestItem = itemNames[0];
  String lowestItem = itemNames[0];

  for (int index = 0; index < itemNames.length; index++) {
    totalQuantity += itemQuantities[index];

    totalValue += itemQuantities[index] * itemPrices[index];

    if (itemQuantities[index] > highest) {
      highest = itemQuantities[index];
      highestItem = itemNames[index];
    }

    if (itemQuantities[index] < lowest) {
      lowest = itemQuantities[index];
      lowestItem = itemNames[index];
    }
  }

  double averageQuantity = totalQuantity / totalItems;

  print(
    "\n GENERAL INFORMATION                      "
    "\n -----------------------------------------"
    "\n Total Different Items : $totalItems      "
    "\n Total Quantity        : $totalQuantity   "
    "\n Average Quantity      : ${averageQuantity.toStringAsFixed(2)} "
    "\n Total Inventory Value : ${totalValue.toStringAsFixed(2)}      "
    "\n -----------------------------------------",
  );

  print(
    "\n QUANTITY HIGHLIGHTS                            "
    "\n -----------------------------------------      "
    "\n Highest Stocked Item  : $highestItem ($highest)"
    "\n Lowest Stocked Item   : $lowestItem ($lowest)  "
    "\n -----------------------------------------      "
    "\n =========================================\n    ",
  );
}

// REUSABLE FUNCTIONS ----------------------------------------------------------

int findItemIndex(String itemName) {
  for (int index = 0; index < itemNames.length; index++) {
    if (itemNames[index].toLowerCase() == itemName.toLowerCase()) {
      return index;
    }
  }

  return -1;
}

String subHeader(String message) {
  return "\n ----------------------------------------- "
      "\n $message                                  "
      "\n ----------------------------------------- ";
}

String successMessage(String message) {
  return "\n [SUCCESS]: $message \n";
}

String errorMessage(String message) {
  return "\n [ERROR]: $message \n";
}

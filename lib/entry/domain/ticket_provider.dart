import 'package:flutter/cupertino.dart';
import 'package:newappmytectra/entry/models/user.dart';
import 'package:newappmytectra/utils/dbhelper.dart';

class TicketProvider with ChangeNotifier{
  User? currentUser;
  bool isLoading = true;

  setIsLoadingFalse(){
    isLoading = false;
    notifyListeners();
  }


  // Function to find user by phone number
  void findUserByPhone(String phoneNumber) {
    isLoading = true;
    final phone = phoneNumber;
    final foundUser = DBHelper.getUsers().firstWhere(
          (user) => user.phoneNumber == phone,
      orElse: () => User(name: "", address: "", phoneNumber: phoneNumber), // Returns null if no user is found
    );
    print("uuuxxx===>${foundUser?.phoneNumber}");

    if (foundUser != null) {
        currentUser = foundUser;
    } else {
        currentUser = null;
    }
    isLoading = false;
    notifyListeners();
  }

}
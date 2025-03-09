import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newappmytectra/entry/domain/ticket_provider.dart';
import 'package:newappmytectra/entry/models/ticket.dart';
import 'package:newappmytectra/entry/models/user.dart';
import 'package:newappmytectra/utils/dbhelper.dart';
import 'package:newappmytectra/utils/service_locator.dart';
import 'package:provider/provider.dart';


class CreateTicketScreen extends StatefulWidget {
  @override
  _CreateTicketScreenState createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ticketTitleController = TextEditingController();
  final TextEditingController ticketDescriptionController = TextEditingController();
  final TextEditingController serviceEstPrice = TextEditingController();
  final TextEditingController serviceEstDays = TextEditingController();
  TicketProvider ticketProvider = serviceLocator.get<TicketProvider>();


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool underWarranty = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      ticketProvider.setIsLoadingFalse();
    });
  }



  // Function to create a new ticket
  void _createTicket() async{
    if(_formKey.currentState!.validate()) {
      if (ticketProvider.currentUser != null) {
        final ticket = Ticket(
            ticketNumber: 'TICKET-${DateTime
                .now()
                .millisecondsSinceEpoch}',
            title: ticketTitleController.text,
            description: ticketDescriptionController.text,
            status: 'Open',
            userPhone: ticketProvider.currentUser!.phoneNumber,
            createdTime: DateTime.now(),
            updatedTime: DateTime.now(),
            serviceEstimationDays: int.parse(serviceEstDays.text),
            serviceEstimationPrice: double.parse(serviceEstPrice.text.trim().isEmpty?"0":serviceEstPrice.text),
            underWarranty: underWarranty
        );

        DBHelper.addTicket(ticket);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Ticket created successfully!")),
        );
      } else {
        final user = User(name: nameController.text,
            address: addressController.text,
            phoneNumber: phoneController.text);
        bool isUserPresent =  DBHelper.checkIfUserPresent(phoneController.text);
        if(isUserPresent){
          ticketProvider.currentUser = user;
        }
        else{
          await DBHelper.addUser(user);
        }
        ticketProvider.currentUser = user;
        _createTicket();
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid Details, service entry failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Service Entry')),
      resizeToAvoidBottomInset: true,
      body: Consumer<TicketProvider>(
        builder: (context, tProvider, child) {
          return Center(
            child: ticketProvider.isLoading? CircularProgressIndicator(
              // color: Colors.blue,
            ):
            Center(
              child: Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),

                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      // Phone number input
                      TextFormField(
                        controller: phoneController,
                        validator: (val){
                          return checkValidation(phoneController.text, "Phone number required");
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(labelText: 'Phone Number'),
                      ),
                      SizedBox(height: 16,),
                      ElevatedButton(
                        onPressed: (){
                          tProvider.findUserByPhone(phoneController.text);
                          if(tProvider.currentUser==null){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("User not found with this phone number")),
                            );
                          }
                        },
                        child: Text('Find User'),
                      ),
                      SizedBox(height: 16,),
                      // User fields (auto-populated)
                      TextFormField(
                        controller: nameController,
                        validator: (val){
                          return checkValidation(nameController.text, "Name required");
                        },
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      SizedBox(height: 8,),
                      TextFormField(
                        controller: addressController,
                        validator: (val){
                          return checkValidation(addressController.text, "Address required");
                        },
                        decoration: InputDecoration(labelText: 'Address'),
                      ),
                      SizedBox(height: 8,),
                      // Ticket title and description
                      TextFormField(
                        controller: ticketTitleController,
                        decoration: InputDecoration(labelText: 'Model Number'),
                        validator: (val){
                          return checkValidation(ticketTitleController.text, "Issue title required");
                        },
                      ),
                      SizedBox(height: 8,),
                      TextFormField(
                        controller: ticketDescriptionController,
                        maxLines: 5,
                        validator: (val){
                          return checkValidation(ticketDescriptionController.text, "Issue title required");
                        },
                        decoration: InputDecoration(labelText: 'Issue Description required'),
                      ),
                      SizedBox(height: 8,),
                      TextFormField(
                        controller: serviceEstPrice,
                        // validator: (val){
                        //   return checkPriceValidation(serviceEstPrice.text, "Invalid Price");
                        // },
                        decoration: InputDecoration(labelText: 'Service Estimation Price'),
                      ),
                      SizedBox(height: 8,),
                      TextFormField(
                        controller: serviceEstDays,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (val){
                          return checkDaysValidation(serviceEstDays.text, "Invalid Days");
                        },
                        decoration: InputDecoration(labelText: 'Service estimation days'),
                      ),
                      SizedBox(height: 8,),
                      SwitchListTile(value: underWarranty, onChanged: (val){
                        setState(() {
                          underWarranty = !underWarranty;
                        });
                      },
                        title: Text("Under Warranty?"),
                      ),
                      SizedBox(height: 16,),
                      ElevatedButton(
                        onPressed: _createTicket,
                        child: Text('Create Ticket'),
                      ),
                      SizedBox(height: 16,),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  String? checkValidation(String? val, String s) {
    if(val!.isEmpty){
      return s;
    }
    return null;
  }

  String? checkPriceValidation(String? val, String s) {
    if(val!.isEmpty){
      return s;
    }
    else if(!RegExp(r'^[+]?\d+(\.\d+)?$').hasMatch(val)){
      return s;
    }
    return null;
  }

  String? checkDaysValidation(String? val, String s) {
    if(val!.isEmpty){
      return s;
    }
    else if(!RegExp(r'^[1-9]\d*$').hasMatch(val)){
      return s;
    }
    return null;
  }
}
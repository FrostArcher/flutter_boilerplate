import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:newappmytectra/entry/domain/ticket_provider.dart';
import 'package:newappmytectra/entry/models/ticket.dart';
import 'package:newappmytectra/entry/models/user.dart';
import 'package:newappmytectra/utils/dbhelper.dart';
import 'package:newappmytectra/utils/service_locator.dart';
import 'package:provider/provider.dart';


class TicketListScreen extends StatefulWidget {

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  List<Ticket> tickets=[];
  List<User> users = [];
  final String dateFormat = "dd/MM/yyyy hh:mm:ss a";
  final List<String> statusOptions = ["Open", "In Progress", "Delivered", "Cancelled"];
  TicketProvider ticketProvider = serviceLocator.get<TicketProvider>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      ticketProvider.getTicketsViewData();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Service Entries')),
      body: Consumer<TicketProvider>(
        builder: (context, tProvider, child) {
          if(tProvider.isLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView.builder(
            itemCount: ticketProvider.createdTickets.length,
            itemBuilder: (context, index) {
              final ticket = ticketProvider.createdTickets[index];
              final user = ticketProvider.createdUsers.firstWhere((element)=> element.phoneNumber == ticket.userPhone);
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text(ticket.ticketNumber,style: theme.textTheme.titleSmall,)),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            value: ticket.status,
                            decoration: InputDecoration.collapsed(hintText: ""),
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String? newValue) {
                             ticketProvider.updateTicket(ticket, newValue);
                            },
                            items: statusOptions.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600,color: theme.colorScheme.secondary),),
                              );
                            }).toList(),
                          ),
                        ),
                        // Text("Status - ${ticket.status}",style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),)
                      ],
                    ),
                    Text("Issue - ${ticket.title}", style:  theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),),
                    Text("Issue Description ${ticket.description}", style:  theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,color: Colors.black87), ),
                    Text("Created At - ${DateFormat(dateFormat).format(ticket.createdTime)}", style:  theme.textTheme.bodySmall),
                    Text("Updated At - ${DateFormat(dateFormat).format(ticket.updatedTime)}", style:  theme.textTheme.bodySmall),
                    Text("Customer:- ${user.name}, ${user.phoneNumber}, ${user.address}"),
                    SizedBox(height: 24,),
                    ElevatedButton(onPressed: () async{
                      // await generateInvoice(ticket);
                      await ticketProvider.generateInvoice(ticket);
                    }, child: Text("Generate Ticket"))
                  ],
                ),
              );
            },
          );
        }
      ),
    );
  }
}
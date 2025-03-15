import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:newappmytectra/entry/models/ticket.dart';
import 'package:newappmytectra/entry/models/user.dart';
import 'package:newappmytectra/utils/dbhelper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;
class TicketProvider with ChangeNotifier{
  User? currentUser;
  bool isLoading = true;
  List<Ticket> createdTickets = [];
  List<User> createdUsers = [];

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

  Future<void> generateInvoice(Ticket ticket) async {
    // Open Hive box to fetch user data based on the phone number in the ticket
    List<User> users = DBHelper.getUsers();
    User? user = users.firstWhere((u) => u.phoneNumber == ticket.userPhone);

    if (user == null) {
      print('User not found');
      return;
    }

    // Create a PDF document
    final pdf = pw.Document();

    // Add a page to the PDF
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header: Jayshree Enterprises
            pw.Text(
              'Ticketing System',
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromHex('#000000'),
              ),
            ),
            pw.SizedBox(height: 20),

            // User Data Section
            pw.Text('Customer Information:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text('Name: ${user.name}'),
            pw.Text('Address: ${user.address}'),
            pw.Text('Phone Number: ${user.phoneNumber}'),
            pw.SizedBox(height: 10),

            // Ticket Data Section
            pw.Text('Service Information:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text('Ticket Number: ${ticket.ticketNumber}'),
            pw.Text('Title: ${ticket.title}'),
            pw.Text('Description: ${ticket.description}'),
            pw.Text('Status: ${ticket.status}'),
            pw.Text('Created Time: ${ticket.createdTime}'),
            pw.Text('Updated Time: ${ticket.updatedTime}'),
            pw.Text('Under Warranty: ${ticket.underWarranty==true?"Yes":"No"}'),
            pw.Text('Service Estimation Price: Rs. ${ticket.serviceEstimationPrice==0?"............":ticket.serviceEstimationPrice}'),
            pw.Text('Service Estimation Days: ${ticket.serviceEstimationDays} days'),
          ],
        );
      },
    ));

    // Save the PDF file locally
    // final outputDir = await getApplicationDocumentsDirectory();
    // final outputFile = File('${outputDir.path}/invoice_${ticket.ticketNumber}.pdf');
    //
    // await outputFile.writeAsBytes(await pdf.save());
    //
    // await Share.shareXFiles([XFile('${outputFile.path}/${ticket.ticketNumber}.pdf')], text: 'Output pdf');
    final pdfData = await pdf.save();
    if(kIsWeb) {
      final blob = html.Blob([pdfData]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      print("Running on web");

      html.AnchorElement(href: url)
        ..setAttribute('download', 'invoice_${ticket.ticketNumber}.pdf')
        ..click();

      // Cleanup
      html.Url.revokeObjectUrl(url);
    }
    else{
      Directory? downloadsDirectory;
      if (Platform.isAndroid) {
        print("Running on Android");
        downloadsDirectory = await getTemporaryDirectory();
      } else if (Platform.isIOS) {
        downloadsDirectory = await getApplicationDocumentsDirectory();
      } else {
        throw UnsupportedError('Unsupported platform');
      }

      String savePath = "${downloadsDirectory.path}/invoice_${ticket.ticketNumber}.pdf";

      if (savePath == null) {
        print("Unable to get external storage directory.");
        return;
      }

      // Save the Pdf file
      final file = File(savePath);

      // Write the Pdf data to the file
      await file.writeAsBytes(pdfData, flush: true);

      print('Users exported to: $file');
      await Share.shareXFiles([XFile(savePath)], text: 'Check out this file!');
    }

  }

  Future<void> getTickets() async {
    createdTickets = DBHelper.getTickets();
    notifyListeners();
  }
  Future<void> getUsers() async {
    createdUsers = DBHelper.getUsers();
    notifyListeners();
  }
  Future<void> getTicketsViewData() async {
    isLoading = true;
    notifyListeners();
    getTickets();
    getUsers();
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateTicket(Ticket ticket, status) async {
    final box = Hive.box<Ticket>(DBHelper.ticketBoxName);
    int index = box.keyAt(createdTickets.indexOf(ticket));
    ticket.status = status!;
    ticket.updatedTime = DateTime.now();
    DBHelper.updateTicket(index,ticket);
    getTickets();
  }

}
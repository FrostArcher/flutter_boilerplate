import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Ticketing System')),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width * 0.9,
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (_) => CreateTicketScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Create New Service Entry'),
                          SizedBox(width: 10,),
                          Icon(Icons.add_circle_outline)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (_) => TicketListScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('View Service entries'),
                          SizedBox(width: 10,),
                          Icon(Icons.view_agenda_outlined)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // exportTicketsToExcelWeb();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Export Services'),
                          SizedBox(width: 10,),
                          Icon(Icons.share)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // if(kIsWeb) {
                        //   exportUsersToExcelWeb();
                        // }else{
                        //   exportUsersToExcelAndroid();
                        // }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Export Users'),
                          SizedBox(width: 10,),
                          Icon(Icons.share)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // importUsersFromExcelWeb();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Import Users'),
                          SizedBox(width: 10,),
                          Icon(Icons.save_alt)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // if(kIsWeb) {
                        //   importTicketsFromExcelWeb();
                        // }else{
                        //   importTicketsFromExcelAndroid();
                        // }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Import Service History'),
                          SizedBox(width: 10,),
                          Icon(Icons.save_alt)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (_){
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("All your data will be deleted",style: theme.textTheme.displaySmall,),
                                SizedBox(height: 20,),
                                Text("An export of your data will be downloaded and saved to your device",style: theme.textTheme.bodySmall,),
                                SizedBox(height: 20,),
                                ElevatedButton(onPressed: () async {
                                  // await exportTicketsToExcelWeb();
                                  // await exportUsersToExcelWeb();
                                  // await DBHelper.clear();

                                }, child: Text("Clear Data",style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),),style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red),)),
                                SizedBox(height: 40,),
                                ElevatedButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("Cancel")),
                              ],
                            ),
                          );
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Clear Data'),
                          SizedBox(width: 10,),
                          Icon(Icons.delete_outline)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
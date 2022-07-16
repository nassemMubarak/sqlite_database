import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_database/change_notifiers/contact_change_notifier.dart';
import 'package:sqlite_database/models/contact.dart';
import 'package:sqlite_database/screen/update_contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, '/add_contact_screen');
          }, icon: const Icon(Icons.add),),
        ],
      ),
      body: Consumer<ContactChangeNotifier>(
        builder: (
            BuildContext context,
            ContactChangeNotifier value,
            Widget? child,
        ){
          if(value.contacts.isEmpty){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning,
                size: 120,
                ),
                Text('NO DATA',style: TextStyle(color: Colors.grey.shade600,fontSize: 28),textAlign: TextAlign.center,),
              ],
            );
          }
          return ListView.builder(
              itemCount: value.contacts.length,
              itemBuilder: (context, index) {
                Contact contact = value.contacts[index];
                return ListTile(
                  onTap: (){
                    //TODO: CALL
                  },
                  onLongPress: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateContactScreen(contact))),

                  leading: Icon(Icons.contacts),
                  title: Text(contact.name),
                  subtitle: Text(contact.mobile),
                  trailing: IconButton(onPressed: (){
                    deletContact(contact.id,index);
                  }, icon: Icon(Icons.delete)),
                );
              });
        }
    ),);
  }
  Future deletContact(int id,int index)async{
    await Provider.of<ContactChangeNotifier>(context,listen: false).delete(id,index);
  }
}

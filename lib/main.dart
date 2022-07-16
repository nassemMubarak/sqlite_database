import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_database/change_notifiers/contact_change_notifier.dart';
import 'package:sqlite_database/screen/add_contact_screen.dart';
import 'package:sqlite_database/screen/home_screen.dart';
import 'package:sqlite_database/screen/launch_screen.dart';
import 'package:sqlite_database/screen/update_contact_screen.dart';
import 'package:sqlite_database/storage/db_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBProvider().initDatabase();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ContactChangeNotifier>(create:(context)=>ContactChangeNotifier()),
      ],
      builder: (BuildContext context, Widget? child){
      return MaterialApp(
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen':(context)=>LaunchScreen(),
            '/home_screen':(context)=>HomeScreen(),
            '/add_contact_screen':(context)=>AddContactScreen(),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

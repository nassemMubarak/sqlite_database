import 'package:flutter/material.dart';
import 'package:sqlite_database/models/contact.dart';
import 'package:sqlite_database/storage/controller/contact_db_controller.dart';

class ContactChangeNotifier extends ChangeNotifier{
  List<Contact> contacts = [];
  ContactChangeNotifier(){
    read();
  }
  Future<void> read()async{
    contacts =await ContactDbController().read();
    notifyListeners();
  }
  Future<bool> craeate(Contact data) async{
     int id = await ContactDbController().create(data);
     if(id!=0){
       data.id = id;
       contacts.add(data);
       notifyListeners();
     }
       return id!=0;
     }
      Future<bool> delete(int id,int index)async{
          bool de = await ContactDbController().delete(id);
          if(de){
            contacts.removeAt(index);
            notifyListeners();
          }
          return true;
      }
      Future<bool> update(Contact data) async{
          bool update = await ContactDbController().update(data);
          if(update){
          int index =  contacts.indexWhere((contact) => contact.id == data.id);
          contacts[index]=data;
          notifyListeners();
          }
          return update;
      }
}


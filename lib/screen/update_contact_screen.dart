import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_database/change_notifiers/contact_change_notifier.dart';
import 'package:sqlite_database/models/contact.dart';

import '../utiils/helpers.dart';

class UpdateContactScreen extends StatefulWidget {
  final Contact contact;

  UpdateContactScreen(this.contact);

  @override
  State<UpdateContactScreen> createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen>with Helpers {



  late bool _blocked;
  late TextEditingController _nameTextEditingController;
  late TextEditingController _mobileTextEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextEditingController = TextEditingController(text: widget.contact.name);
    _mobileTextEditingController = TextEditingController(text: widget.contact.mobile);
    _blocked = widget.contact.blocked==1;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTextEditingController.dispose();
    _mobileTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Contact'),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        children: [
          const Text(
            'Add new contact',
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _nameTextEditingController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(hintText: 'Name'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _mobileTextEditingController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Mobile'),
          ),
          const SizedBox(height: 10),
          SwitchListTile(
              title: const Text('Blocked'),
              value: _blocked,
              onChanged: (bool value) {
                setState(() {
                  _blocked = value;
                });
              }),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              performSave();
            },
            child: const Text('SAVE'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(0, 50),
            ),
          ),
        ],
      ),
    );
  }

  Future performSave() async {
    if (checkData()) {
      await saveContact();
    }
  }



  bool checkData() {
    if (_nameTextEditingController.text.isNotEmpty &&
        _mobileTextEditingController.text.isNotEmpty) {
      return true;
    }
      showSnackBar(context, 'Enter required data!',error: true);
    return false;
  }
  Future saveContact() async {
    bool inserted =
        await Provider.of<ContactChangeNotifier>(context, listen: false)
            .update(contact);
    if (inserted) {
        showSnackBar(context, 'Contact Created successfully');
        clear();
    } else {
      showSnackBar(context, 'Failed to update a contact! ',error: true);
    }
  }

  Contact get contact {
    Contact contact = widget.contact;
    contact.name = _nameTextEditingController.text;
    contact.mobile = _mobileTextEditingController.text;
    contact.blocked = _blocked ? 1 : 0;
    return contact;
  }
  void clear(){
    _nameTextEditingController.text="";
    _mobileTextEditingController.text="";
    setState((){
      _blocked = false;
    });
  }
}

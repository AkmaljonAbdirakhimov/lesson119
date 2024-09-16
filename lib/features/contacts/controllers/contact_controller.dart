import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/contact.dart';

class ContactController with ChangeNotifier {
  final Box _hiveBox;
  final _contactsKey = "contacts";
  List<Contact> _contacts = <Contact>[];
  ContactController({required Box hiveBox}) : _hiveBox = hiveBox;

  List<Contact> get contacts {
    _contacts = _hiveBox.get(_contactsKey).cast<Contact>();
    return [..._contacts];
  }

  Contact getContactById(int id) {
    final contact = _contacts.firstWhere((c) => c.id == id);
    return contact;
  }

  Future<void> addContact({
    required String fullname,
    required String phone,
  }) async {
    final id = _contacts.length + 1;
    final contact = Contact(
      id: id,
      fullname: fullname,
      phone: phone,
    );
    _contacts.add(contact);

    await _hiveBox.put(_contactsKey, _contacts);
    notifyListeners();
  }

  Future<void> deleteById(int id) async {
    _contacts.removeWhere((c) => c.id == id);
    await _hiveBox.put(_contactsKey, _contacts);
    notifyListeners();
  }
}

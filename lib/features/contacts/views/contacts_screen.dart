import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/contact_controller.dart';
import 'widgets/contact_item.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: [
          IconButton(
            onPressed: () {
              const String fullname = "New Contact 3";
              const String phone = "+998 00 000 00 03";

              context.read<ContactController>().addContact(
                    fullname: fullname,
                    phone: phone,
                  );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<ContactController>(
          builder: (context, contactsController, child) {
        return ListView.builder(
          itemCount: contactsController.contacts.length,
          itemBuilder: (context, index) {
            final contact = contactsController.contacts[index];
            return ContactItem(
              contact: contact,
            );
          },
        );
      }),
    );
  }
}

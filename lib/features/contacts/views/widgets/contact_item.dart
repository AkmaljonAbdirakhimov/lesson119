import 'package:flutter/material.dart';
import 'package:lesson119/features/contacts/controllers/contact_controller.dart';
import 'package:provider/provider.dart';

import '../../models/contact.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  const ContactItem({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.fullname),
      subtitle: Text(contact.phone),
      trailing: IconButton(
        onPressed: () {
          context.read<ContactController>().deleteById(contact.id);
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}

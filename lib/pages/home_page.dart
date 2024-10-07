import 'package:flutter/material.dart';
import 'package:tp1/constant/myColors.dart';
import 'package:tp1/dataBase/database_helper.dart';
import 'package:tp1/model/contact.dart';
import 'package:tp1/pages/edit.dart';
import 'package:tp1/pages/form.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper();
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    List<Contact> dbContacts = await dbHelper.getContacts();
    setState(() {
      contacts = dbContacts;
    });
  }


// Function to launch the dialer with the contact's number
//Future<void> _makePhoneCall(String phoneNumber) async {
//  final Uri phoneUri = Uri(
//    scheme: 'tel',
//    path: phoneNumber,
//  );
//  
//  if (await canLaunchUrl(phoneUri)) {
//    await launchUrl(phoneUri);
//  } else {
//    throw 'Could not launch $phoneUri';
//  }
//}
//
  // Navigate to the form to add a contact
  void _addContact() async {
    final newContact = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddContactForm()),
    );

    if (newContact != null) {
      _loadContacts(); // Re-fetch contacts from the database after adding
    }
  }

  // Navigate to the edit page for the selected contact
  void _editContact(Contact contact) async {
    final updatedContact = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditContactForm(contact: contact)),
    );

    if (updatedContact != null) {
      _loadContacts(); // Re-fetch contacts after editing
    }
  }
Future<bool> _showConfirmationDialog(BuildContext context, Contact contact) async {
  return await showDialog<bool>(
    context: context,
    barrierDismissible: false, // Prevents dismissing by tapping outside
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('Delete Contact'),
        content: Text('Are you sure you want to delete ${contact.name}?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(dialogContext).pop(false); // User canceled deletion
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              Navigator.of(dialogContext).pop(true); // User confirmed deletion
            },
          ),
        ],
      );
    },
  ) ?? false; // Default to false if dialog is dismissed
}

  // Delete the contact from the database and list
  void _deleteContact(Contact contact) async {
    await dbHelper.deleteContact(contact.number); // Delete from the database
    setState(() {
      contacts.remove(contact); // Remove from the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "All Contacts",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: myBlue,
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: myBlue,
        child: Icon(Icons.add), // Button icon
        onPressed: _addContact,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return Dismissible(
              key: Key(contact.id.toString()), // Unique key for each contact
              direction:
                  DismissDirection.startToEnd, // Swipe to the right to delete
              background: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: myGrey, // Background color when swiping
                child: Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                return await _showConfirmationDialog(context, contact);
              },
              onDismissed: (direction) {
                _deleteContact(contact); // Call the delete function
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${contact.name} deleted')),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 1),
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                child: ListTile(
                  leading: CircleAvatar(
  radius: 30, // Set the radius for the circular avatar
  backgroundImage: contact.photoUrl.isNotEmpty
      ? AssetImage(contact.photoUrl)
      : null, // Use the photoUrl if it's available, otherwise null
  child: contact.photoUrl.isEmpty // Show the icon if no photo
      ? Icon(
          Icons.person,
          size: 30,
          color: Colors.white,
        )
      : null, // If photo exists, no child icon needed
),

                  title: Text(
                    contact.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    contact.number,
                    style: TextStyle(color: myGrey),
                  ),
                  trailing: Row(
  mainAxisSize: MainAxisSize.min, // Ensures the row takes minimal space
  children: <Widget>[
    
    IconButton(
      icon: Icon(
        Icons.sms,  // SMS icon
        color: myGrey,
      ),
      onPressed: () => launchUrlString("sms://${contact.number}"), // SMS function with the contact's number
    ),

    IconButton(
      icon: Icon(
        Icons.call,
        color: myGrey,
      ),
      onPressed: () => launchUrlString("tel://${contact.number}"), // Call the function with the contact's number
    ),
  ],
),
                  onTap: () {
                    _editContact(contact); // Navigate to edit page
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

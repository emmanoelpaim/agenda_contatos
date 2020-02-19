import 'dart:io';

import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact _editContact;
  bool _userEdited = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      _editContact = Contact();
    } else {
      _editContact = Contact.fromMap(widget.contact.toMap());

      _nameController.text = _editContact.name;
      _emailController.text = _editContact.email;
      _phoneController.text = _editContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(_editContact.name ?? "Novo Contato"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showContactPage();
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _editContact.img != null
                          ? FileImage(File(_editContact.img))
                          : AssetImage("images/user.png"),
                    )),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
              onChanged: (text) {
                _userEdited = true;
                setState(() {
                  _editContact.name = text;
                });
              },
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) {
                _userEdited = true;
                _editContact.email = text;
              },
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
              onChanged: (text) {
                _userEdited = true;
                _editContact.phone = text;
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showContactPage({Contact contact}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactPage(
                  contact: contact,
                )));
  }
}

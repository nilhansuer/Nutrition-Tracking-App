import 'package:flutter/material.dart';

class MedicalRecord extends StatefulWidget {
  const MedicalRecord({Key? key}) : super(key: key);

  @override
  State<MedicalRecord> createState() => _MedicalRecordState();
}

class _MedicalRecordState extends State<MedicalRecord> {

  final List<String> diseases = [


  ];

  final List<String> allergies = [

  ];


  void _addDisease(String disease) {
    setState(() {
      diseases.add(disease);
    });
  }

  void _addAllergy(String allergy) {
    setState(() {
      allergies.add(allergy);
    });
  }

  void _deleteDisease(int index) {
    setState(() {
      diseases.removeAt(index);
    });
  }

  void _deleteAllergy(int index) {
    setState(() {
      allergies.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diseases and Allergies'),
      ),
      body: ListView(
        children: [
          _buildSection('Diseases', diseases, true),
          _buildSection('Allergies', allergies, false),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              _showAddDialog(true);
            },
            label: Text('Add New Disease'),
            icon: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
          SizedBox(height: 16.0),
          FloatingActionButton.extended(
            onPressed: () {
              _showAddDialog(false);
            },
            label: Text('Add New Allergy'),
            icon: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> items, bool isDisease) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(),
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
              key: Key(item),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  if (isDisease) {
                    _deleteDisease(index);
                  } else {
                    _deleteAllergy(index);
                  }
                });
              },
              child: ListTile(
                title: Text(item),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Perform any action when an item is tapped
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void _showAddDialog(bool isDisease) {
    String title = isDisease ? 'Add New Disease' : 'Add New Allergy';
    String hintText = isDisease ? 'Enter disease name' : 'Enter allergy name';

    showDialog(
      context: context,
      builder: (context) {
        String inputText = '';

        return AlertDialog(
          title: Text(title),
          content: TextField(
            onChanged: (value) {
              inputText = value;
            },
            decoration: InputDecoration(
              hintText: hintText,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (inputText.isNotEmpty) {
                  if (isDisease) {
                    _addDisease(inputText);
                  } else {
                    _addAllergy(inputText);
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
import 'package:flutter/material.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({Key? key}) : super(key: key);

  @override
  _AddPlantPageState createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  final TextEditingController _plantNameController = TextEditingController();
  String defaultPlantType = 'A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _titleSection(),
            _plantNameSection(),
            _plantTypeSection('Plant type'),
            _plantingDateSection(DateTime.now()),
            const Spacer(),
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Add plant')),
          ],
        ),
      ),
    );
  }

  Widget _titleSection() {
    return const Text(
      'Add plant',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _plantNameSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _plantNameController,
        decoration: const InputDecoration(hintText: 'Plant name...'),
      ),
    );
  }

  Widget _plantTypeSection(String type) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Plant type:'),
          DropdownButton<String>(
            value: defaultPlantType,
            items: <String>['A', 'B', 'C']
                .map<DropdownMenuItem<String>>(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (String? value) => setState(() {
              defaultPlantType = value!;
            }),
          ),
        ],
      ),
    );
  }

  Widget _plantingDateSection(DateTime dateTime) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Day of planting: '),
          Text(dateTime.toString()),
        ],
      ),
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

class UpdatePlantPage extends StatefulWidget {
  const UpdatePlantPage({Key? key}) : super(key: key);

  @override
  _UpdatePlantPageState createState() => _UpdatePlantPageState();
}

class _UpdatePlantPageState extends State<UpdatePlantPage> {
  final TextEditingController _plantNameController = TextEditingController();
  String? plantType;
  DateTime? plantingDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _titleSection(),
            _changePlantNameSection(),
            _changePlantTypeSection(['aplines', 'aquatic']),
            _changePlantingDateSection(DateTime.now()),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  // bloc.add(UpdatePlant(
                  //     _plantNameController.value.text,
                  //     plantType ?? state.plantTypes[0].type,
                  //     plantingDate!.millisecondsSinceEpoch));
                },
                child: const Text('Update plant')),
          ],
        ),
      ),
    );
  }

  Widget _titleSection() {
    return const Text(
      'Update plant',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _changePlantNameSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _plantNameController,
        decoration: const InputDecoration(hintText: 'Plant name...'),
      ),
    );
  }

  Widget _changePlantTypeSection(List<String> plantTypes) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Plant type: '),
          DropdownButton<String>(
            value: plantType ?? plantTypes[0],
            items: plantTypes
                .map<DropdownMenuItem<String>>(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (String? value) => setState(() {
              plantType = value!;
            }),
          ),
        ],
      ),
    );
  }

  Widget _changePlantingDateSection(DateTime dateTime) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          plantingDate != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Day of planting: '),
                    Text('${plantingDate!.day}.${plantingDate!.month}'
                        '.${plantingDate!.year}')
                  ],
                )
              : Container(),
          ElevatedButton(
              onPressed: () => _selectDate(), child: const Text('Select date'))
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: plantingDate ?? DateTime.now(),
        firstDate: DateTime(1920),
        lastDate: DateTime.now());

    if (pickedDate != null && pickedDate != plantingDate) {
      setState(() {
        plantingDate = pickedDate;
      });
    }
  }
}

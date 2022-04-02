import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/database/plant_type/plant_type_entity.dart';
import 'package:garden/feature/add_plant/bloc/add_plant_bloc.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({Key? key}) : super(key: key);

  @override
  _AddPlantPageState createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  final TextEditingController _plantNameController = TextEditingController();
  String? plantType;
  DateTime? plantingDate;
  late AddPlantBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AddPlantBloc>(context);
    bloc.add(InitAddPlant());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AddPlantBloc, AddPlantState>(
        listener: (context, state) {
          if (state is PlantSaved) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AddPlantLoaded) {
            return Center(
              child: Column(
                children: [
                  _titleSection(),
                  _plantNameSection(),
                  _plantTypeSection(state.plantTypes),
                  _plantingDateSection(DateTime.now()),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        bloc.add(SavePlant(
                            _plantNameController.value.text,
                            plantType ?? state.plantTypes[0].type,
                            plantingDate!.millisecondsSinceEpoch));
                      },
                      child: const Text('Add plant')),
                ],
              ),
            );
          }
          return Container();
        },
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

  Widget _plantTypeSection(List<PlantType> plantTypes) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Plant type: '),
          DropdownButton<String>(
            value: plantType ?? plantTypes[0].type,
            items: plantTypes
                .map<DropdownMenuItem<String>>(
                  (e) => DropdownMenuItem<String>(
                    value: e.type,
                    child: Text(e.type),
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

  Widget _plantingDateSection(DateTime dateTime) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          plantingDate != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Day of planting: '),
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

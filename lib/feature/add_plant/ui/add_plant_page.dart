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
  String? defaultPlantType;
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
      body: BlocBuilder<AddPlantBloc, AddPlantState>(
        builder: (context, state) {
          if (state is! AddPlantLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Column(
              children: [
                _titleSection(),
                _plantNameSection(),
                _plantTypeSection(state.plantTypes),
                _plantingDateSection(DateTime.now()),
                const Spacer(),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Add plant')),
              ],
            ),
          );
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
            value: defaultPlantType ?? plantTypes[0].type,
            items: plantTypes
                .map<DropdownMenuItem<String>>(
                  (e) => DropdownMenuItem<String>(
                    value: e.type,
                    child: Text(e.type),
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

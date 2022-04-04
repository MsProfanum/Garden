// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:garden/database/plant/plant_entity.dart';
import 'package:garden/database/plant_type/plant_type_entity.dart';
import 'package:garden/feature/update_plant/bloc/update_plant_bloc.dart';

class UpdatePlantPage extends StatefulWidget {
  Plant plant;

  UpdatePlantPage(this.plant, {Key? key}) : super(key: key);

  @override
  _UpdatePlantPageState createState() => _UpdatePlantPageState();
}

class _UpdatePlantPageState extends State<UpdatePlantPage> {
  late TextEditingController _plantNameController;
  late String plantType;
  late DateTime plantingDate;
  late UpdatePlantBloc bloc;

  @override
  void initState() {
    super.initState();

    _plantNameController = TextEditingController(text: widget.plant.name);
    plantType = widget.plant.type;
    plantingDate =
        DateTime.fromMillisecondsSinceEpoch(widget.plant.plantingDate);
    bloc = BlocProvider.of<UpdatePlantBloc>(context);
    bloc.add(InitUpdatePlant());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdatePlantBloc, UpdatePlantState>(
      listener: (context, state) {
        if (state is UpdatedPlant) {
          Navigator.pop(context, 'Plant updated');
        }
        if (state is DeletedPlant) {
          Navigator.pop(context, 'Plant deleted');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: state is UpdatePlantLoaded
                ? Column(
                    children: [
                      _titleSection(),
                      _changePlantNameSection(),
                      _changePlantTypeSection(state.plantTypes),
                      _changePlantingDateSection(DateTime.now()),
                      const Spacer(),
                      _buttonsSection(),
                    ],
                  )
                : const CircularProgressIndicator(),
          ),
        );
      },
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
      ),
    );
  }

  Widget _changePlantTypeSection(List<PlantType> plantTypes) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Plant type: '),
          DropdownButton<String>(
            value: plantType,
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

  Widget _changePlantingDateSection(DateTime dateTime) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Day of planting: '),
              Text('${plantingDate.day}.${plantingDate.month}'
                  '.${plantingDate.year}')
            ],
          ),
          ElevatedButton(
              onPressed: () => _selectDate(), child: const Text('Change date'))
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: plantingDate,
        firstDate: DateTime(1920),
        lastDate: DateTime.now());

    if (pickedDate != null && pickedDate != plantingDate) {
      setState(() {
        plantingDate = pickedDate;
      });
    }
  }

  Widget _buttonsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () {
              bloc.add(DeletePlant(widget.plant));
            },
            child: const Text('Delete the plant')),
        ElevatedButton(
            onPressed: () {
              bloc.add(UpdatePlant(
                  widget.plant.id,
                  _plantNameController.value.text,
                  plantType,
                  plantingDate.millisecondsSinceEpoch));
            },
            child: const Text('Update plant'))
      ],
    );
  }
}

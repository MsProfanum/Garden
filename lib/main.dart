import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/database/datasource.dart';
import 'package:garden/feature/add_plant/bloc/add_plant_bloc.dart';
import 'package:garden/feature/home/ui/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DataSource dataSource = await DataSource.newInstance();

  runApp(MultiBlocProvider(providers: [
    BlocProvider<AddPlantBloc>(create: (context) => AddPlantBloc(dataSource))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Garden',
      home: HomePage(),
    );
  }
}

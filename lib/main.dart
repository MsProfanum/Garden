// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:garden/database/datasource.dart';
import 'package:garden/feature/add_plant/bloc/add_plant_bloc.dart';
import 'package:garden/feature/home/bloc/home_bloc.dart';
import 'package:garden/feature/home/ui/home_page.dart';
import 'package:garden/feature/update_plant/bloc/update_plant_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DataSource dataSource = await DataSource.newInstance();

  runApp(MultiBlocProvider(providers: [
    BlocProvider<AddPlantBloc>(create: (context) => AddPlantBloc(dataSource)),
    BlocProvider<UpdatePlantBloc>(
        create: (context) => UpdatePlantBloc(dataSource)),
    BlocProvider<HomeBloc>(create: (context) => HomeBloc(dataSource))
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

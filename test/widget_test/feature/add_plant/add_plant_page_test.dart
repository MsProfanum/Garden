import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garden/database/plant_type/plant_type_entity.dart';
import 'package:garden/feature/add_plant/bloc/add_plant_bloc.dart';
import 'package:garden/feature/add_plant/ui/add_plant_page.dart';
import 'package:mocktail/mocktail.dart';

class MockAddPlantBloc extends MockBloc<AddPlantEvent, AddPlantState>
    implements AddPlantBloc {}

class HomeStateFake extends Fake implements AddPlantState {}

class HomeEventFake extends Fake implements AddPlantEvent {}

void main() {
  late AddPlantBloc bloc;

  setUpAll(() {
    bloc = MockAddPlantBloc();
    registerFallbackValue(HomeStateFake());
    registerFallbackValue(HomeEventFake());
    when(() => bloc.state)
        .thenReturn(AddPlantLoaded([PlantType(0, 'aquatic')]));
  });

  testWidgets('Add plant page date time does not show if is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(BlocProvider.value(
      value: bloc,
      child: const MaterialApp(
        home: AddPlantPage(),
      ),
    ));

    expect(find.text('Day of planting: '), findsNothing);
  });

  testWidgets('Add plant page date time shows if not null',
      (WidgetTester tester) async {
    await tester.pumpWidget(BlocProvider.value(
      value: bloc,
      child: const MaterialApp(
        home: AddPlantPage(),
      ),
    ));

    await tester.tap(find.byKey(const Key('pickingDateButton')));
    await tester.pump();
    await tester.tap(find.text('OK'));
    await tester.pump();

    expect(find.text('Day of planting: '), findsOneWidget);
  });
}

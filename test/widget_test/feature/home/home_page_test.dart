import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garden/database/plant/plant_entity.dart';
import 'package:garden/feature/home/bloc/home_bloc.dart';
import 'package:garden/feature/home/ui/home_page.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class HomeStateFake extends Fake implements HomeState {}

class HomeEventFake extends Fake implements HomeEvent {}

void main() {
  late HomeBloc bloc;

  setUpAll(() {
    bloc = MockHomeBloc();
    registerFallbackValue(HomeStateFake());
    registerFallbackValue(HomeEventFake());
  });

  testWidgets('Home Page plant list returns text message on error state',
      (WidgetTester tester) async {
    when(() => bloc.state).thenReturn(Error());
    await tester.pumpWidget(BlocProvider.value(
      value: bloc,
      child: const MaterialApp(
        home: HomePage(),
      ),
    ));

    expect(find.text('Could not fetch items'), findsOneWidget);
  });

  testWidgets('Home Page plant list returns text message on empty list',
      (WidgetTester tester) async {
    when(() => bloc.state).thenReturn(HomeLoaded(plants: [], isLastPage: true));
    await tester.pumpWidget(BlocProvider.value(
      value: bloc,
      child: const MaterialApp(
        home: HomePage(),
      ),
    ));

    expect(find.text('No items'), findsOneWidget);
    expect(find.text('There are no items saved'), findsOneWidget);
  });

  testWidgets('Home Page plant list returns plants if there are any',
      (WidgetTester tester) async {
    when(() => bloc.state).thenReturn(
        HomeLoaded(plants: [Plant(0, 'Aloe', 'bulb', 200)], isLastPage: true));
    await tester.pumpWidget(BlocProvider.value(
      value: bloc,
      child: const MaterialApp(
        home: HomePage(),
      ),
    ));

    expect(find.text('Aloe'), findsOneWidget);
    expect(find.text('bulb'), findsOneWidget);
  });
}

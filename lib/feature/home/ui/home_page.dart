import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/feature/add_plant/ui/add_plant_page.dart';
import 'package:garden/feature/home/bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  late HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<HomeBloc>(context);
    bloc.add(InitHome());
    _controller.addListener(() {
      bloc.add(Filter(_controller.value.text));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 32.0),
                child: Column(
                  children: [_titleSection(), _searchBar(), _plantList(state)],
                ),
              ),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          int? result = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddPlantPage()));
          if (result == 1) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Plant saved!')));
          }
        },
        label: Row(
          children: const [
            Icon(
              Icons.add,
            ),
            SizedBox(width: 8.0),
            Text('Add plant')
          ],
        ),
      ),
    );
  }

  Widget _titleSection() {
    return const Center(
      child: Text(
        'Garden',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _searchBar() {
    return AnimSearchBar(
      width: MediaQuery.of(context).size.width,
      textController: _controller,
      onSuffixTap: () => setState(
        () {
          _controller.clear();
        },
      ),
    );
  }

  Widget _plantList(HomeState state) {
    if (state is! HomeLoaded) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: ListView.builder(
        itemCount: state.plants.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(state.plants[index].name),
          leading: Text(state.plants[index].type),
        ),
      ),
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:garden/feature/add_plant/ui/add_plant_page.dart';
import 'package:garden/feature/home/bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      bloc.add(Filter(_controller.value.text));
    });

    bloc = BlocProvider.of<HomeBloc>(context);
    bloc.add(InitHome());
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
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
              child: Column(
                children: [_titleSection(), _searchBar(), _plantList(state)],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          int? result = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddPlantPage()));
          if (result == 1) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Plant saved!')));
            bloc.add(InitHome());
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
    if (state is Error) {
      return Center(
        child: Column(
          children: [Text('Could not fetch items')],
        ),
      );
    }
    if (state is HomeLoaded) {
      if (state.plants.isEmpty) {
        return Center(
          child: Column(
            children: const [
              Text(
                'No items',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(
                'There are no items saved',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      }
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: ListView.builder(
                controller: _scrollController,
                itemCount: state.isLastPage
                    ? state.plants.length
                    : state.plants.length + 1,
                itemBuilder: (context, index) => index >= state.plants.length
                    ? const ListTile(
                        title: Center(child: CircularProgressIndicator()),
                      )
                    : ListTile(
                        tileColor: Colors.red,
                        title: Text(state.plants[index].name),
                        leading: Text(state.plants[index].type),
                      ))),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      bloc.add(Paginate());
    }

    return false;
  }
}

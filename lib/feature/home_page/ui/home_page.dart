import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:garden/feature/add_plant/ui/add_plant_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            children: [_titleSection(), _searchBar(), _plantList()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddPlantPage())),
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

  Widget _plantList() {
    return Container();
  }
}

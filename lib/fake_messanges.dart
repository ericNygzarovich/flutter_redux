import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:work_with_rest_api/redux/store.dart';

class FakeMessangesScreen extends StatelessWidget {
  const FakeMessangesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[600],
        title: const Text('Fake Messanges'),
      ),
      body: Center(
        child: StoreConnector<AppStorage, List<Messanges>>(
          converter: (store) => store.state.fakeMessanges,
          builder: (context, vm) => vm.isEmpty
              ? CircularProgressIndicator(color: Colors.pink[600])
              : ListView.builder(
                  itemCount: vm.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Messang(
                      title: vm[index].title,
                      body: vm[index].body,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class Messang extends StatelessWidget {
  final String title;
  final String body;

  const Messang({
    super.key,
    required this.body,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.pink[600],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              body,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
//import 'package:work_with_rest_api/redux/middleware.dart';
import 'package:work_with_rest_api/redux/reducers.dart';
import 'package:work_with_rest_api/redux/store.dart';
import 'package:work_with_rest_api/redux/thunk_action.dart';

import 'fake_messanges.dart';
import 'redux/action.dart';

void main() {
  final Store<AppStorage> store = Store(
    reducer,
    initialState: AppStorage(
      counter: 5,
      textField: 'INITISHE',
      image: const Icon(Icons.image),
    ),
    // middleware: [loaderMiddleware],
  );

  runApp(
    StoreProvider(
      store: store,
      child: const MaterialApp(
        home: _Counter(),
      ),
    ),
  );
}

class _Counter extends StatelessWidget {
  const _Counter();

  @override
  Widget build(BuildContext context) {
    String newText = '';
    final store = StoreProvider.of<AppStorage>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Redux'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FakeMessangesScreen(),
                ),
              );

              store.dispatch(store.dispatch(getFakeMessanges(store)));
            },
            icon: const Icon(Icons.chevron_right),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            width: 200,
            child: StoreConnector<AppStorage, Widget>(
              converter: (store) => store.state.image,
              builder: (context, vm) => vm,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              store.dispatch(loadImageThunkAction(store));
            },
            icon: const Icon(Icons.image),
            label: const Text('get image'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                newText = value;
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  StoreProvider.of<AppStorage>(context)
                      .dispatch(ResetTextAction());
                },
                child: const Text('resetText'),
              ),
              const SizedBox(width: 100),
              ElevatedButton(
                onPressed: () {
                  StoreProvider.of<AppStorage>(context)
                      .dispatch(SetTextAction(text: newText));
                },
                child: const Text('setText'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          StoreConnector<AppStorage, String>(
            converter: (store) => store.state.textField,
            builder: (context, state) {
              return Text(state.toString());
            },
          ),
          const SizedBox(height: 20),
          StoreConnector<AppStorage, int>(
            converter: (store) => store.state.counter,
            builder: (context, state) => Text(
              state.toString(),
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    StoreProvider.of<AppStorage>(context)
                        .dispatch(DecrementAction());
                  },
                  child: const Icon(Icons.remove),
                ),
                ElevatedButton(
                  onPressed: () {
                    store.dispatch(calcCountThunckAction(store));
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

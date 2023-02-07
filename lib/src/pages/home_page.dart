import 'package:flutter/material.dart';

import '../shared/injector/injector.dart';
import '../shared/services/local_storage/infra/services/local_storage_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final LocalStorageService localStorageService;

  String key = '';
  String value = '';

  String searchResult = '';

  void changeKey(String key) => setState(() => this.key = key);
  void changeValue(String value) => setState(() => this.value = value);
  void changeSearchResult(String searchResult) => setState(() => this.searchResult = searchResult);

  Future<void> searchByKey() async {
    final response = await localStorageService.read(key);

    if (response == null || response == '') {
      changeSearchResult('Not found');
      return;
    }

    changeSearchResult(response.toString());
  }

  Future<void> addValue() async {
    final response = await localStorageService.write(key, value);

    if (response == false) {
      changeSearchResult('');
      return;
    }

    await searchByKey();
  }

  Future<void> deleteAll() async {
    final response = await localStorageService.deleteAll();

    if (response == false) {
      changeSearchResult('Error');
      return;
    }

    changeSearchResult('');
  }

  Future<void> deleteByKey() async {
    final response = await localStorageService.delete(key);

    if (response == false) {
      changeSearchResult('Error');
      return;
    }

    await searchByKey();
  }

  @override
  void initState() {
    localStorageService = getIt<LocalStorageService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Storage Finder'),
        actions: [
          IconButton(
            tooltip: 'Delete all',
            onPressed: () {
              deleteAll();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                onChanged: changeKey,
                decoration: const InputDecoration(
                  hintText: 'Key',
                ),
              ),
              TextField(
                onChanged: changeValue,
                decoration: const InputDecoration(
                  hintText: 'Value',
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 40.0,
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(Icons.search),
                  label: const Text('Search'),
                  onPressed: key.isEmpty
                      ? null
                      : () {
                          searchByKey();
                        },
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 40.0,
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                  onPressed: key.isEmpty || value.isEmpty
                      ? null
                      : () {
                          addValue();
                        },
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 40.0,
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  onPressed: key.isEmpty
                      ? null
                      : () {
                          deleteByKey();
                        },
                ),
              ),
              if (searchResult.isNotEmpty) ...{
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Result:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(searchResult),
                    ],
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}

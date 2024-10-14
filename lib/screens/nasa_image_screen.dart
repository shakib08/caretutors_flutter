import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/api_provider.dart';
import '../providers/date_provider.dart';

class NasaImageScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider); 

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('NASA Image', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (selectedDate != null)
            ref.watch(nasaImageProvider(selectedDate.toIso8601String().split('T')[0])).when(
              data: (data) => Image.network(data.url ?? '', fit: BoxFit.cover),
              loading: () => CircularProgressIndicator(),
              error: (err, _) => Text('Error: $err'),
            ),
          Spacer(),
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectDate(context, ref);
                    },
                    child: Text(
                      selectedDate != null
                          ? "Selected: ${selectedDate.toLocal()}".split(' ')[0]
                          : 'Select Date',
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: selectedDate != null
                        ? () {}: null, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber, 
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white), 
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _selectDate(BuildContext context, WidgetRef ref) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1995),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      ref.read(selectedDateProvider.notifier).state = picked;
    }
  }
}

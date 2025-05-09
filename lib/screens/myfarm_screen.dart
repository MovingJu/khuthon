import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/task_rules.dart'; // For CropData and CropDataBase

class MyFarmScreen extends StatefulWidget {
  const MyFarmScreen({Key? key}) : super(key: key);

  @override
  _MyFarmScreenState createState() => _MyFarmScreenState();
}

class _MyFarmScreenState extends State<MyFarmScreen> {
  late final Box<CropData> cropBox;

  @override
  void initState() {
    super.initState();
    // Ensure the 'crops' box is open before using
    cropBox = Hive.box<CropData>('crops');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Farm'),
      ),
      body: ValueListenableBuilder<Box<CropData>>(
        valueListenable: cropBox.listenable(),
        builder: (context, box, _) {
          final crops = box.values.toList();
          if (crops.isEmpty) {
            return const Center(
              child: Text('No crops added yet.'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: crops.length,
            itemBuilder: (context, index) {
              final crop = crops[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: Text(
                    crop.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Water Cycle: ${crop.waterperiod}'),
                        Text('Light Needs: ${crop.sunneed}'),
                        Text('Description: ${crop.description}'),
                        if (crop.difficulty != null) Text('Difficulty: ${crop.difficulty}'),
                        if (crop.info != null) Text('Info: ${crop.info}'),
                        if (crop.indoorfriendly != null) Text('Indoor-friendly: ${crop.indoorfriendly}'),
                        if (crop.sowingdate != null)
                          Text('Sowing Date: ${crop.sowingdate!.toLocal().toIso8601String().split('T').first}'),
                        if (crop.harvestdate != null)
                          Text('Harvest Date: ${crop.harvestdate!.toLocal().toIso8601String().split('T').first}'),
                      ],
                    ),
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      // Delete this crop
                      cropBox.deleteAt(index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to a screen to add a new crop or invoke parsing logic
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

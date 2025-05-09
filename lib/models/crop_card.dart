import 'package:flutter/material.dart';
import '../data/task_rules.dart';

/// A reusable card widget to display a single CropData entry.
class CropCard extends StatelessWidget {
  final CropData crop;
  final VoidCallback? onDelete;

  const CropCard({
    Key? key,
    required this.crop,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        trailing: onDelete != null
            ? IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: onDelete,
              )
            : null,
      ),
    );
  }
}

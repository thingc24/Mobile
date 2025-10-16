import 'package:flutter/material.dart';
import 'components_data.dart';
import 'component_detail.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UI Components List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: uiComponents.length,
        itemBuilder: (context, index) {
          final component = uiComponents[index];
          return Card(
            color: Colors.blue.shade50,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(component['title'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(component['subtitle']),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ComponentDetail(component: component),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
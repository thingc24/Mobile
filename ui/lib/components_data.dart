import 'package:flutter/material.dart';

final List<Map<String, dynamic>> uiComponents = [
  {
    'title': 'Text',
    'subtitle': 'Displays styled text',
    'widget': Center(
      child: Text.rich(
        TextSpan(
          text: 'The ',
          style: TextStyle(fontSize: 24),
          children: [
            TextSpan(text: 'quick ', style: TextStyle(decoration: TextDecoration.lineThrough)),
            TextSpan(text: 'Brown ', style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
            TextSpan(text: 'fox jumps '),
            TextSpan(text: 'over ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: 'the '),
            TextSpan(text: 'lazy dog.', style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    ),
  },
  {
    'title': 'Image',
    'subtitle': 'Displays an image',
    'widget': ListView(
        children: [
          Image.asset(
            'assets/images/image1.png',
          ),
          Text(
            'In app',
            style: TextStyle(fontSize: 24, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Image.network(
            'https://s.cmx-cdn.com/giaothongvantaitphcm.edu.vn/wp-content/uploads/2024/06/ky-niem-36-nam-thanh-lap-truong-dai-hoc-giao-thong-van-tai-tphcm-560px.jpg',
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, size: 50, color: Colors.red);
            },
          ),
          Text(
            'From network',
            style: TextStyle(fontSize: 24, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ]
    ),
  },

  {
    'title': 'TextField',
    'subtitle': 'Input field with live updates',
    'widget': Padding(
      padding: const EdgeInsets.all(16.0),
      child: Builder(
        builder: (context) {
          final TextEditingController controller = TextEditingController();
          final List<String> textLines = [];

          return StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Nhập thông tin',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        textLines.add(value.trim());
                        controller.clear();
                        setState(() {}); // Trigger rebuild
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Text('Các dòng bạn đã nhập:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: textLines.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(textLines[index]),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    ),
  },

  {
    'title': 'Button',
    'subtitle': 'Elevated Button',
    'widget': Center(
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Hãy ấn tôi'),
      ),
    ),
  },

  {
    'title': 'Switch',
    'subtitle': 'Toggle switch',
    'widget': Center(
      child: Builder(
        builder: (context) {
          bool isSwitched = false;
          return StatefulBuilder(
            builder: (context, setState) {
              return Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              );
            },
          );
        },
      ),
    )
  },


  {
    'title': 'Checkbox',
    'subtitle': 'Selectable checkbox',
    'widget': Center(
      child: Builder(
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(
            builder: (context, setState) {
              return Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              );
            },
          );
        },
      ),
    ),
  },
  {
    'title': 'Slider',
    'subtitle': 'Value slider',
    'widget': Center(
      child: Builder(
        builder: (context) {
          double sliderValue = 50;
          return StatefulBuilder(
            builder: (context, setState) {
              return Slider(
                value: sliderValue,
                min: 0,
                max: 100,
                divisions: 100,
                label: sliderValue.round().toString(),
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
              );
            },
          );
        },
      ),
    ),
  },

  {
    'title': 'Progress Indicator',
    'subtitle': 'Circular progress',
    'widget': Center(
      child: CircularProgressIndicator(),
    ),
  },
  {
    'title': 'Card',
    'subtitle': 'Card with content',
    'widget': Center(
      child: Card(
        margin: EdgeInsets.all(50),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Text('Đây là một Card'),
        ),
      ),
    ),
  },
  {
    'title': 'ListView',
    'subtitle': 'Vertical list',
    'widget': ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 100,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item ${index + 1}'),
        );
      },
    ),
  },
  {
    'title': 'GridView',
    'subtitle': 'Grid layout',
    'widget': GridView.count(
      crossAxisCount: 3,
      padding: EdgeInsets.all(16),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: List.generate(9, (index) {
        return Container(
          color: Colors.blue[(index + 1) * 100],
          child: Center(child: Text('Box ${index + 1}')),
        );
      }),
    ),
  },
  {
    'title': 'SnackBar',
    'subtitle': 'Temporary message',
    'widget': Builder(
      builder: (context) {
        return Center(
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đây là SnackBar!')),
              );
            },
            child: Text('Bạn đã bị hack'),
          ),
        );
      },
    ),
  },
  {
    'title': 'Dialog',
    'subtitle': 'Alert dialog',
    'widget': Builder(
      builder: (context) {
        return Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Thông báo'),
                  content: Text('Đây là Dialog!'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Bạn đã bị hack'),
          ),
        );
      },
    ),
  },
];
class TaskDetail {
  final int id;
  final String title;
  final String? desImageURL;
  final String description;
  final dynamic status;
  final String priority;
  final String category;
  final dynamic dueDate;
  final List<Subtask> subtasks;
  final List<Reminder> reminders;
  final List<Attachment> attachments;

  TaskDetail({
    required this.id,
    required this.title,
    this.desImageURL,
    required this.description,
    required this.status,
    required this.priority,
    required this.category,
    required this.dueDate,
    required this.subtasks,
    required this.reminders,
    required this.attachments,
  });

  factory TaskDetail.fromJson(Map<String, dynamic> json) {
    return TaskDetail(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      desImageURL: json['desImageURL']?.toString(),
      description: json['description']?.toString() ?? '',
      status: json['status'],
      priority: json['priority']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      dueDate: json['dueDate'],
      subtasks: json['subtasks'] != null 
          ? (json['subtasks'] as List).map((e) => Subtask.fromJson(e)).toList()
          : [],
      reminders: json['reminders'] != null 
          ? (json['reminders'] as List).map((e) => Reminder.fromJson(e)).toList()
          : [],
      attachments: json['attachments'] != null 
          ? (json['attachments'] as List).map((e) => Attachment.fromJson(e)).toList()
          : [],
    );
  }

  String get statusText {
    if (status is int) {
      switch (status) {
        case -1: return 'Cancelled';
        case 0: return 'Pending';
        case 1: return 'In Progress';
        case 2: return 'Completed';
        default: return 'Unknown';
      }
    }
    return status?.toString() ?? 'Unknown';
  }

  DateTime get dueDateTime {
    if (dueDate is String) {
      if (dueDate == '-1') return DateTime.now();
      try {
        return DateTime.parse(dueDate);
      } catch (e) {
        return DateTime.now();
      }
    }
    return dueDate is DateTime ? dueDate : DateTime.now();
  }
}

class Subtask {
  final dynamic id;
  final dynamic title;
  final bool isCompleted;

  Subtask({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory Subtask.fromJson(Map<String, dynamic> json) {
    return Subtask(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  String get idString => id?.toString() ?? '';
  String get titleString {
    if (title is bool) {
      return title ? 'Yes' : 'No';
    }
    return title?.toString() ?? '';
  }
}

class Reminder {
  final int id;
  final DateTime time;
  final String type;

  Reminder({
    required this.id,
    required this.time,
    required this.type,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] ?? 0,
      time: json['time'] != null ? DateTime.parse(json['time']) : DateTime.now(),
      type: json['type']?.toString() ?? '',
    );
  }
}

class Attachment {
  final int id;
  final String fileName;
  final String fileUrl;

  Attachment({
    required this.id,
    required this.fileName,
    required this.fileUrl,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'] ?? 0,
      fileName: json['fileName']?.toString() ?? '',
      fileUrl: json['fileUrl']?.toString() ?? '',
    );
  }
}

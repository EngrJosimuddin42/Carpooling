import 'package:flutter/material.dart';
import '../models/child_model.dart';

class AppData {
  static final AppData _instance = AppData._internal();
  factory AppData() => _instance;
  AppData._internal();

  final List<ChildModel> children = [];

  // ── User profile ──
  final ValueNotifier<Map<String, String>> userProfile = ValueNotifier({
    'name': 'John Doe',
    'phone': '1712-345678',
    'address': '123 Main Street, Gulshan, Dhaka',
    'school': 'Greenfield International School',
    'bio': '',
    'emergency': '+880 1823-456789',
    'avatar': 'assets/images/avatar1.jpg',
  });


  // ── Carpools list ──────────────────────────────────────────────────────────
  final ValueNotifier<List<Map<String, dynamic>>> carpools = ValueNotifier([
    {
      'title': 'Weekend Soccer Practice',
      'status': 'Active',
      'date': 'Saturday • 9:00 AM',
      'from': '789 Pine Rd',
      'to': 'City Sports Complex',
      'parents': 3,
      'children': 8,
      'driver': 'Mike Thompson',
    },
    {
      'title': 'Morning School Run',
      'status': 'Active',
      'date': 'Today • 7:30 AM',
      'from': '123 Main St',
      'to': 'Lincoln Elementary',
      'parents': 3,
      'children': 5,
      'driver': 'You',
    },
    {
      'title': 'After School Pickup',
      'status': 'Pending',
      'date': 'Today • 3:00 PM',
      'from': 'Lincoln Elementary',
      'to': '456 Oak Ave',
      'parents': 4,
      'children': 6,
      'driver': 'No Driver',
    },

  ]);

  void addCarpool(Map<String, dynamic> carpool) {
    carpools.value = [...carpools.value, carpool];
  }

  void removeCarpool(int index) {
    final updated = List<Map<String, dynamic>>.from(carpools.value);
    updated.removeAt(index);
    carpools.value = updated;
  }


  int get unreadCount =>
      notifications.value.where((n) => !n['read']).length;

  void markAllRead() {
    final updated = notifications.value
        .map((n) => {...n, 'read': true})
        .toList();
    notifications.value = updated;
  }

  void markRead(int index) {
    final updated = List<Map<String, dynamic>>.from(notifications.value);
    updated[index] = {...updated[index], 'read': true};
    notifications.value = updated;
  }

  final ValueNotifier<List<Map<String, dynamic>>> notifications =
  ValueNotifier([
    {
      'type': 'carpool_invitation',
      'title': 'New Carpool Invitation',
      'msg': "Sarah Johnson invited you to 'Weekend Soccer Practice'",
      'time': '5m ago',
      'read': false,
    },
    {
      'type': 'driver_assigned',
      'title': 'Driver Assigned',
      'msg': "Mike Thompson is now the driver for 'Morning School Run'",
      'time': '1h ago',
      'read': false,
    },
    {
      'type': 'new_message',
      'title': 'New Message',
      'msg': 'Sarah: Thanks for the ride today!',
      'time': '2h ago',
      'read': true,
    },
    {
      'type': 'carpool_updated',
      'title': 'Carpool Updated',
      'msg': "Time changed for 'After School Pickup' to 3:30 PM",
      'time': '3h ago',
      'read': true,
    },
    {
      'type': 'upcoming_carpool',
      'title': 'Upcoming Carpool',
      'msg': "Reminder: 'Morning School Run' starts in 30 minutes",
      'time': 'Yesterday',
      'read': true,
    },
    {
      'type': 'carpool_cancelled',
      'title': 'Carpool Cancelled',
      'msg': "Mike Thompson cancelled 'Weekend Practice'",
      'time': '2 days ago',
      'read': true,
    },
  ]);

  static Map<String, dynamic> getNotificationStyle(String type) {
    switch (type) {
      case 'carpool_invitation':
        return {
          'icon': 'assets/icons/carpool_outlined.svg',
          'color': const Color(0xFF155DFC),
          'bgColor': const Color(0xFFDBEAFE),
        };
      case 'driver_assigned':
        return {
          'icon': 'assets/icons/car.svg',
          'color': const Color(0xFF009966),
          'bgColor': const Color(0xFFD0FAE5),
        };
      case 'new_message':
        return {
          'icon': 'assets/icons/chat.svg',
          'color': const Color(0xFF9810FA),
          'bgColor': const Color(0xFFF3E8FF),
        };
      case 'carpool_updated':
        return {
          'icon': 'assets/icons/edit_outlined.svg',
          'color': const Color(0xFFF54900),
          'bgColor': const Color(0xFFFFEDD4),
        };
      case 'upcoming_carpool':
        return {
          'icon': 'assets/icons/notification_outlined.svg',
          'color': const Color(0xFF155DFC),
          'bgColor': const Color(0xFFDBEAFE),
        };
      case 'carpool_cancelled':
        return {
          'icon': 'assets/icons/delete_outline.svg',
          'color': const Color(0xFFE7000B),
          'bgColor': const Color(0xFFFFE2E2),
        };
      default:
        return {
          'icon': 'assets/icons/notification_outlined.svg',
          'color': const Color(0xFF155DFC),
          'bgColor': const Color(0xFFDBEAFE),
        };
    }
  }
}
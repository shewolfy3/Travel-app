import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookingController extends GetxController {
  static const String _boxName = 'bookings_box_V2';
  Box? _box;

  final RxDouble balance = 557.0.obs;
  final RxList<Map<String, dynamic>> bookings = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> walletTransactions = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> paymentHistory = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadFromDisk();
  }

  Future<void> _loadFromDisk() async {
    try {
      _box = await Hive.openBox(_boxName);
    } catch (e) {
      debugPrint('BookingController: could not open Hive box, running in-memory only. Error: $e');
      _box = null;
      return;
    }

    try {
      final storedBalance = _box!.get('balance');
      if (storedBalance != null) {
        balance.value = (storedBalance as num).toDouble();
      }
    } catch (e) {
      debugPrint('BookingController: failed to load balance. Error: $e');
    }

    try {
      final storedBookings = _box!.get('bookings');
      if (storedBookings != null) {
        bookings.value = (storedBookings as List)
            .map((e) {
              try {
                return _deserializeBooking(Map<String, dynamic>.from(e as Map));
              } catch (_) {
                return null;
              }
            })
            .whereType<Map<String, dynamic>>()
            .toList();
      }
    } catch (e) {
      debugPrint('BookingController: failed to load bookings. Error: $e');
    }

    try {
      final storedWallet = _box!.get('walletTransactions');
      if (storedWallet != null) {
        walletTransactions.value = (storedWallet as List)
            .map((e) {
              try {
                return _deserializeTx(Map<String, dynamic>.from(e as Map));
              } catch (_) {
                return null;
              }
            })
            .whereType<Map<String, dynamic>>()
            .toList();
      }
    } catch (e) {
      debugPrint('BookingController: failed to load wallet transactions. Error: $e');
    }

    try {
      final storedPayments = _box!.get('paymentHistory');
      if (storedPayments != null) {
        paymentHistory.value = (storedPayments as List)
            .map((e) {
              try {
                return _deserializeTx(Map<String, dynamic>.from(e as Map));
              } catch (_) {
                return null;
              }
            })
            .whereType<Map<String, dynamic>>()
            .toList();
      }
    } catch (e) {
      debugPrint('BookingController: failed to load payment history. Error: $e');
    }
  }

  void _saveToDisk() {
    if (_box == null) return; // persistence unavailable this session — stay in-memory
    try {
      _box!.put('balance', balance.value);
      _box!.put('bookings', bookings.map(_serializeBooking).toList());
      _box!.put('walletTransactions', walletTransactions.map(_serializeTx).toList());
      _box!.put('paymentHistory', paymentHistory.map(_serializeTx).toList());
    } catch (e) {
      debugPrint('BookingController: failed to save to disk. Error: $e');
    }
  }

  Map<String, dynamic> _serializeBooking(Map<String, dynamic> b) {
    return {
      'type': b['type'],
      'title': b['title'],
      'date': b['date'],
      'status': b['status'],
      'price': b['price'],
      'emoji': b['emoji'],
      'colorValue': (b['color'] as Color).value,
      'bookedAt': (b['bookedAt'] as DateTime).millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> _deserializeBooking(Map<String, dynamic> b) {
    return {
      'type': b['type'] as String? ?? 'Other',
      'title': b['title'] as String? ?? 'Booking',
      'date': b['date'] as String? ?? '',
      'status': b['status'] as String? ?? 'Upcoming',
      'price': b['price'] as String? ?? '\$0',
      'emoji': b['emoji'] as String? ?? '🧳',
      'color': Color((b['colorValue'] as num?)?.toInt() ?? 0xFF007BFF),
      'bookedAt': DateTime.fromMillisecondsSinceEpoch(
          (b['bookedAt'] as num?)?.toInt() ?? DateTime.now().millisecondsSinceEpoch),
    };
  }

  Map<String, dynamic> _serializeTx(Map<String, dynamic> t) {
    return {
      'title': t['title'],
      'date': t['date'],
      'amount': t['amount'],
      'status': t['status'],
      'type': t['type'],
      'colorValue': (t['color'] as Color).value,
    };
  }

  Map<String, dynamic> _deserializeTx(Map<String, dynamic> t) {
    final type = t['type'] as String? ?? '';
    return {
      'title': t['title'] as String? ?? '',
      'date': t['date'] as String? ?? '',
      'amount': t['amount'] as String? ?? '\$0',
      'status': t['status'] as String? ?? '',
      'type': type,
      'color': Color((t['colorValue'] as num?)?.toInt() ?? 0xFF007BFF),
      'icon': _iconForType(type),
    };
  }

  double _extractPrice(String price) {
    final match = RegExp(r'[\d.]+').firstMatch(price);
    return match != null ? double.parse(match.group(0)!) : 0;
  }

  bool addBooking({
    required String type,
    required String title,
    required String date,
    required String price,
    required String emoji,
    required Color color,
  }) {
    final amount = _extractPrice(price);

    if (amount > balance.value) {
      Get.snackbar(
        'Insufficient Balance',
        'Your wallet balance (\$${balance.value.toStringAsFixed(2)}) is too low for this booking.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    final booking = {
      'type': type,
      'title': title,
      'date': date,
      'status': 'Upcoming',
      'price': price,
      'emoji': emoji,
      'color': color,
      'bookedAt': DateTime.now(),
    };

    bookings.insert(0, booking);
    balance.value -= amount;

    walletTransactions.insert(0, {
      'title': title,
      'date': _formatToday(),
      'amount': '-\$${amount.toStringAsFixed(0)}',
      'icon': _iconForType(type),
      'color': color,
      'type': 'debit',
    });

    paymentHistory.insert(0, {
      'title': title,
      'date': _formatToday(),
      'amount': price,
      'status': 'Paid',
      'icon': _iconForType(type),
      'color': color,
    });

    _saveToDisk();

    Get.snackbar(
      'Booking Confirmed',
      '$title has been booked.',
      snackPosition: SnackPosition.BOTTOM,
    );

    return true;
  }

  void cancelBooking(Map<String, dynamic> booking) {
    final index = bookings.indexWhere((b) =>
        b['title'] == booking['title'] && b['bookedAt'] == booking['bookedAt']);
    if (index == -1) return;

    final amount = _extractPrice(booking['price'] as String);
    bookings[index] = {...bookings[index], 'status': 'Cancelled'};
    bookings.refresh();

    balance.value += amount;

    walletTransactions.insert(0, {
      'title': 'Refund - ${booking['title']}',
      'date': _formatToday(),
      'amount': '+\$${amount.toStringAsFixed(0)}',
      'icon': Icons.refresh,
      'color': const Color(0xFF00C896),
      'type': 'credit',
    });

    paymentHistory.insert(0, {
      'title': booking['title'],
      'date': _formatToday(),
      'amount': booking['price'],
      'status': 'Refunded',
      'icon': _iconForType(booking['type'] as String),
      'color': booking['color'],
    });

    _saveToDisk();
  }

  void completeBooking(Map<String, dynamic> booking) {
    final index = bookings.indexWhere((b) =>
        b['title'] == booking['title'] && b['bookedAt'] == booking['bookedAt']);
    if (index == -1) return;
    bookings[index] = {...bookings[index], 'status': 'Completed'};
    bookings.refresh();
    _saveToDisk();
  }

  void topUp(double amount) {
    balance.value += amount;
    walletTransactions.insert(0, {
      'title': 'Wallet Top-up',
      'date': _formatToday(),
      'amount': '+\$${amount.toStringAsFixed(0)}',
      'icon': Icons.account_balance_wallet,
      'color': const Color(0xFF00C896),
      'type': 'credit',
    });
    _saveToDisk();
  }

  double get totalSpent => walletTransactions
      .where((t) => t['type'] == 'debit')
      .fold(0.0, (sum, t) => sum + _extractPrice(t['amount'] as String));

  double get totalAdded => walletTransactions
      .where((t) => t['type'] == 'credit')
      .fold(0.0, (sum, t) => sum + _extractPrice(t['amount'] as String));

  IconData _iconForType(String type) {
    switch (type) {
      case 'Flight':
        return Icons.airplanemode_active;
      case 'Hotel':
        return Icons.hotel;
      case 'Activity':
        return Icons.terrain;
      case 'Visa':
        return Icons.description;
      default:
        return Icons.receipt_long;
    }
  }

  String _formatToday() {
    final now = DateTime.now();
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }
}
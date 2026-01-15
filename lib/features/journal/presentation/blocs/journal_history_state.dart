import 'package:equatable/equatable.dart';
import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';

class JournalHistoryState extends Equatable {
  final List<Journal> journals;
  final DateTime selectedMonth;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const JournalHistoryState({
    required this.journals,
    required this.selectedMonth,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  @override
  List<Object?> get props => [
    journals,
    selectedMonth,
    hasNextPage,
    hasPreviousPage,
  ];
}

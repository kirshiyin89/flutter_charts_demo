class LinearExpenses {
  final int year;
  final int expense;

  LinearExpenses(this.year, this.expense);

  int compareByYear(LinearExpenses expenses) {
    if (expenses.year == this.year) {
      return 0;
    }
    return this.year > expenses.year ? 1 : -1;
  }
}

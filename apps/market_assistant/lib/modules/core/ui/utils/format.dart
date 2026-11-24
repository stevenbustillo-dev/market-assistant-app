String formatNumber(double n, int decimals) {
  return (n == n.truncateToDouble())
      ? n.toStringAsFixed(0)
      : double.parse(n.toStringAsFixed(decimals)).toString();
}


List<List<dynamic>> chunkedReservList(
    List<dynamic> list, int chunkSize) {
  List<List<dynamic>> chunks = [];
  for (var i = 0; i < list.length; i += chunkSize) {
    chunks.add(list.sublist(
        i, i + chunkSize > list.length ? list.length : i + chunkSize));
  }
  return chunks;
}
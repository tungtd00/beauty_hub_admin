import 'dart:math';

String generateRandomId() {
  // Lấy thời gian hiện tại dưới dạng chuỗi để đảm bảo sự duy nhất
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

  // Tạo số ngẫu nhiên
  Random random = Random();
  String randomPart = random.nextInt(9999).toString().padLeft(4, '0');

  // Kết hợp thời gian và số ngẫu nhiên để tạo mã độc đáo
  String uniqueId = '$timestamp$randomPart';

  return uniqueId;
}
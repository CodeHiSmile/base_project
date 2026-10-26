/// Cổng báo "phiên đăng nhập hết hạn" từ tầng data lên tầng app.
///
/// `RefreshTokenInterceptor` gọi khi refresh token thất bại. Tầng data không navigate, không mở
/// dialog — việc đó thuộc implementation ở `lib/app/session/` (UX hết phiên của từng app).
abstract class SessionExpiredHandler {
  Future<void> onSessionExpired();
}

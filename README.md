# 1. Introduction

- SigmaAudioPlayer

# 2. Yêu cầu

- **Operating system:**
  - `iOS 9.0 trở lên

# 3. Tích hợp SigmaAudioPlayer

**Step 1: Cài đặt thư viện**

- Thêm thư viện: kéo libSigmaDRMAudio.a và include header vào dự án của bạn (thêm phụ trong mục Build Phases nếu chưa có)

**Step 2: Sử dụng SigmaAudioPlayer**

- **Setup SigmaDRM `SigmaAudioPlayer`:**

  ```objective-c
      #import <SigmaAudioPlayer.h>
      SigmaAudioPlayer* smAudioPlayer;

      smAudioPlayer = [[SigmaAudioPlayer alloc]init];
      [smAudioPlayer setDelegate:self];

      NSDictionary *appConfig = @{
          @"merchantId": MERCHANT_ID,
          @"appId": APP_ID,
          @"userId": USER_ID,
          @"sessionId": SESSION_ID};
      [smAudioPlayer setAppConfig:appConfig];
  ```

  | Props       | Type     | Description                                 |
  | ----------- | -------- | ------------------------------------------- |
  | MERCHANT_ID | NSString | Id của khách hàng                           |
  | APP_ID      | NSString | Id của ứng dụng                             |
  | USER_ID     | NSString | UserId đc cấp phát từ phía ứng dụng         |
  | SESSION_ID  | NSString | Session của user được cấp phát bởi ứng dụng |

- **Thông tin khách hàng:** MERCHANT_ID và APP_ID lấy từ Dashboard
  <!-- ![get_customer_info](..\assets\dashboard_get_merchant_app_integrate.png) -->

# 4. API:

- Thuộc tính

  | Name         | Type     | Description                                                                                                  |
  | ------------ | -------- | ------------------------------------------------------------------------------------------------------------ |
  | url          | NSString | Link của audio muốn phát                                                                                     |
  | duration     | float    | Thời lượng nội dung có thể phát                                                                              |
  | currentTime  | float    | Thời gian hiện tại. Thay đổi bằng setter smAudioPlayer.currentTime = atTime; atTime thuộc đoạn [0, duration] |
  | volume       | float    | Âm lượng phát. Thay đổi bằng setter smAudioPlayer.volume = value; value thuộc đoạn [0, 1]                    |
  | loop         | BOOL     | Lặp lại. Thay đổi bằng setter smAudioPlayer.loop = value; value = TRUE or FALSE                              |
  | playbackRate | float    | Tốc độ phát lại. Thay đổi bằng setter smAudioPlayer.playbackRate = value; value thuộc đoạn [0.25, 2]         |
  | sampleRate   | long     | Tốc độ lấy mẫu                                                                                               |
  | bitrate      | int      | Tốc độ bit                                                                                                   |

- Method

  | Name                                  | Return | Description                                               |
  | ------------------------------------- | ------ | --------------------------------------------------------- |
  | play:(NSString\*)url                  | void   | Bắt đầu, tạm dừng hoặc tiếp tục phát nội dung từ link url |
  | resume                                | void   | Tiếp tục phát                                             |
  | pause                                 | void   | Tạm ngừng phát                                            |
  | isPlaying                             | BOOL   | Trạng thái đang phát (TRUE) hoặc tạm ngừng (FALSE)        |
  | stop                                  | void   | Dừng phát                                                 |
  | saveFileWithPath:(NSString\*)filePath | void   | Lưu file đang phát với đường dẫn filePath                 |
  | saveOtherFileWithUrl:andFilePath:     | void   | Lưu file từ nguồn url vào địa chỉ filePath                |

- EventsListener

  | Name                                        | Description                                                                            |
  | ------------------------------------------- | -------------------------------------------------------------------------------------- |
  | onLoadStart                                 | Sự kiện xảy ra khi quá trình tải dữ liệu bắt đầu                                       |
  | onProgress                                  | Sự kiện xảy ra khi ứng dụng tải tài nguyên, đồng thời thể hiện phần trăm file được lưu |
  | onLoaded                                    | Sự kiện xảy ra khi quá trình tải dữ liệu kết thúc                                      |
  | onDurationChange                            | Sự kiện xảy ra khi thời lượng phát thay đổi                                            |
  | onTimeUpdate                                | Sự kiện xảy ra khi thời gian hiện tại (so với thời gian bắt đầu) thay đổi              |
  | onEnded                                     | Sự kiện xảy ra khi phát đến cuối                                                       |
  | onCanPlay                                   | Sự kiện xảy ra khi nội dung sẵn sàng để phát                                           |
  | onStateChange                               | Sự kiện xảy ra khi trình phát thay đổi trạng thái.                                     |
  | onInterruptionBegan                         | Sự kiện xảy ra ngắt, trình phát bị gián đoạn                                           |
  | onInterruptionEnded                         | Sự kiện kết thúc ngắt                                                                  |
  | onFileSavingWithUrl:andFilePath:withPercent | Sự kiện xảy ra khi quá trình lưu file kết thúc                                         |
  | onFileSavedWithUrl:andFilePath              | Sự kiện xảy ra khi ứng dụng tải tài nguyên                                             |
  | onError                                     | Sự kiện xảy ra khi có lỗi                                                              |

# 5. Demo

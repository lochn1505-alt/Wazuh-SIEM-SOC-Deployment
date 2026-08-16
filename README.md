# SIEM Deployment & SOC Use Cases with Wazuh

# Giới thiệu chung
Dự án thực hiện việc cài đặt, cấu hình và vận hành hệ thống Quản lý Sự kiện và Thông tin Bảo mật (SIEM) mã nguồn mở Wazuh. Hệ thống bao gồm Wazuh Server (All-in-one) triển khai trên nền tảng Ubuntu Server 24.04.3 và các Wazuh Agents được cài đặt trên các máy trạm (Endpoints) để thu thập log tập trung.

Mục tiêu của dự án là xây dựng các kịch bản giám sát an ninh (Monitoring) và tự động phản ứng (Active Response) nhằm bảo vệ hệ thống trước các kỹ thuật tấn công phổ biến.

# Các kịch bản Giám sát & Phản ứng đã triển khai

Dự án đã cấu hình thành công 11 kịch bản vận hành thực tế cho Trung tâm SOC, bao phủ từ giám sát thụ động đến phản ứng chủ động:

1.  **Chặn địa chỉ IP độc hại truy cập đến Web Server:** Kết hợp danh sách CDB từ AlienVault và Active Response để nhận diện và tự động chặn các IP trong danh sách đen[cite: 2].
2.  **Giám sát tính toàn vẹn file (FIM):** Theo dõi sự thay đổi của hệ thống tệp tin để phát hiện ngay lập tức các hành vi tạo mới, sửa đổi hoặc xóa tệp nhạy cảm[cite: 2].
3.  **Phát hiện cuộc tấn công Brute-Force:** Tương quan các sự kiện đăng nhập thất bại liên tiếp (SSH/PAM) để nhận diện hành vi dò mật khẩu (mô phỏng bằng công cụ Hydra)[cite: 2].
4.  **Phát hiện tiến trình không được ủy quyền:** Sử dụng tính năng giám sát lệnh để phát hiện các quy trình đáng ngờ, cụ thể là công cụ Netcat (nc) đang mở cổng lắng nghe trái phép[cite: 2].
5.  **Phát hiện tấn công SQL Injection:** Phân tích log truy cập từ máy chủ Apache để xác định các mẫu đặc trưng của SQL Injection thông qua các từ khóa độc hại[cite: 2].
6.  **Phát hiện các tệp nhị phân đáng ngờ (Rootcheck):** Sử dụng mô-đun Rootcheck để phát hiện các tệp nhị phân cốt lõi của hệ thống (ví dụ: `/usr/bin/w`) đã bị cấy mã độc (Trojaned)[cite: 2].
7.  **Tích hợp VirusTotal & Tự động xóa Malware:** Tự động gửi băm (hash) của tệp mới tạo để quét qua API VirusTotal. Nếu bị đánh dấu là phần mềm độc hại, hệ thống kích hoạt kịch bản tự động xóa tệp khỏi điểm cuối (thử nghiệm thành công với tệp EICAR)[cite: 2].
8.  **Tích hợp YARA:** Kết hợp FIM và các tập luật YARA để quét và phát hiện các mẫu phần mềm độc hại nâng cao lẩn khuất bên trong hệ thống[cite: 2].
9.  **Phát hiện các lỗ hổng (Vulnerability Detection):** Sử dụng Syscollector để thu thập danh sách phần mềm đang chạy trên Endpoint và liên tục đối chiếu với cơ sở dữ liệu CVE toàn cầu để tìm ra lỗ hổng[cite: 2].
10. **Giám sát việc thực thi lệnh độc hại (Auditd):** Tích hợp công cụ kiểm toán Auditd của Linux để ghi lại, giám sát và cảnh báo toàn bộ các lệnh được thực thi dưới quyền `root` hoặc qua `sudo`[cite: 2].
11. **Phát hiện tấn công Shellshock:** Theo dõi nhật ký truy cập Web Server để nhận diện các yêu cầu HTTP giả mạo chứa payload nhằm khai thác lỗ hổng Shellshock[cite: 2].

#  Hướng dẫn sử dụng & Tài liệu chi tiết
1. 📄 Vui lòng tải và đọc tệp **`Bao_Cao_Wazuh.pdf`** đính kèm trong repository này để xem hướng dẫn từng bước cấu hình (Step-by-step Configuration) cho 11 kịch bản SOC nêu trên.
2. Tài liệu bao gồm chi tiết các cấu hình tệp `ossec.conf`, quy tắc tùy chỉnh (Custom Rules `local_rules.xml`), và hình ảnh minh họa cảnh báo (Alerts) trên giao diện Wazuh Dashboard.

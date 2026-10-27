# SmartFarm System

Hệ thống giám sát và quản lý thiết bị nông nghiệp thông minh.

## 1. Hướng dẫn chạy script

### Bước 1: Mở PowerShell

Di chuyển đến thư mục `scripts`:

```powershell
cd .\scripts
```

### Bước 2: Chạy script tạo báo cáo

```powershell
.\auto_report.ps1
```

Nếu bị chặn bởi ExecutionPolicy, sử dụng:

```powershell
powershell -ExecutionPolicy Bypass -File .\auto_report.ps1
```

### Bước 3: Kiểm tra kết quả

```powershell
Get-Content ..\backup\bao-cao-su-co.txt
```

Script đọc log từ `data/log-he-thong.log`, lọc các dòng chứa `CRITICAL` hoặc `ERROR`, đếm số sự cố và ghi kết quả vào `backup/bao-cao-su-co.txt`.

## 2. Checklist kiểm tra thiết bị

- [x] Kiểm tra kết nối của trạm sensor-03.
- [ ] Kiểm tra trạng thái hoạt động của modem.
- [ ] Kiểm tra dung lượng lưu trữ của thiết bị.
- [ ] Kiểm tra log hệ thống để phát hiện lỗi `ERROR` và `CRITICAL`.

## 3. Bảng thông số phần cứng


| Tên thiết bị | Đơn giá (VNĐ) | Loại storage |
|---|---:|---|
| Raspberry Pi 4 Model B | 1,450,000 | SSD |
| Intel NUC i3| 6,200,000 | SSD|
|Orange Pi 5 | 2,300,000 | SSD |
|...|...|..V.V|

## 4. Phân tích hệ thống

### 4.1. Mô hình Input – Process – Output (IPO)

**Input (Đầu vào)**

- File log hệ thống: `data/log-he-thong.log`.
- Các dòng nhật ký chứa thông tin trạng thái, thời gian và lỗi thiết bị.
- Từ khóa cần tìm: `CRITICAL` và `ERROR`.

**Process (Xử lý)**

1. Sử dụng `Get-Content` để đọc nội dung file log.
2. Sử dụng Pipeline (`|`) chuyển dữ liệu sang `Select-String`.
3. Sử dụng `Select-String "CRITICAL|ERROR"` để lọc các dòng có lỗi.
4. Sử dụng `Measure-Object` để đếm số dòng lỗi.
5. Ghi tiêu đề, thời gian tạo, danh sách lỗi và tổng số sự cố vào file báo cáo bằng `Set-Content`, `Add-Content` và toán tử `>>`.

**Output (Đầu ra)**

- File báo cáo: `backup/bao-cao-su-co.txt`.
- Nội dung gồm tiêu đề báo cáo, thời gian tạo, danh sách sự cố và tổng số sự cố được phát hiện.

### 4.2. Phân loại theo mô hình DIKW

DIKW gồm bốn tầng: Data (Dữ liệu), Information (Thông tin), Knowledge (Tri thức) và Wisdom (Trí tuệ).

| Phát biểu | Tầng DIKW | Giải thích |
|---|---|---|
| (a) “Quyết định thay modem trạm sensor-03 trước thứ Sáu.” | Wisdom | Đưa ra quyết định và hành động dựa trên thông tin, tri thức đã phân tích. |
| (b) “2026-10-12 08:15:01 [ERROR] sensor-03 Connection TIMEOUT after 30s” | Data | Bản ghi thô về một sự kiện lỗi, gồm thời gian, mức độ và nội dung lỗi. |
| (c) “Hôm nay hệ thống ghi nhận 8 sự cố, trong đó 4 sự cố đến từ trạm sensor-03.” | Information | Dữ liệu đã được tổng hợp và thống kê thành thông tin có ý nghĩa. |
| (d) “Trạm sensor-03 hay mất kết nối vào buổi chiều do sóng yếu.” | Knowledge | Nhận diện quy luật và nguyên nhân có khả năng giải thích các sự cố. |

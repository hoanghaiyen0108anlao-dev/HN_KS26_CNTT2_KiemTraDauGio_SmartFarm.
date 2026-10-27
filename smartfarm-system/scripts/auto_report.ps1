
# Tao tieu de bao cao
Write-Output "BAO CAO SU CO HE THONG SMARTFARM" | Set-Content ..\backup\bao-cao-su-co.txt
Write-Output "Thoi gian tao: $(Get-Date)" | Add-Content ..\backup\bao-cao-su-co.txt

# Loc cac dong chua CRITICAL hoac ERROR
Get-Content ..\data\log-he-thong.log | Select-String "CRITICAL|ERROR" >> ..\backup\bao-cao-su-co.txt

# Dem so dong loi bang Pipeline
$count = (Get-Content ..\data\log-he-thong.log | Select-String "CRITICAL|ERROR" | Measure-Object).Count

# Ghi tong so su co
Write-Output "TONG SO SU CO: $count" | Add-Content ..\backup\bao-cao-su-co.txt

Write-Output "Da tao bao cao thanh cong."

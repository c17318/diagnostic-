#!/system/bin/sh

# 감시할 디렉토리 경로
watch_dir="/data/data/com.sec.android.diagmonagent/files/"
# 복사될 디렉토리 경로
copy_to_dir="/data/local/tmp/"
# 이전에 복사된 파일 목록을 저장할 파일 경로
copied_files="/data/local/tmp/copied_files.txt"
# 감시 시작 메시지 출력
echo "감시 시작 중: $watch_dir"

# 주기적으로 디렉토리 확인 및 새로운 zip 파일 복사
while true; do
    # 감시 디렉토리 내의 zip 파일 목록 가져오기
    zip_files=$(find "$watch_dir" -maxdepth 1 -type f -name "*.zip")
    # 새로운 zip 파일 확인 및 복사
    for zip_file in $zip_files; do
        # 이전에 복사되지 않은 파일인지 확인
        if ! grep -q "$zip_file" "$copied_files"; then
            # zip 파일을 복사
            cp "$zip_file" "$copy_to_dir"
            echo "$zip_file" >> "$copied_files"
            echo "새로운 zip 파일이 복사되었습니다: $zip_file"
        fi
    done
    # 1초마다 디렉토리 확인
    sleep 1

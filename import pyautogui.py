import pyautogui
import time

print("마우스를 원하는 위치로 이동하세요. (Ctrl+C를 눌러 종료)")

try:
    while True:
        x, y = pyautogui.position()
        print(f"현재 좌표: ({x}, {y})", end="\r")  # 한 줄에 업데이트
        time.sleep(0.1)  # 0.1초마다 갱신
except KeyboardInterrupt:
    print("\n좌표 확인 종료!")

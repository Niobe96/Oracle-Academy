import time
import webbrowser
import pyautogui
import keyboard

# Chrome 브라우저 실행 및 URL 이동
def open_browser(url):
    webbrowser.open(url)
    time.sleep(5)  # 브라우저가 열릴 시간을 확보

# 한글 입력 함수
def type_korean(text):
    for char in text:
        keyboard.write(char)  # 한 글자씩 입력
        time.sleep(0.1)  # 입력 속도 조정

# 키보드 및 마우스 입력 (로그인 매크로 자동화)
def login_macro():
    time.sleep(2)  # 페이지 로드 대기

    # 아이디 입력란 클릭 후 입력
    pyautogui.click(-2241,665)  # 좌표 조정 필요
    time.sleep(0.2)
    type_korean("김건희") 
    time.sleep(2)

    # 드롭다운 클릭
    pyautogui.click(-2224, 698)
    time.sleep(0.5)

    # 비밀번호 입력란 클릭 후 입력
    pyautogui.click(-2237, 717)  # 좌표 조정 필요
    time.sleep(0.2)
    pyautogui.write("1679")
    time.sleep(0.5)

    # 로그인 버튼 클릭
    pyautogui.click(-2145, 778)  # 좌표 조정 필요
    time.sleep(2)
  
    #확인 버튼 클릭
    pyautogui.click(-1989,672)  # 좌표 조정 필요
    time.sleep(0.2)
    pyautogui.click(-1989,672)
    time.sleep(0.2)

     #출결체크 버튼 클릭
    pyautogui.click(-2751,714)  # 좌표 조정 필요
    time.sleep(0.8)

    #퇴실 버튼 클릭
    pyautogui.click(-2143,882)  # 좌표 조정 필요


# 메인 실행 함수
def main():
    print("매크로 실행 중...")
    open_browser("http://oracle.atosoft.net/worknet/SLogin.asp")
    login_macro()

if __name__ == "__main__":
    main()

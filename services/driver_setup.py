# driver_setup.py

# Стандартные библиотеки Python
import time, threading, os, shutil

# Сторонние библиотеки
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import WebDriverException

# Собственные модули
import config as config

# Глобальная переменная для хранения времени последнего взаимодействия
last_interaction_time = time.time()

# Функция с созданием и настройкой драйвера на хром
def create_chrome_driver(path_to_chrome_profile, path_to_chrome_driver, timeout):
    chrome_options = Options()

    # Указание пути к профилю Chrome
    if path_to_chrome_profile:
        chrome_options.add_argument(f"--user-data-dir={path_to_chrome_profile}")

    # Параметры для работы в Docker
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--disable-gpu")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")
    chrome_options.add_argument("--window-size=1920x1080")
    chrome_options.add_argument("--disable-blink-features=AutomationControlled")
    chrome_options.add_argument("--single-process")  # Попытка использовать один процесс для устранения ошибок в Docker
    chrome_options.add_argument("--remote-debugging-port=9222")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")

    # Отключение уведомлений
    chrome_options.add_experimental_option("prefs", {
        "profile.default_content_setting_values.notifications": 2
    })

    # Настройки для загрузки файлов
    prefs = {
        "download.default_directory": config.DOWNLOAD_DIRECTORY,
        "download.prompt_for_download": False,
        "download.directory_upgrade": True,
        "safebrowsing.enabled": True
    }
    chrome_options.add_experimental_option("prefs", prefs)

    # Запуск ChromeDriver
    try:
        driver_service = Service(executable_path=path_to_chrome_driver)
        config.driver = webdriver.Chrome(service=driver_service, options=chrome_options)

        # Запуск таймера для закрытия браузера
        timer_thread = threading.Thread(target=close_browser_after_timeout, args=(config.driver, timeout))
        reset_interaction_time()
        timer_thread.start()

    except Exception as e:
        print(f"Ошибка при запуске ChromeDriver: {e}")

    return config.driver

# Функция для закрытия драйвера (например, если бездействует долго)
def close_driver():
    try:
        if config.driver:
            config.driver.quit()
            config.driver = None
        return None
    except Exception as e:
        print(f"Ошибка при закрытии драйвера: {str(e)}")

def is_browser_active():
    try:
        # Попытка получить текущий URL, если браузер закрыт, то будет вызвано исключение
        if not config.driver:
            return False
        config.driver.current_url
        return True  # Браузер активен
    except WebDriverException:
        return False  # Браузер закрыт

# Функция для сброса времени последнего взаимодействия
def reset_interaction_time():
    global last_interaction_time
    last_interaction_time = time.time()

# Функция для сброса времени последнего взаимодействия
def stop_interaction_time():
    global last_interaction_time
    last_interaction_time = None

# Функция для закрытия браузера после тайм-аута
def close_browser_after_timeout(driver, timeout):
    global last_interaction_time
    while True:
        print("-", end="")
        if not last_interaction_time or time.time() - last_interaction_time > timeout or not config.driver:
            print("Время ожидания истекло, закрываю браузер...")
            close_driver()
            stop_interaction_time()
            clearing_downloads_directory()
            break
        time.sleep(5)  # Проверяем каждые 5 секунд

# Очистка всей директории с загрузками
def clearing_downloads_directory():
    folder = config.DOWNLOAD_DIRECTORY
    for filename in os.listdir(folder):
        file_path = os.path.join(folder, filename)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
        except:
            pass
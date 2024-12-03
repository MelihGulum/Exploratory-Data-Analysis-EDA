from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
import time

def initialize_web_driver():
    """Initialize and configure the Selenium WebDriver with necessary options."""

    options = webdriver.ChromeOptions()
    options.add_argument("--verbose")
    options.add_argument('--no-sandbox')
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--blink-settings=imagesEnabled=false')
    options.add_argument("--window-size=1920,1200")
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3")


    prefs = {"profile.managed_default_content_settings.images": 2,
             "profile.managed_default_content_settings.javascript": 2}
    options.add_experimental_option("prefs", prefs)

    driver = webdriver.Chrome(options=options)
    return driver


def extract_player_data(url, year, logger):
    """Extract player data from the specified URL using Selenium WebDriver."""

    start_time = time.time()
    logger.info(f"Starting data scraping of {year}")
    driver = initialize_web_driver()

    try:
      driver.get(url)
      logger.info(f"Successfully accessed URL: {url}")
    except Exception as e:
        logger.error(f"Failed to access URL: {url}. Error: {e}")
        driver.quit()
        return []

    try:
      wait = WebDriverWait(driver, 15)
      table = wait.until(EC.visibility_of_element_located((By.XPATH, '//*[@id="per_game_stats"]')))
      logger.info("Table element found")
    except TimeoutException:
        logger.error("Timeout waiting for table element.")
        driver.quit()
        return []

    try:
        rows = table.find_element(By.TAG_NAME, 'tbody').find_elements(By.TAG_NAME, "tr")
        subheadings = [thead.get_attribute('data-row') for thead in
                       table.find_elements(By.CSS_SELECTOR, 'tr[class="thead"]')]
        logger.info(f"Found {len(rows)} rows in the table. {len(subheadings)} of them are subheadings")
    except Exception as e:
        logger.error(f"Failed to retrieve table rows. Error: {e}")
        driver.quit()
        return []

    data_stats = ['player', 'pos', 'age', 'team_id', 'g', 'gs', 'mp_per_g', 'fp_per_g', 'fga_per_g',
                  'fg_pct', 'fg3_per_g', 'fg3a_per_g', 'fg3_pct', 'fg2_per_g', 'fg2a_per_g', 'fg2_pct',
                  'efg_pct', 'ft_per_g', 'fta_per_g', 'ft_pct', 'orb_per_g', 'drb_per_g', 'trb_per_g',
                  'ast_per_g', 'stl_per_g', 'blk_per_g', 'tov_per_g', 'pf_per_g', 'pts_per_g']

    all_players_data = []

    for idx, row in enumerate(rows, 1):
        row_class = row.get_attribute("class")
        if row_class and 'thead' in row_class:
            continue

        player_data = {}
        try:
            ranker = row.find_element(By.TAG_NAME, 'th').get_attribute('textContent')
            player_data['ranker'] = ranker
        except Exception as e:
            logger.warning(f"Ranker data missing for row {idx}")
            player_data['ranker'] = None

        cells = row.find_elements(By.TAG_NAME, 'td')
        for col_id, col in enumerate(data_stats):
            player_data[col] = cells[col_id].get_attribute('textContent') if col_id < len(cells) else None

        all_players_data.append(player_data)

    end_time = time.time()
    logger.info("Player data extraction completed successfully.")
    logger.info(f"Data extraction duration: {end_time - start_time:.2f} seconds.")
    driver.quit()

    return all_players_data

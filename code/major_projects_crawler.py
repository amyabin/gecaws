import json
import os
import uuid  # Import the uuid module
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from datetime import date
from typing import List

# Define the Project class
class Project:
    def __init__(
        self, 
        original_id: str, 
        aug_id: str, 
        country_name: str, 
        country_code: str, 
        region_name: str, 
        region_code: str, 
        latitude: float, 
        longitude: float, 
        url: str, 
        title: str, 
        description: str, 
        status: str, 
        timestamp: date, 
        timestamp_label: str, 
        budget: int, 
        budget_label: str, 
        currency: str, 
        sector: str, 
        subsector: str, 
        document_urls: List[str]
    ):
        self.original_id = original_id
        self.aug_id = aug_id
        self.country_name = country_name
        self.country_code = country_code
        self.region_name = region_name
        self.region_code = region_code
        self.latitude = latitude
        self.longitude = longitude
        self.url = url
        self.title = title
        self.description = description
        self.status = status
        self.timestamp = timestamp
        self.timestamp_label = timestamp_label
        self.budget = budget
        self.budget_label = budget_label
        self.currency = currency
        self.sector = sector
        self.subsector = subsector
        self.document_urls = document_urls

    def to_dict(self):
        return {
            "original_id": self.original_id,
            "aug_id": self.aug_id,
            "country_name": self.country_name,
            "country_code": self.country_code,
            "region_name": self.region_name,
            "region_code": self.region_code,
            "latitude": self.latitude,
            "longitude": self.longitude,
            "url": self.url,
            "title": self.title,
            "description": self.description,
            "status": self.status,
            "timestamp": self.timestamp.isoformat(),
            "timestamp_label": self.timestamp_label,
            "budget": self.budget,
            "budget_label": self.budget_label,
            "currency": self.currency,
            "sector": self.sector,
            "subsector": self.subsector,
            "document_urls": self.document_urls
        }

    def __repr__(self):
        return f"Project({self.title}, {self.country_name}, {self.status})"


# Setup Chrome options
chrome_options = Options()
# chrome_options.add_argument("--headless")  # Run in headless mode
chrome_options.add_argument("--disable-gpu")  # Disable GPU acceleration
chrome_options.add_argument("--no-sandbox")  # Bypass OS security model

# Path to your chromedriver
chrome_driver_path = 'chromedriver.exe' # Update this path

# Setup Chrome service
service = Service(chrome_driver_path)

# Initialize the Chrome driver
driver = webdriver.Chrome(service=service, options=chrome_options)

# URL to scrape
url = 'https://www.ci.richmond.ca.us/1404/Major-Projects'
driver.get(url)
inner_driver = webdriver.Chrome(service=service, options=chrome_options)

try:
    # Wait for the content to load
    WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.CSS_SELECTOR, 'div.fr-view'))
    )
    
    # Find the main content section
    main_content = driver.find_element(By.CSS_SELECTOR, 'div.fr-view')
    
    # Find all project elements
    project_elements = main_content.find_elements(By.TAG_NAME, 'li')  # Example: Assume each project is listed in a <li> tag
    
    # Extract and store project details
    projects = []
    for i, project_element in enumerate(project_elements[:10]):  # Fetch only the top 5 records
        title_element = project_element.find_element(By.TAG_NAME, 'a')
        title = title_element.text
        project_url = title_element.get_attribute('href')
        description = project_element.text.replace(title, '').strip()
        
        # Initialize inner driver for detailed page
        
        inner_driver.get(project_url)
        
        # Extract additional details (e.g., budget, date, document URLs)
        budget = 0
        timestamp = date.today()
        document_urls = []
        try:
            # Example extraction logic (modify as per actual structure)
            budget_element = inner_driver.find_element(By.CLASS_NAME, 'budget-class')  # Modify as per actual element
            budget = int(budget_element.text.replace('$', '').replace(',', ''))
        except Exception as e:
            print(f"Error extracting budget for {title}: {e}")
            pass
        try:
            date_element = inner_driver.find_element(By.CLASS_NAME, 'date-class')  # Modify as per actual element
            timestamp = date.fromisoformat(date_element.text)
        except Exception as e:
            print(f"Error extracting date for {title}: {e}")
            pass
        try:
            page_content = inner_driver.find_element(By.CSS_SELECTOR, 'div.fr-view')
            description = page_content.text
        except Exception as e:
            print(f"Error extracting documents for {title}: {e}")
            pass
        
        try:
            doc_links = page_content.find_elements(By.CSS_SELECTOR, 'a[href]')
            document_urls = [link.get_attribute('href') for link in doc_links]
            document_urls = [url for url in document_urls if not url.startswith("mailto:")]
            
        except Exception as e:
            print(f"Error extracting documents for {title}: {e}")
            pass
        
        # Creating a Project instance
        project = Project(
            original_id=str(i),  # Assuming a placeholder for unique ID
            aug_id=str(uuid.uuid4()),  # Generate a UUID for aug_id
            country_name='United States',  # Based on the website domain
            country_code='USA',  # ISO code for United States
            region_name='North America',  # Assumption based on location
            region_code = 'NAC',  # Placeholder for region code
            latitude=37.9358,  # Latitude for Richmond, CA
            longitude=-122.3478,  # Longitude for Richmond, CA
            url=project_url,
            title=title,
            description=description,
            status='',  # Placeholder for status
            timestamp=timestamp,
            timestamp_label='published_date',  # Placeholder for timestamp label
            budget=budget,
            budget_label='Total Project Cost',  # Placeholder for budget label
            currency='USD',  # Currency for the United States
            sector='',  # Placeholder for sector
            subsector='',  # Placeholder for subsector
            document_urls=document_urls
        )
        projects.append(project)
        
    
    # Convert projects to list of dictionaries
    projects_dict = [project.to_dict() for project in projects]
    
    # Create the output directory if it doesn't exist
    output_dir = 'project_output'
    os.makedirs(output_dir, exist_ok=True)
    
    # Write the projects data to a JSON file
    output_path = os.path.join(output_dir, 'projects.json')
    with open(output_path, 'w') as f:
        json.dump(projects_dict, f, indent=4)

    print(f"Data has been written to {output_path}")

finally:
    # Quit the driver
    driver.quit()
    inner_driver.quit()

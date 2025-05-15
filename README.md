## 📁 Project Structure

- [Installation](#installation)
- [Executing the Tests](#executing-the-tests)
  - [Run a Single Suite](#run-a-single-suite)
  - [Run Both Suites in Parallel](#run-both-suites-in-parallel)
  - [Run Just One Test](#run-just-one-test)
- [What to Expect](#what-to-expect)
- [Other Useful Commands](#other-useful-commands)

---

## Installation

1. **Clone the repo**
   ```bash
   git clone https://github.com/your-user/PwC-challenge-project.git
   cd PwC-challenge-project
    ```
    1.1 **Important**
    There are two .env files that need to be set up once the project is cloned. **Let's create** the .env files in the specified folders.


    **`/GUI/resources/.env`**

    with the content:
    <details>
    <summary>Click me</summary>

        SAUCEDEMO_USERNAME=standard_user
        SAUCEDEMO_PASSWORD=secret_sauce

    </details> 

    **`/API/resources/.env`**
    with the content:

    <details>
    <summary>Click me</summary>

        API_USER=admin
        API_PASS=password123

    </details> 

    **Tree locations:**
    ```
    ├── API
    │   ├── api_settings.robot
    │   ├── keywords
    │   └── resources
                └──.env
    ```

    ```
    ├── GUI
    │   ├── gui_settings.robot
    │   ├── keywords
    │   └── resources
                └──.env
    ```

    **Note:**
    > Storing credentials—even dummy ones—in `.env` files within versioned folders isn't a secure practice.  
    > However, due to limited time constraints, I opted for simplicity  over best practices.  
    > In a real-world scenario, sensitive variables would be managed diferently.
2. **Pull the Selenium image**

    Let’s pull the required Docker image:

   ```bash
   docker pull selenium/standalone-chromium:latest
   ```

3. **Install dependencies**

   ---

   **About virtual environments**
   I recommend using a separate Python environment.
   This project was tested with **Python 3.11.11**.
   If you have **Miniconda**, you can run:

   ```bash
   conda create --name PwCChallenge python=3.11
   conda activate PwCChallenge
   ```

   Or use any other virtual environment manager of your choice.

   Then, install the dependencies:

   ```bash
   pip install -r requirements.txt
   ```

---

## Executing the Tests

### Run a Single Suite

* **GUI only**

  ```bash
  robot GUI/suite/
  ```

* **API only**

  ```bash
  robot API/suite/
  ```

### Run Both Suites in Parallel

To leverage parallel execution and save time:

```bash
bash run_challenge.sh
```

### Run Just One Test

If you want to run a specific test case—say, **TC 4.1** from the **GUI** suite—you can use the test’s tag in the command:

```bash
robot -i "TC 4.1 GUI" GUI/
```

Where:

* `-i` is the "include" flag
* `"TC 4.1 GUI"` is the tag of the test (note the double quotes)
* `GUI/` is the folder where the test is located

**Pro tip:**
You can choose any **TC**, just append `GUI` or `API` to the tag.
Example for API:

```bash
robot -i "TC 4.1 API" API/
```

---

## What to Expect

After running the tests, **two key outcomes** will be visible:

1. **Report Files**

   Regardless of whether you run a single test, a single suite, or both suites, Robot Framework generates three report files in the current directory. The most important are:

   - **log.html**: Detailed log of test execution.
   - **report.html**: Summary of test results.

   For **Linux users** system with Chromium installed, run:

   ```bash
   google-chrome log.html
   google-chrome report.html
   ```

   For **windows users**, just double click on the files.

   This will open the files in a browser for review.

2. **Results Folder**

   The **results** folder will contain subdirectories with test execution outputs. For this challenge, most folders will be empty, except in specific cases where I included GUI screenshots as evidence. This reflects my preference for balancing evidence storage with minimal overhead.

---

## Other Useful Commands

- **Collect and Archive Reports**

   To save the report files (`log.html` and `report.html`) with a timestamp-based identifier and move them to the `results` folder, use:

   ```bash
   make collect
   ```

   This helps organize reports while preserving them for future reference.

- **Clean the Results Folder**

   To start with an empty `results` folder, run:

   ```bash
   make clean-results
   ```

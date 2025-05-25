## Project Structure

- [Installation](#installation)
- [Executing the Tests](#executing-the-tests)
  - [Run an Entire Suite](#run-an-entire-suite)
  - [Run Both Suites in Parallel](#run-both-suites-in-parallel)
  - [Run Just One Test](#run-just-one-test)
- [What to Expect](#what-to-expect)
- [Other Useful Commands](#other-useful-commands)

---

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/vergelli/API-GUI-testing-project.git
   cd API-GUI-testing-project/
   ```

1.1 **Set up environment variables**

This project requires a few environment variables to run properly (e.g., user credentials or service endpoints). You can configure them in one of the following ways:

 - Manual SetUp
 - Using `.env` files

The suite accept both aproaches.

* **Manual setup**: Export the required variables in your terminal before running the scripts:

  ```bash
  export API_USER=admin
  export API_PASS=password123
  export SAUCEDEMO_USERNAME=standard_user
  export SAUCEDEMO_PASSWORD=secret_sauce
  ```

* **Using `.env` files**:
  There are two `.env` files already included for convenience:

  * `GUI/resources/.env`
  * `API/resources/.env`

  These files contain the same environment variables (**commented**), organized per test suite.

  **Directory structure:**

  ```
  ├── API
  │   ├── api_settings.robot
  │   ├── keywords
  │   └── resources
  │       └── .env

  ├── GUI
  │   ├── gui_settings.robot
  │   ├── keywords
  │   └── resources
  │       └── .env
  ```

> **Security Note**
> Storing credentials—even dummy ones—in version-controlled `.env` files is **not a secure practice**.
> These are included here only for demonstration and ease of use during development.
> In real-world scenarios, sensitive data should be managed securely using environment variables configured outside the repository, or through secret managers (e.g., AWS Secrets Manager, Vault, CI/CD secrets, etc.).



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
   conda create --name gui_api_env python=3.11
   conda activate gui_api_env
   ```

   Or use any other virtual environment manager of your choice.

   Then, install the dependencies:

   ```bash
   pip install -r requirements.txt
   ```

---

## Executing the Tests

### Run an Entire Suite

It is **strongly recommended** to use the provided shell scripts to run the test suites, as they ensure a consistent environment and output structure:

- **Run the GUI test suite**
  ```bash
  bash run_gui_suite.sh
  ```

* **Run the API test suite**

  ```bash
  bash run_api_suite.sh
  ```
> You can still run the suites manually with `robot`, though it's not the preferred approach:
>
> ```bash
> robot GUI/suite/
> robot API/suite/
> ```

### Run a Single Test Case

To execute a specific test case (e.g. **TC 4.1** from the **GUI** suite), use the `-i` flag with its tag:

```bash
robot -i "TC 4.1 GUI" GUI/
```

Where:

* **`-i`** is the "include" filter
* **`"TC 4.1 GUI"`** is the test case tag (**quotes required**)
* **`GUI/`** is the suite folder

**Example for API:**

```bash
robot -i "TC 4.1 API" API/
```

> Tags follow the format: `"TC X.Y SUITE"`, where `SUITE` is either `GUI` or `API`.


### About Parallel Execution

While a script for parallel execution is included (**`run_suite_parallel.sh`**), its use is *not recommended*:

```bash
bash run_suite_parallel.sh
```
Internally, it uses [`pabot`](https://github.com/robotframework/pabot)

_⚠️ Although no inconsistencies were observed during test runs, **parallel execution has not been thoroughly validated**. Due to limited development time, the implementation lacks safeguards against race conditions involving temporary directories and shared artifacts. For now its use is risky._

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

   The **results** folder will contain subdirectories with test execution outputs. For this project, most folders will be empty, except in specific cases where I included GUI screenshots as evidence. This reflects my preference for balancing evidence storage with minimal overhead.

---
## Other Useful Commands

**Clean the Results Folder**

This command completely wipes the `results/` folder, including all archived reports and files:

```bash
make clean-results
```
It’s useful when:

 - You want to start from a clean state
 - You’ve accumulated multiple test runs and want to declutter

> Warning: This action is destructive and irreversible.
> Make sure to **save or backup** important reports before running it.
___

**Archive Reports Manually (Rarely Needed)**

   In most cases, **you won’t need to run this manually**, since both `run_api_suite.sh` and `run_gui_suite.sh` already handle report archiving automatically.


   However, if you ever run tests **manually** or **in parallel**, and `log.html` / `report.html` are left behind in the project rootDir, you can save them with a timestamp using:

   ```bash
   make reports-save
   ```

This command copies log.html, report.html, and output.xml into the `results/` directory and renames them with a timestamp to prevent overwriting previous results

Use this only if you see leftover report files after a non-standard run (e.g., using robot directly or experimenting with parallel execution).
___

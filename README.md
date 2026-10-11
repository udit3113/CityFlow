# CityFlow — Urban Mobility Analytics

## Overview

CityFlow is a data analytics project that explores ride-booking performance using Python, Pandas, and SQL. It investigates ride completion, cancellations, pickup locations, vehicle types, and cancellation reasons to identify areas that may need operational improvement.

The goal is to turn raw booking data into actionable insights rather than simply generate reports.

## Tech Stack

- **Python** — data exploration and analysis
- **Pandas** — data processing and analysis
- **SQL (SQLite)** — querying, aggregation, CTEs, and window functions
- **Matplotlib** — data visualization

## Project Structure

```text
CityFlow/
├── data/
│   └── ncr_ride_bookings.csv
├── notebooks/
│   └── day1_inspection.py
├── sql/
│   ├── analysis.sql
│   ├── setup_database.py
│   └── cityflow.db
├── dashboard/
├── images/
├── README.md
├── requirements.txt
└── .gitignore
```

The dataset and generated database are local files and should not be committed to Git unless their sharing permissions have been verified.

## Analysis Performed

- Booking volume and completion-rate analysis
- Driver and customer cancellation analysis
- Cancellation reasons and hourly patterns
- Pickup-location performance comparisons
- Vehicle-type performance analysis
- Location-by-vehicle cancellation analysis
- SQL CTEs and window functions for benchmarking
- Identification of priority areas for further investigation

## Key Findings

The analysis highlighted differences in cancellation and completion performance across locations and vehicle combinations.

- **Vinobapuri, Akshardham, and Munirka** emerged as priority locations for further investigation.
- Certain location-and-vehicle combinations showed elevated driver-cancellation rates.
- Potential cancellation reasons differed between combinations.
- The findings suggested collecting more structured driver feedback and measuring the impact of future interventions.

These are exploratory findings, not proof of causation. Further investigation is needed before implementing operational changes.

## Setup Instructions

### 1. Install Python

Install a compatible Python version if it is not already available.

### 2. Clone the repository

```bash
git clone <YOUR_REPOSITORY_URL>
cd CityFlow
```

### 3. Create a virtual environment

On Windows:

```powershell
python -m venv .venv
.venv\Scripts\activate
```

### 4. Install dependencies

```bash
pip install -r requirements.txt
```

### 5. Add the dataset

Place the permitted dataset at:

```text
data/ncr_ride_bookings.csv
```

If the dataset cannot be redistributed, obtain it from its original source and follow its licence terms.

### 6. Create the SQLite database

Run from the project root:

```bash
python sql/setup_database.py
```

This creates `sql/cityflow.db` and loads the data into a table named `bookings`.

### 7. Run the SQL analysis

Open `sql/analysis.sql` in your SQLite-compatible SQL editor and execute the queries against the generated database.

## Limitations

The analysis identifies patterns and potential operational issues, but does not establish causation. Results should be interpreted in light of data quality, sample sizes, and other factors that may affect ride completion.

## Future Improvements

- Add automated data-quality checks
- Create reusable KPI calculations
- Add tests for important analysis logic
- Develop an interactive dashboard
- Measure outcomes after operational interventions

## Author

Udit Dapkara

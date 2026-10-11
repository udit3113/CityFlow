
from pathlib import Path

import pandas as pd
import matplotlib.pyplot as plt

# Locate the CityFlow project folder
PROJECT_ROOT = Path(__file__).resolve().parent.parent

DATA_PATH = PROJECT_ROOT / "data" / "ncr_ride_bookings.csv"
IMAGES_PATH = PROJECT_ROOT / "images"

IMAGES_PATH.mkdir(exist_ok=True)

# Load the dataset
df = pd.read_csv(DATA_PATH)

# Calculate the overall completion rate
overall_rate = (
    (df["Booking Status"] == "Completed").mean() * 100
)

# Analyse our three priority locations
priority_locations = [
    "Vinobapuri",
    "Akshardham",
    "Munirka",
]

location_data = df[
    df["Pickup Location"].isin(priority_locations)
].copy()

results = (
    location_data.groupby("Pickup Location")
    .agg(
        total_bookings=("Booking Status", "size"),
        completed_rides=(
            "Booking Status",
            lambda status: (status == "Completed").sum()
        ),
    )
    .reset_index()
)

results["completion_rate"] = (
    results["completed_rides"]
    / results["total_bookings"]
    * 100
)

# Add the overall platform rate for comparison
results = pd.concat(
    [
        results,
        pd.DataFrame(
            [{
                "Pickup Location": "Platform Average",
                "total_bookings": len(df),
                "completed_rides": (
                    df["Booking Status"] == "Completed"
                ).sum(),
                "completion_rate": overall_rate,
            }]
        ),
    ],
    ignore_index=True,
)

# Sort bars from lowest to highest completion rate
results = results.sort_values("completion_rate")

# Create the chart
fig, ax = plt.subplots(figsize=(10, 6))

bars = ax.barh(
    results["Pickup Location"],
    results["completion_rate"],
)

ax.bar_label(
    bars,
    fmt="%.1f%%",
    padding=5,
)

ax.set_title(
    "Ride Completion Rate: Priority Locations vs Platform"
)
ax.set_xlabel("Completion Rate (%)")
ax.set_ylabel("Pickup Location")
ax.set_xlim(0, 100)

ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

fig.tight_layout()

output_path = IMAGES_PATH / "completion_rate_by_location.png"
fig.savefig(output_path, dpi=200, bbox_inches="tight")

plt.show()

print("\nCompletion Rate Summary:")
print(
    results[
        ["Pickup Location", "total_bookings", "completion_rate"]
    ].to_string(index=False)
)

print(f"\nChart saved to: {output_path}")


# -----------------------------------------
# CHART 2: Driver Cancellation Reasons
# -----------------------------------------

reason_column = "Driver Cancellation Reason"

# Keep only rows where the driver cancelled
driver_cancelled = df[
    df["Booking Status"] == "Cancelled by Driver"
].copy()

# Count each cancellation reason
reason_counts = (
    driver_cancelled[reason_column]
    .dropna()
    .value_counts()
    .sort_values()
)

# Calculate percentages among cancellations with a recorded reason
total_with_reason = reason_counts.sum()
reason_percentages = reason_counts / total_with_reason * 100

# Create the chart
fig, ax = plt.subplots(figsize=(10, 6))

bars = ax.barh(
    reason_counts.index.astype(str),
    reason_counts.values,
)

labels = [
    f"{count:,} ({percentage:.1f}%)"
    for count, percentage in zip(
        reason_counts.values,
        reason_percentages.values,
    )
]

ax.bar_label(bars, labels=labels, padding=5)

ax.set_title("Driver Cancellation Reasons")
ax.set_xlabel("Number of Cancellations")
ax.set_ylabel("Reported Reason")

ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

ax.set_xlim(0, reason_counts.max() * 1.25)
fig.tight_layout()

output_path = IMAGES_PATH / "driver_cancellation_reasons.png"
fig.savefig(output_path, dpi=200, bbox_inches="tight")
plt.show()

print("\nDriver Cancellation Reasons:")
print(
    pd.DataFrame({
        "reason": reason_counts.index,
        "count": reason_counts.values,
        "percentage": reason_percentages.values.round(2),
    }).to_string(index=False)
)

print(f"\nChart saved to: {output_path}")



# -----------------------------------------
# CHART 3: Location x Vehicle Combinations
# -----------------------------------------

combinations = [
    ("Vinobapuri", "Go Sedan"),
    ("Akshardham", "eBike"),
    ("Munirka", "Go Sedan"),
]

combination_results = []

for location, vehicle in combinations:
    subset = df[
        (df["Pickup Location"] == location)
        & (df["Vehicle Type"] == vehicle)
    ]

    total_bookings = len(subset)

    driver_cancellations = (
        subset["Booking Status"] == "Cancelled by Driver"
    ).sum()

    cancellation_rate = (
        driver_cancellations / total_bookings * 100
        if total_bookings > 0
        else 0
    )

    combination_results.append({
        "combination": f"{location} x {vehicle}",
        "total_bookings": total_bookings,
        "driver_cancellations": driver_cancellations,
        "cancellation_rate": cancellation_rate,
    })

combination_df = pd.DataFrame(combination_results)
combination_df = combination_df.sort_values("cancellation_rate")

fig, ax = plt.subplots(figsize=(10, 6))

bars = ax.barh(
    combination_df["combination"],
    combination_df["cancellation_rate"],
)

labels = [
    f"{rate:.2f}%  ({count} cancellations / {bookings} bookings)"
    for rate, count, bookings in zip(
        combination_df["cancellation_rate"],
        combination_df["driver_cancellations"],
        combination_df["total_bookings"],
    )
]

ax.bar_label(bars, labels=labels, padding=6)

ax.set_title("Driver Cancellation Rate by Location and Vehicle")
ax.set_xlabel("Driver Cancellation Rate (%)")
ax.set_ylabel("Location x Vehicle")

ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

ax.set_xlim(
    0,
    combination_df["cancellation_rate"].max() * 1.65,
)

fig.tight_layout()

output_path = IMAGES_PATH / "location_vehicle_cancellation_rates.png"
fig.savefig(output_path, dpi=200, bbox_inches="tight")
plt.show()

print("\nLocation x Vehicle Cancellation Analysis:")
print(combination_df.to_string(index=False))
print(f"\nChart saved to: {output_path}")

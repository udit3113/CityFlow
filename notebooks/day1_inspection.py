import pandas as pd  

df = pd.read_csv("data/ncr_ride_bookings.csv")

print(df.shape) 
print(df.columns) 

print(df["Cancelled Rides by Customer"].value_counts(dropna=False))  
print(df["Booking Status"].value_counts(dropna=False)) 
print(df["Incomplete Rides Reason"].value_counts(dropna=False)) 
print(df["Cancelled Rides by Driver"].value_counts(dropna=False)) 
print(df["Reason for cancelling by Customer"].value_counts(dropna=False)) 
print(df["Vehicle Type"].value_counts(dropna=False))
print(df["Pickup Location"].value_counts(dropna=False)) 
print(df["Pickup Location"].value_counts().tail(10))
print(df["Drop Location"].value_counts(dropna=False))   
print(pd.to_datetime(df["Time"]).dt.hour.value_counts())

completed_rides = df[df["Booking Status"] == "Completed"]
print(completed_rides.shape) 

two_wheeler = ["Bike", "eBike"] 
four_wheeler = ["Auto", "Go Mini", "Go Sedan", "Premier Sedan", "Uber XL"] 
two_count = 0 
four_count = 0 
for vehicle in completed_rides["Vehicle Type"]:
    if vehicle in two_wheeler: 
        two_count += 1
    elif vehicle in four_wheeler:
        four_count += 1 
    else:
        pass 

print(two_count,four_count) 

print(completed_rides["Pickup Location"].value_counts().head(10)) 
print(completed_rides["Pickup Location"].value_counts().tail(10)) 

print(completed_rides.groupby("Pickup Location")["Ride Distance"].mean().sort_values(ascending=False))
print(completed_rides.groupby("Pickup Location")["Booking Value"].mean().sort_values(ascending=False)) 
print(completed_rides.groupby("Pickup Location")["Booking Value"].sum().sort_values(ascending=False)) 

cancelled_rides = df[df["Booking Status"].isin(["Cancelled by Driver", "Cancelled by Customer"])] 
print(cancelled_rides.shape)
print(cancelled_rides["Pickup Location"].value_counts()) 

cancelled_count = cancelled_rides["Pickup Location"].value_counts()
total_count = df["Pickup Location"].value_counts()
print(cancelled_count)
print(total_count) 

cancellation_rate = (cancelled_count / total_count) * 100
cancellation_rate = cancellation_rate.sort_values(ascending=False) 
print(cancellation_rate.head(10))
print(total_count[cancellation_rate.head(10).index]) 

print(
    completed_rides.groupby("Pickup Location")["Ride Distance"]
    .mean()
    .sort_values(ascending=False)
    .head(10)
)

print(completed_rides.groupby("Pickup Location")["Booking Value"].sum().sort_values(ascending=False).head(10))
print(completed_rides.groupby("Pickup Location")["Booking Value"].mean().sort_values(ascending=False).head(10))

print(df.isnull().sum())
print(df[df["Booking Value"].isnull()]["Booking Status"].value_counts()) 
print(df[df["Booking Status"] == "Incomplete"]["Booking Value"].isnull().sum())

print(df.duplicated().sum())

print(df.dtypes)

print(df[df["Booking Value"].isna()]["Booking Status"].value_counts())
print(df[df["Driver Ratings"].isna()]["Booking Status"].value_counts())
print(df[df["Customer Rating"].isna()]["Booking Status"].value_counts())
print(df[df["Avg VTAT"].isna()]["Booking Status"].value_counts())
print(df[df["Avg CTAT"].isna()]["Booking Status"].value_counts())
print(df[df["Ride Distance"].isna()]["Booking Status"].value_counts())
print(df[df["Payment Method"].isna()]["Booking Status"].value_counts())
print(df.isnull().sum()[df.isnull().sum() > 0])
print(df[df["Cancelled Rides by Customer"].notna()]["Booking Status"].value_counts())
print(df["Cancelled Rides by Driver"].value_counts(dropna=False))
print(df["Cancelled Rides by Customer"].value_counts(dropna=False))
print(df["Incomplete Rides"].value_counts(dropna=False))
print(df["Reason for cancelling by Customer"].value_counts(dropna=False))
print(df["Driver Cancellation Reason"].value_counts(dropna=False))
print(df["Incomplete Rides Reason"].value_counts(dropna=False))

print((df["Booking Value"] < 0).sum())
print((df["Ride Distance"] < 0).sum())

print(df["Driver Ratings"].min())
print(df["Driver Ratings"].max())

print(df["Customer Rating"].min())
print(df["Customer Rating"].max())

print((df["Avg VTAT"] < 0).sum())
print((df["Avg CTAT"] < 0).sum())

df.info()

print(df["Date"].head())
print(df["Time"].head())

df["Date"] = pd.to_datetime(df["Date"])
print(df["Date"].dtype)

df["Time"] = pd.to_datetime(df["Time"], format="%H:%M:%S")
print(df["Time"].dtype)

print(df["Date"].isna().sum())
print(df["Time"].isna().sum())

print(df["Booking Status"].value_counts())

df["Cancelled Rides by Customer"] = df["Cancelled Rides by Customer"].fillna(0)
print(df["Cancelled Rides by Customer"].value_counts())

df["Cancelled Rides by Driver"] = df["Cancelled Rides by Driver"].fillna(0)
print(df["Cancelled Rides by Driver"].value_counts())

df["Incomplete Rides"] = df["Incomplete Rides"].fillna(0)
print(df["Incomplete Rides"].value_counts())

print(df["Cancelled Rides by Customer"].isnull().sum())
print(df["Cancelled Rides by Driver"].isnull().sum())
print(df["Incomplete Rides"].isnull().sum())

#day2 is finished - cleaning 

customer_cancelled = df["Cancelled Rides by Customer"].sum()
driver_cancelled = df["Cancelled Rides by Driver"].sum()

print("Customer cancellations:", customer_cancelled)
print("Driver cancellations:", driver_cancelled)

customer_cancelled_rate = (customer_cancelled / len(df)) * 100
driver_cancelled_rate = (driver_cancelled / len(df)) * 100

print("Customer cancellation rate:", customer_cancelled_rate)
print("Driver cancellation rate:", driver_cancelled_rate)

print(df["Reason for cancelling by Customer"].value_counts())

customer_cancel_reasons = df["Reason for cancelling by Customer"].value_counts()

customer_cancel_reason_percentage = (
    customer_cancel_reasons / customer_cancelled
) * 100

print(customer_cancel_reason_percentage)


print(df["Driver Cancellation Reason"].value_counts())

driver_cancel_reasons = df["Driver Cancellation Reason"].value_counts()

driver_cancel_reason_percentage = (driver_cancel_reasons / driver_cancelled ) * 100 

print(driver_cancel_reason_percentage)

df["Hour"] = df["Time"].dt.hour
print(df["Hour"].head()) 

driver_cancelled_rides = df[
    df["Booking Status"] == "Cancelled by Driver"
]

print(driver_cancelled_rides.shape)

print(driver_cancelled_rides["Vehicle Type"].value_counts())

vehicle_total = df["Vehicle Type"].value_counts()
driver_cancel_rate_by_vehicle = (
    driver_cancelled_rides["Vehicle Type"].value_counts()
    / vehicle_total
) * 100

print(driver_cancel_rate_by_vehicle.sort_values(ascending=False))


driver_cancelled_by_hour = driver_cancelled_rides["Hour"].value_counts()

print(driver_cancelled_by_hour.sort_index())

total_bookings_by_hour = df["Hour"].value_counts()
print(total_bookings_by_hour.sort_index())

driver_cancel_rate_by_hour = (
    driver_cancelled_by_hour / total_bookings_by_hour
) * 100

print(driver_cancel_rate_by_hour.sort_index())

driver_cancelled_by_area = driver_cancelled_rides["Pickup Location"].value_counts()
print(driver_cancelled_by_area.head(10))

total_bookings_by_area = df["Pickup Location"].value_counts()
print(total_bookings_by_area.head(10))

driver_cancel_rate_by_area = (
    driver_cancelled_by_area / total_bookings_by_area
) * 100

print(driver_cancel_rate_by_area.sort_values(ascending=False).head(10))

customer_cancelled_rides = df[
    df["Booking Status"] == "Cancelled by Customer"
]

customer_cancelled_by_vehicle = (
    customer_cancelled_rides["Vehicle Type"].value_counts()
)

print(customer_cancelled_by_vehicle)

customer_cancel_rate_by_vehicle = (
    customer_cancelled_by_vehicle / vehicle_total
) * 100

print(customer_cancel_rate_by_vehicle.sort_values(ascending=False))

print(customer_cancelled_rides.groupby(
    ["Vehicle Type", "Reason for cancelling by Customer"]
).size())

customer_cancel_reason_by_vehicle_percentage = (
    customer_cancelled_rides.groupby(
        ["Vehicle Type", "Reason for cancelling by Customer"]
    ).size()
    / customer_cancelled_rides.groupby("Vehicle Type").size()
) * 100

print(customer_cancel_reason_by_vehicle_percentage) 

customer_cancelled_by_area = (
    customer_cancelled_rides["Pickup Location"].value_counts()
)

total_bookings_by_area = df["Pickup Location"].value_counts()

customer_cancel_rate_by_area = (
    customer_cancelled_by_area / total_bookings_by_area
) * 100

print(
    customer_cancel_rate_by_area
    .sort_values(ascending=False)
    .head(10)
)

customer_rate_by_area = (
    customer_cancelled_by_area / total_bookings_by_area
) * 100

driver_rate_by_area = (
    driver_cancelled_by_area / total_bookings_by_area
) * 100

area_cancellation_rates = pd.DataFrame({
    "Customer Cancellation Rate": customer_rate_by_area,
    "Driver Cancellation Rate": driver_rate_by_area
})

print(area_cancellation_rates.head(10))

both_high = area_cancellation_rates[
    (area_cancellation_rates["Customer Cancellation Rate"] > 7) &
    (area_cancellation_rates["Driver Cancellation Rate"] > 18)
]

print(both_high.sort_values(
    "Customer Cancellation Rate",
    ascending=False
).head(10))

high_both_areas = both_high.index

customer_high_both = customer_cancelled_rides[
    customer_cancelled_rides["Pickup Location"].isin(high_both_areas)
]

print(
    customer_high_both["Reason for cancelling by Customer"]
    .value_counts()
)

customer_reason_counts_high = (
    customer_high_both["Reason for cancelling by Customer"]
    .value_counts()
)

customer_reason_percentage_high = (
    customer_reason_counts_high
    / customer_reason_counts_high.sum()
) * 100

print(customer_reason_percentage_high)

driver_high_both = driver_cancelled_rides[
    driver_cancelled_rides["Pickup Location"].isin(high_both_areas)
]

print(
    driver_high_both["Driver Cancellation Reason"]
    .value_counts()
)

driver_reason_counts_high = (
    driver_high_both["Driver Cancellation Reason"]
    .value_counts()
)

driver_reason_percentage_high = (
    driver_reason_counts_high
    / driver_reason_counts_high.sum()
) * 100

print(driver_reason_percentage_high)

booking_value_by_vehicle = (
    completed_rides.groupby("Vehicle Type")["Booking Value"]
    .sum()
    .sort_values(ascending=False)
)

print(booking_value_by_vehicle)

avg_booking_value_by_vehicle = (
    completed_rides.groupby("Vehicle Type")["Booking Value"]
    .mean()
    .sort_values(ascending=False)
)

print(avg_booking_value_by_vehicle)

booking_value_share = (
    booking_value_by_vehicle / booking_value_by_vehicle.sum()
) * 100

print(booking_value_share)

avg_distance_by_vehicle = (
    completed_rides.groupby("Vehicle Type")["Ride Distance"]
    .mean()
    .sort_values(ascending=False)
)

print(avg_distance_by_vehicle)

avg_booking_value_by_area = (
    completed_rides.groupby("Pickup Location")["Booking Value"]
    .mean()
    .sort_values(ascending=False)
)

print(avg_booking_value_by_area.head(10)) 

avg_distance_by_area = (
    completed_rides.groupby("Pickup Location")["Ride Distance"]
    .mean()
    .sort_values(ascending=False)
)

print(avg_distance_by_area.head(10))

correlation = completed_rides["Ride Distance"].corr(
    completed_rides["Booking Value"]
)

print(correlation)

rating_correlation = completed_rides["Customer Rating"].corr(
    completed_rides["Driver Ratings"]
)

print(rating_correlation)

payment_method_counts = (
    completed_rides["Payment Method"]
    .value_counts()
)

print(payment_method_counts)

payment_method_percentage = (
    payment_method_counts / payment_method_counts.sum()
) * 100

print(payment_method_percentage)

avg_booking_value_by_payment = (
    completed_rides.groupby("Payment Method")["Booking Value"]
    .mean()
    .sort_values(ascending=False)
)

print(avg_booking_value_by_payment)

payment_total = df["Payment Method"].value_counts()

payment_cancelled = (
    df[df["Booking Status"].isin(
        ["Cancelled by Customer", "Cancelled by Driver"]
    )]["Payment Method"].value_counts()
)

payment_cancellation_rate = (
    payment_cancelled / payment_total
) * 100

print(payment_cancellation_rate.sort_values(ascending=False))

payment_cancelled = (
    df[df["Booking Status"].isin(
        ["Cancelled by Customer", "Cancelled by Driver"]
    )]["Payment Method"].value_counts(dropna=False)
)

print(payment_cancelled)

rating_by_vehicle = completed_rides.groupby("Vehicle Type")[
    ["Customer Rating", "Driver Ratings"]
].mean()

print(rating_by_vehicle)

top_routes = (
    completed_rides.groupby(
        ["Pickup Location", "Drop Location"]
    ).size()
    .sort_values(ascending=False)
)

print(top_routes.head(10))

top_drop_locations = (
    completed_rides["Drop Location"]
    .value_counts()
)

print(top_drop_locations.head(10))

customer_booking_counts = df["Customer ID"].value_counts()

print(customer_booking_counts.head(10))

one_time_customers = (customer_booking_counts == 1).sum()
repeat_customers = (customer_booking_counts >= 2).sum()

total_customers = customer_booking_counts.count()

print("Total customers:", total_customers)
print("One-time customers:", one_time_customers)
print("Repeat customers:", repeat_customers)

print("One-time %:", (one_time_customers / total_customers) * 100)
print("Repeat %:", (repeat_customers / total_customers) * 100)

#day3 is completed 

df["Day"] = df["Date"].dt.day_name()

print(df["Day"].value_counts())

hourly_bookings = df["Hour"].value_counts().sort_index()

print(hourly_bookings)

def get_time_period(hour):
    if hour < 5:
        return "Night"
    elif hour < 12:
        return "Morning"
    elif hour < 17:
        return "Afternoon"
    else:
        return "Evening"


df["Time Period"] = df["Hour"].apply(get_time_period)

print(df["Time Period"].value_counts())

vehicle_time = pd.crosstab(
    df["Time Period"],
    df["Vehicle Type"]
)

print(vehicle_time)

vehicle_time_percentage = pd.crosstab(
    df["Time Period"],
    df["Vehicle Type"],
    normalize="index"
) * 100

print(vehicle_time_percentage.round(2))

cancelled_by_period = df[
    df["Booking Status"].isin(
        ["Cancelled by Customer", "Cancelled by Driver"]
    )
]["Time Period"].value_counts()

total_by_period = df["Time Period"].value_counts()

cancellation_rate_by_period = (
    cancelled_by_period / total_by_period
) * 100

print(cancellation_rate_by_period.sort_values(ascending=False).round(2))

df["Day Type"] = df["Day"].apply(
    lambda day: "Weekend" if day in ["Saturday", "Sunday"] else "Weekday"
)

print(df["Day Type"].value_counts())

daily_demand = df.groupby(["Date", "Day Type"]).size()

print(daily_demand.groupby("Day Type").mean())

daily_bookings = df.groupby("Date").size()

print(daily_bookings.describe())

print("Highest demand day:")
print(daily_bookings.idxmax(), daily_bookings.max())

print("\nLowest demand day:")
print(daily_bookings.idxmin(), daily_bookings.min())

#day4 complete

print(completed_rides.groupby("Pickup Location")["Booking Value"].sum().sort_values(ascending=False))

print(completed_rides["Pickup Location"].value_counts())

print(completed_rides.groupby("Pickup Location")["Booking Value"].mean().sort_values(ascending=False))

print(completed_rides["Ride Distance"].corr(
    completed_rides["Booking Value"]
))

print(completed_rides.groupby("Vehicle Type")["Booking Value"].sum().sort_values(ascending=False))

print(completed_rides["Vehicle Type"].value_counts())

print(completed_rides.groupby("Vehicle Type")["Ride Distance"].mean().sort_values(ascending=False))

print(completed_rides.groupby("Pickup Location").agg({
    "Booking Value": "mean",
    "Booking ID": "count"
}).sort_values("Booking Value", ascending=False))

print(completed_rides.groupby("Pickup Location")["Booking Value"].sum().sort_values(ascending=False))

cancellation_rate = (cancelled_count / total_count) * 100
cancellation_rate = cancellation_rate.sort_values(ascending=False)

print(cancellation_rate)

print(df.groupby("Pickup Location")[
    ["Cancelled Rides by Customer", "Cancelled Rides by Driver"]
].sum())


area_cancellation_rates = pd.DataFrame({
    "Customer Cancellation Rate": customer_rate_by_area,
    "Driver Cancellation Rate": driver_rate_by_area
})

print(area_cancellation_rates.sort_values(
    "Driver Cancellation Rate",
    ascending=False
))

both_high = area_cancellation_rates[
    (area_cancellation_rates["Customer Cancellation Rate"] > 7) &
    (area_cancellation_rates["Driver Cancellation Rate"] > 18)
]

print(both_high)

high_both_areas = both_high.index

high_both_data = df[df["Pickup Location"].isin(high_both_areas)]
print(high_both_data)

customer_cancelled_high_both = high_both_data[
    high_both_data["Booking Status"] == "Cancelled by Customer"
]

print(customer_cancelled_high_both.shape) 

print(customer_cancelled_high_both["Reason for cancelling by Customer"].value_counts())

driver_cancelled_high_both = high_both_data[high_both_data["Booking Status"] == "Cancelled by Driver"]
 
print(driver_cancelled_high_both["Driver Cancellation Reason"].value_counts())

total_bookings_by_area = df["Pickup Location"].value_counts()
print(total_bookings_by_area)

area_summary = pd.DataFrame({
    "Total Bookings": total_bookings_by_area,
    "Cancellation Rate": cancellation_rate
})

print(area_summary)

booking_threshold = total_bookings_by_area.quantile(0.75)
print(booking_threshold)

high_volume_high_cancellation = area_summary[
    (area_summary["Total Bookings"] > 869.25) &
    (area_summary["Cancellation Rate"] > 25)
]

print(high_volume_high_cancellation)

high_volume_data = df[
    df["Pickup Location"].isin(high_volume_high_cancellation.index)
]
print(high_volume_data.shape)

print(high_volume_data.groupby("Booking Status").size())

high_volume_customer_cancelled = high_volume_data[
    high_volume_data["Booking Status"] == "Cancelled by Customer"
]

print(high_volume_customer_cancelled[
    "Reason for cancelling by Customer"
].value_counts())

high_volume_driver_cancelled = high_volume_data[
    high_volume_data["Booking Status"] == "Cancelled by Driver"
]

print(high_volume_driver_cancelled[
    "Driver Cancellation Reason"
].value_counts())

high_volume_completed = high_volume_data[
    high_volume_data["Booking Status"] == "Completed"
]

print(high_volume_completed.groupby("Pickup Location")["Booking Value"].sum().sort_values(
    ascending=False
).head(10))

area_business_summary = high_volume_data.groupby("Pickup Location").agg(
    Total_Bookings=("Booking ID", "count"),
    Cancellation_Rate=("Booking Status", lambda x: (x.isin(
        ["Cancelled by Customer", "Cancelled by Driver"]
    ).sum() / len(x)) * 100),
    Completed_Booking_Value=("Booking Value", lambda x: x[high_volume_data.loc[x.index, "Booking Status"] == "Completed"].sum())
)

print(area_business_summary.sort_values(
    "Cancellation_Rate", ascending=False
).head(10))

average_value = high_volume_completed.groupby(
    "Pickup Location"
)["Booking Value"].mean().sort_values(ascending=False)

print(average_value.head(10))


import matplotlib.pyplot as plt

vehicle_counts = df["Vehicle Type"].value_counts()

vehicle_counts.plot(kind="bar")

plt.title("Bookings by Vehicle Type")
plt.xlabel("Vehicle Type")
plt.ylabel("Number of Bookings")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

hourly_bookings = df["Hour"].value_counts().sort_index()

hourly_bookings.plot(kind="line", marker="o")

plt.title("Bookings by Hour")
plt.xlabel("Hour of Day")
plt.ylabel("Number of Bookings")
plt.xticks(range(24))
plt.grid()
plt.tight_layout()
plt.show()

top_pickup_areas = df["Pickup Location"].value_counts().head(10)

top_pickup_areas.plot(kind="bar")

plt.title("Top 10 Pickup Areas by Bookings")
plt.xlabel("Pickup Area")
plt.ylabel("Number of Bookings")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

top_cancellation_areas = cancellation_rate.head(10)

top_cancellation_areas.plot(kind="bar")

plt.title("Top 10 Areas by Cancellation Rate")
plt.xlabel("Pickup Area")
plt.ylabel("Cancellation Rate (%)")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

cancellation_types = pd.Series({
    "Customer": customer_cancelled,
    "Driver": driver_cancelled
})

cancellation_types.plot(kind="bar")

plt.title("Customer vs Driver Cancellations")
plt.xlabel("Cancellation Type")
plt.ylabel("Number of Cancellations")
plt.xticks(rotation=0)
plt.tight_layout()
plt.show()

top_value_areas = high_volume_completed.groupby(
    "Pickup Location"
)["Booking Value"].sum().sort_values(ascending=False).head(10)

top_value_areas.plot(kind="bar")

plt.title("Top 10 Areas by Completed Booking Value")
plt.xlabel("Pickup Area")
plt.ylabel("Completed Booking Value (₹)")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

#day5 doneeee



import pandas as pd
import matplotlib.pyplot as plt


# Load CSV while skipping lines starting with '#'
df = pd.read_csv("firebase_events.csv", comment="#")

# Keep only the relevant columns
df = df[["Event name", "Event count", "Total users", "Event count per active user"]]

# Set Event name as index
df.set_index("Event name", inplace=True)

# --- Summary ---
print("Summary Statistics:")
print(df)

print("\nTotal Events Logged:", df["Event count"].sum())
print("Unique Event Types:", len(df))

# --- Visualization 1: Event Counts ---
ax = df["Event count"].plot(kind="bar", figsize=(8,5), color="skyblue", edgecolor="black")
ax.set_title("Firebase Event Counts")
ax.set_ylabel("Event Count")
plt.xticks(rotation=45, ha="right")
plt.tight_layout()
plt.show()

# --- Visualization 2: Events Per Active User ---
ax = df["Event count per active user"].plot(kind="bar", figsize=(8,5), color="orange", edgecolor="black")
ax.set_title("Events Per Active User")
ax.set_ylabel("Count")
plt.xticks(rotation=45, ha="right")
plt.tight_layout()
plt.show()

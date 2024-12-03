terraform {
  required_providers {
    time = {
      source = "hashicorp/time"
      # Setting the provider version is a strongly recommended practice
      # version = "..."
    }
  }
  # Provider functions require Terraform 1.8 and later.
  required_version = ">= 1.8.0"
}


# ==========================================================
# Core Date and Time Functions
# ==========================================================
# Functions covered:
# 1. timestamp()
# 2. timeadd(timestamp, duration)
# 3. formatdate(format, timestamp)
# 4. uuid()

# Locals Section
# --------------
# Use the `locals` block for dynamically evaluated values like timestamp.
locals {
  current_time = timestamp() # Automatically gets the current UTC time.
}


# 1. Timestamp Function
# Returns the current UTC time as an ISO 8601 string.
output "current_timestamp" {
  value = local.current_time
}
# Example Output: "2024-11-27T14:30:00Z"


# 2. Timeadd Function
# Adds a duration to a timestamp. Duration must be in the ISO 8601 format.
# Example: "1h" (1 hour), "30m" (30 minutes), "1d" (1 day), etc.
output "timeadd_example" {
  value = timeadd(local.current_time, "1h")
}
# Output: Current timestamp + 1 hour. Example: "2024-11-27T15:30:00Z"

output "timeadd_days_example" {
  value = timeadd(local.current_time, "72h")
}
# Output: Current timestamp + 3 days. Example: "2024-11-30T14:30:00Z"


# 3. Formatdate Function
# Converts a timestamp to a custom date format.
# Common date formatting symbols:
#   %Y = Year (4 digits), %y = Year (2 digits)
#   %m = Month (2 digits), %d = Day (2 digits)
#   %H = Hour (24-hour format), %M = Minute, %S = Second
output "formatdate_example" {
  value = formatdate("YYYY-MM-DD", local.current_time)
}
# Output: "2024-11-27" (Year-Month-Day)

output "formatdate_time_example" {
  value = formatdate("hh:mm:ss", local.current_time)
}
# Output: "14:30:00" (Hour:Minute:Second)


# 4. UUID Function
# Generates a unique identifier (UUID version 4).
output "uuid_example" {
  value = uuid()
}
# Output: Example: "e4eaaaf2-d142-11e1-b3e4-080027620cdd"


# =============================
# Extended Date and Time Functions
# =============================
# Functions covered:
# 5. parseint(string, base)
# 6. RFC3339 Time Parsing Example
# 7. epoch(timestamp)


# 5. Parseint Function (Helpful for Date Calculations)
# Converts a string to an integer. Can be used to extract date components.
output "parseint_example" {
  value = parseint(formatdate("YYYY", local.current_time), 10)
}
# Output: 2024 (Extracts the year as an integer)


# 6. RFC3339 Time Parsing Example
# Converts a timestamp to the number of seconds since January 1, 1970 (Unix epoch).
output "parse" {
  value = provider::time::rfc3339_parse(local.current_time)
}
# Output: parse = {
/*          "day" = 27
            "hour" = 13
            "iso_week" = 48
            "iso_year" = 2024
            "minute" = 1
            "month" = 11
            "month_name" = "November"
            "second" = 34
            "unix" = 1732712494
            "weekday" = 3
            "weekday_name" = "Wednesday"
            "year" = 2024
            "year_day" = 332
         }*/


# 7. Epoch Function
output "Unix" {
  value = provider::time::rfc3339_parse(local.current_time).unix
}
# Output: Number of seconds since 1970. Example: "1732071000"


# =============================
# Conclusion
# =============================
# This file demonstrates Terraform's date and time manipulation functions

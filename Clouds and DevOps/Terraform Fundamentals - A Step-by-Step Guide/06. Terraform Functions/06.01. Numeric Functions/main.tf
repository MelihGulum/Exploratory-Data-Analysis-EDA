# ==========================================================
# Core Numeric Functions
# ==========================================================
# Functions covered:
# 1. abs(number)
# 2. ceil(number)
# 3. floor(number)
# 4. min(number1, number2, ...)
# 5. max(number1, number2, ...)
# 6. pow(base, exponent)


# 1. Abs Function
# Returns the absolute value of a number (removes the sign).
output "abs_example" {
  value = abs(var.num1)
}
# Output: 15


# 2. Ceil Function
# Rounds a number up to the nearest whole number.
output "ceil_example" {
  value = ceil(var.num1)
}
# Output: -15


# 3. Floor Function
# Rounds a number down to the nearest whole number.
output "floor_example" {
  value = floor(var.num2)
}
# Output: 7


# 4. Min Function
# Returns the smallest value from a list of numbers or a set of inputs.
output "min_example" {
  value = min(var.num_list...)
}
# Output: -2


# 5. Max Function
# Returns the largest value from a list of numbers or a set of inputs.
output "max_example" {
  value = max(var.num_list...)
}
# Output: 10


# 6. Pow Function
# Raises a number to the power of another number.
output "pow_example" {
  value = pow(2, 3) # Equivalent to 2^3
}
# Output: 8


# ==========================================================
# Extended Numeric Functions
# ==========================================================
# Functions covered:
# 7. signum(number)
# 8. modulo(number, divisor)


# 7. Signum Function
# Returns -1 for negative numbers, 1 for positive numbers, and 0 for zero.
output "signum_example" {
  value = signum(var.num1)
}
# Output: -1


# 8. Modulo Function
# Returns the remainder of dividing one number by another.
output "modulo_example" {
  value = var.num1 % var.num2
}
# Output: -0.75


# =============================
# Numeric Operations on Lists
# =============================
# 9. sum(list of numbers)
# 10. Average Example (custom calculation)


# 9. Sum Function
# Computes the sum of all elements in a list.
output "sum_example" {
  value = sum(var.num_list)
}
# Output: 24

# 10. Average (Custom Example)
# Demonstrates calculating the average of a list of numbers.
output "average_example" {
  value = sum(var.num_list) / length(var.num_list)
}
# Output: 4.8



# ==========================================================
# Conclusion
# ==========================================================
# This file demonstrates Terraform's numeric manipulation functions.
# Try applying this file with `terraform apply` to see the outputs.
# Experiment with your own numbers to explore these functions further!

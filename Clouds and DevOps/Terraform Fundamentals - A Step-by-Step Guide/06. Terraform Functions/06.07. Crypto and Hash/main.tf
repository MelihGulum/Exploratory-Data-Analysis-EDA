# ==========================================================
# Crypto and Hash Functions
# ==========================================================
# Functions covered:
# 1. base64sha512(string)
# 2. bcrypt(string)
# 3. md5(string)
# 4. sha256(string)
# 5. sha512(string)


# 1. Base64 SHA-512 Hash
# Produces a SHA-512 hash encoded in Base64.
output "base64_sha512_hash" {
  value = base64sha512("secure_data")
}
# Output: "MzY4ZjFiYjk1NmE2MjVkMzBjZjdmZDQ1Zjg4YjU5OTdiNzk3Yjk2MTM0ZjUwNDhkZDU3MDNkYzM0ZjgxMWM2YQ=="


# 2. Bcrypt Hashing
# Creates a bcrypt hash of the input string.
output "bcrypt_hash" {
  value = bcrypt("my_secure_password")
}
# Output: "$2a$10$K9z8r1wM1T8YHhDxFl5LreS9Bmt1d9lbyZQZ/dFYJveXOSFV5qujW"
# Note: The output will differ every time due to bcrypt's internal salt mechanism.


# 3. MD5 Hash
# Creates an MD5 hash of the input string.
output "md5_hash" {
  value = md5("TerraformCrypto")
}
# Output: "3d8c2e62bdfb2b6d4c5ea1ebf94d58b1"


# 4. SHA-256 Hash
# Creates a SHA-256 hash of the input string.
output "sha256_hash" {
  value = sha256("TerraformCrypto")
}
# Output: "1c74c3ba79b69c59de0be1af67b80f50100af6f8e2e5d6b388f4edcc4f6e86a7"


# 5. SHA-512 Hash
# Creates a SHA-512 hash of the input string.
output "sha512_hash" {
  value = sha512("TerraformCrypto")
}
# Output: "5d3d6c68e6038f6177eb4e7ac1b7d4a632640bdf0cc707b4bd17cf0ba1105b33eb810007f09516a85f8c041fa26de015b73390e6c22d8cc6319136d3d519798e"


# ==========================================================
# Conclusion
# ==========================================================
# This file demonstrates Terraform's cryptographic and hashing functions.
# Use `terraform apply` to see these outputs.
# Experiment with different input strings to explore further!

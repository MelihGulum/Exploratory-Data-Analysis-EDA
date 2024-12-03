# **Terraform Functions**
Terraform includes a rich set of built-in functions that allow you to manipulate and transform data dynamically in your configurations. These functions are categorized into various types based on their purpose.


1. **Numeric Functions**
    * Numeric functions are used to perform mathematical operations or manipulations on numbers. They include operations like rounding, absolute values, and arithmetic calculations.
    * Examples: abs(), ceil(), floor(), max(), min(), sqrt()

2. **String Functions**
    * String functions help format and manipulate text data. These include operations like concatenation, searching, replacing, or extracting substrings.
    * Examples: join(), split(), replace(), upper(), lower(), trimspace()

3. **Collection Functions**
    * Collection functions operate on lists, maps, or sets. They enable filtering, merging, slicing, and querying.
    * Examples: length(), lookup(), merge(), keys(), values(), toset()

4. **Encoding and Decoding Functions**
    * These functions handle transformations between formats like Base64 and plain text. Useful for securely encoding data for transmission or storage.
    * Examples: base64encode(), base64decode(), jsondecode(), jsonencode()

5. **Filesystem Functions**
    * Filesystem functions interact with external files, allowing content to be read and included in your Terraform configuration. 
    * Examples: file(), filebase64(), templatefile()

6. **Date-Time Functions**
    * Date-time functions work with timestamps, allowing you to manipulate or extract date and time information. 
    * Examples: timeadd(), timestamp(), formatdate()

7. **Crypto and Hash Functions**
    * These functions generate hashes, perform cryptographic operations, or check data integrity. 
    * Examples: md5(), sha256(), bcrypt(), uuid()

8. **Type Conversion Functions**
    * Type conversion functions allow you to change one data type into another, such as strings to numbers, lists to sets, or maps to JSON. 
    * Examples: tostring(), tolist(), tomap(), toset()

## **Key Takeaways**
* **Dynamic Configurations:** Functions empower you to build dynamic, reusable configurations tailored to specific requirements.
* **Combining Functions:** Functions can be nested for complex transformations. For instance, combining join() and upper() to format strings.
* **Error Handling:** Always validate inputs to avoid runtime errors, especially with type-sensitive functions like lookup() or jsondecode()
# **Terraform Operators**
Terraform provides a variety of operators to perform arithmetic, equality, comparison, and logical operations. These operators are essential for building dynamic configurations and making decisions based on variables and conditions.

1. **Arithmetic Operators**
    * Arithmetic operators are used to perform basic mathematical calculations. They work with numeric values and support integer and float types.

| Operator | Description          | Example | Result |
|:---------|:---------------------|:-------:|:------:|
| +        | Addition             |  5 + 3  |   8    |
| -        | Subtraction          | 10 - 3  |   7    |
| *        | Multiplication       |  4 * 2  |   8    |
| /        | Division             |  8 / 2  |   4    |
| %        | Modulus (remainder)  |  7 / 3  |   1    |

2. **Equality Operators**
    * Equality operators compare two values and return a boolean (true or false). These are used in conditional expressions and loops.

| Operator | Description    |     Example     | Result |
|:---------|:---------------|:---------------:|:------:|
| ==       | Equal to       |  5 == 5         |  true  |
| !=       | Not equal to   | "hello" != "hi" |  true  |

3. **Comparison Operators**
Comparison operators compare numeric or string values and return a boolean (true or false).

| Operator | Description              | Example | Result |
|:---------|:-------------------------|:-------:|:------:|
| <        | Less than                | 5 < 10  |  true  |
| \>       | Greater than	           | 15 > 20 | false  |
| <=       | Less than or equal to    | 5 <= 5  |  true  |
| \>=      | Greater than or equal to | 10 >= 5 |  true  |

4. **Logical Operators**
    * Logical operators evaluate boolean expressions and return a boolean (true or false). They are commonly used in complex conditions.

| Operator | Description   |    Example    | Result  |
|:---------|:--------------|:-------------:|:-------:|
| &&       | Logical AND   | true && false |  false  |
| \|\|     | Logical OR 	| true && false |  true   |
| !        | Logical NOT   |     !true     |  false  |


## **Key Considerations:**
1. **Type Compatibility:**
    * Arithmetic and comparison operators work only on compatible types (e.g., numeric values for arithmetic, strings/numbers for comparison).
    * Equality operators can compare different types but may produce unexpected results.

2. **Chaining:**
    * You can combine logical operators to create complex conditions. Use parentheses for clarity.

```terraform 
condition = (var.is_production && var.traffic > 100) || var.emergency_mode
```

3. **Default Values:**
    * For variables, you can use conditional expressions and operators together to set default values based on logic.
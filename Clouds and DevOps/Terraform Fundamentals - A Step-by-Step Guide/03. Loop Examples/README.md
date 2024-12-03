# **Terraform Loops**

Terraform provides various mechanisms to iterate over collections and generate multiple resources or compute dynamic values. Below is an explanation and examples of the most commonly used looping constructs: 
  * count
  * for
  * for_each

1. **count**
   * The count meta-argument is used to create multiple instances of a resource or module by specifying the desired number.
   * Code Explanation:
     - count = 3: Creates three instances of the resource.
     - count.index: A zero-based index that uniquely identifies each instance.
     - Each instance gets a unique tag, like Instance-1, Instance-2, etc.
```terraform
resource "aws_instance" "example" {
  count         = 3
  ami           = "ami-012967cc5a8c9f891"
  instance_type = "t2.micro"
  tags = {
    Name = "Instance-${count.index + 1}"
  }
}
```

2. **for**
    * The for expression is used to create new collections (lists or maps) by transforming existing ones.
    * List Example Explanation:
      - Iterates over the var.names list. 
      - Creates a new list ["instance-dev", "instance-test", "instance-prod"].
    * Map Example Explanation:
      - Iterates over the var.instance_types map.
      - Produces a new map where the instance types are in uppercase.
```terraform
# List Example
variable "names" {
  default = ["dev", "test", "prod"]
}

output "instance_names" {
  value = [for name in var.names : "instance-${name}"]
}
```

```terraform
# Map Example
variable "instance_types" {
  default = {
    dev  = "t2.micro"
    prod = "t2.large"
  }
}

output "formatted_instance_types" {
  value = { for key, value in var.instance_types : key => upper(value) }
}
```

3. **for_each**
    * The for_each meta-argument is used to dynamically create resources or modules based on an iterable collection (list, map, or set)
      * List Example Explanation:
        - toset converts the list into a set to ensure unique values.
        - each.key: Represents the current value from the set ("dev", "test", "prod").
        - Creates a separate instance for each environment.
      * Map Example Explanation:
        - each.key: Represents the map key (e.g., "dev", "prod"). 
        - each.value: Represents the value (e.g., "t2.micro", "t2.large"). 
        - Dynamically provisions instances based on configurations in the map.

```terraform
# List Example
resource "aws_instance" "example" {
  for_each = toset(["dev", "test", "prod"])
  ami      = "ami-012967cc5a8c9f891"
  instance_type = "t2.micro"
  tags = {
    Name = "Instance-${each.key}"
  }
}
```

```terraform
# Map Example
variable "instance_configs" {
  default = {
    dev  = "t2.micro"
    prod = "t2.large"
  }
}

resource "aws_instance" "example" {
  for_each     = var.instance_configs
  ami          = "ami-012967cc5a8c9f891"
  instance_type = each.value
  tags = {
    Name = "Instance-${each.key}"
  }
}
```

## **Comparison**
| Construct          | Use Case                                       | Key Feature                                   |
|:-------------------|:-----------------------------------------------|:----------------------------------------------|
| count              | Fixed number of identical resources            | Simple and sequential.                        |
| for	              | Transform lists or maps into new collections   | Flexible and concise value transformations.   |
| for_each           | Create resources based on dynamic collections  | Works well with maps and ensures uniqueness.  |

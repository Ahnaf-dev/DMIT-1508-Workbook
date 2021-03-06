# Lab Template

> Your lab is to be submitted as a **Markdown** (`*.md`) file using the following legend. The recommended text editor for these files is [**Visual Studio Code**](https://code.visualstudio.com), as this editor allows you to preview your markdown document as HTML. ERDs can be created using [**Lucidchart**](https://www.lucidchart.com/) and exported as `*.png` files. Check with your instructor about getting a free *Lucidchart* account to use during this course.

## Legend

This legend is a guide to reading and interpreting the table listings under 0NF through 3NF.

- **TableName:** - Table names will be bolded and end with a colon. (e.g.: `**TableName:**`)
- (Column, Names) - Column names for a table will be enclosed in (rounded parenthesis).
- <b class="pk">PrimaryKeyFields</b> - Primary key fields will be bold and inside a box. (e.g: `<b class="pk">PrimaryKeyFields</b>`)
- <u class="fk">ForeignKeyFields</u> - Foreign key fields will be a wavy underline in italic and green. (e.g.: `<u class="fk">ForeignKeyFields</u>`)
- <b class="rg">{</b>Repeating Groups<b class="rg">}</b> - Groups of repeating fields will be identified in 0NF stage, and will be enclosed in orange curly braces. (e.g.: `<b class="rg">{</b>Repeating, Group, Fields<b class="rg">}</b>`)

## Customer Details View
### 0NF

###ERD

![CustomersOrderView](./ERD-Customersview.png)

**customer:** <span class="md"><b class="pk">OrderNumber</b>,CustomerNumber,FirstName,LastName,Adress,City,Province,PostalCode,Phone,Data<b class="rg">{</b>ItemNumber,Description,Quantity,CurrentPrice,SellingPrice,Amount<b class="rg">}</b> ,Subtotal,GST,Total </span>)

### 1NF 
**customer** <span class="md"><b class="pk"><u class="fk">OrderNumber</u>,CustomerNumber</b>,FirstName,LastName,Adress,City,Province,PostalCode,Phone,Data,Subtotal,GST,Total)

**OrderDetail:**(<u class="fk">OrderNumber</u>)
### 2NF
**customer:**  <span class="md"><b class="pk"><u class="fk">ItemNumber</u><u class="fk">PONumber</u></b>,Quantity,Cost)</span>

**PurchaseOrder** <span class="md"><b class ="pk">PONumber</b>,SupplierNumber,Date)</span>

### 3NF






----

<style type="text/css">
.md {
    display: inline-block;
    vertical-align: top;
    white-space: normal;
}
.md: :before {
    content: '(' ;
    font-size: 1.25em;
    font-weight: bold;
}
.mid: :after {
     content: '(' ;
    font-size: 1.25em;
    font-weight: bold;
}


.pk {
    font-weight: bold;
    display: inline-block;
    border: solid thin blue;
    padding: 0 1px;
}
.pk: :before {
     content: '(' ;
    font-size: .55cm;
    font-weight: bold;
    color: white;
    background-color: #72c4f7;
    position: absolute;
    left: -5px;
    top: -15px;
    border-radius: 50%;
    border: solid thin blue;
    width: 1.4em;
    height: 1.4em;
    padding: 3px;
    text-align: center;
}

.fk {
    color: green;
    font-style: italic;
    text-decoration: wavy underline green;  
    padding: 0 2px;
    position: relative;
  
  }  .fk: :before {
 content: '(' ;
    font-size: .65cm;
    position: absolute;
    left: -1px;
    bottom: -17px;
    color: darkgreen;
    border-radius: 50%;
    border: dashed thin green;
    width: 1.4em;
    height: 1.4em;
    padding: 3px;
    text-align: center;
  }


.rg: :before {
    content: '\007B';
    color: darkorange;
    font-size: 1.2em;
    font-weight: bold;
}
.rg: :after{
    content: '\007D';
    color: darkorange;
    font-size: 1.2em;
    font-weight: bold;
}

}
.note {
    font-weight: bold;
    color: brown;
    font-size: 1.1em;
}
</style>
import tkinter as tk
from tkinter import ttk,messagebox
import mysql.connector

# Connect to the SQLite database

conn = mysql.connector.connect(
    host="localhost",  # Replace with your actual host address
    user="root",  # Replace with your actual username
    password="",  # Replace with your actual password
    database="cardb"  # Replace with your actual database name
)

cursor = conn.cursor()

def execute_sales_trends_query():
    try:
        query = """
WITH BrandSales AS (
    SELECT
        b.BrandName,
        EXTRACT(YEAR FROM s.SaleDate) AS SaleYear,
        EXTRACT(MONTH FROM s.SaleDate) AS SaleMonth,
        EXTRACT(WEEK FROM s.SaleDate) AS SaleWeek,
        c.Gender,
        c.AnnualIncome,
        COUNT(*) AS SalesCount
    FROM
        Sales s
    JOIN Vehicles v ON s.VIN = v.VIN
    JOIN Brands b ON v.BrandID = b.BrandID
    JOIN Customers c ON s.CustomerID = c.CustomerID
    WHERE
        s.SaleDate >= DATE_SUB(CURRENT_DATE, INTERVAL 3 YEAR)
    GROUP BY
        b.BrandName, SaleYear, SaleMonth, SaleWeek, c.Gender, c.AnnualIncome
)

SELECT
    BrandName,
    SaleYear,
    SaleMonth,
    SaleWeek,
    Gender,
    AnnualIncome,
    SUM(SalesCount) AS TotalSales
FROM
    BrandSales
GROUP BY
    BrandName, SaleYear, SaleMonth, SaleWeek, Gender, AnnualIncome
ORDER BY
    BrandName, SaleYear, SaleMonth, SaleWeek, Gender, AnnualIncome;
        """
        cursor.execute(query)
        result=cursor.fetchall()

        root = tk.Tk()
        root.title("Sales Trends Query Result")

        # Create a Treeview widget
        tree = ttk.Treeview(root)
        tree["columns"] = ("BrandName", "SaleYear", "SaleMonth", "SaleWeek", "Gender", "AnnualIncome", "TotalSales")

        # Set column headings
        tree.heading("BrandName", text="Brand Name")
        tree.heading("SaleYear", text="Sale Year")
        tree.heading("SaleMonth", text="Sale Month")
        tree.heading("SaleWeek", text="Sale Week")
        tree.heading("Gender", text="Gender")
        tree.heading("AnnualIncome", text="Annual Income")
        tree.heading("TotalSales", text="Total Sales")

        # Insert data into the treeview
        for index, row in enumerate(result):
            tree.insert("", index, values=row, iid=str(index))

        # Pack the treeview
        tree.pack()

        # Run the Tkinter event loop
        root.mainloop()

    except Exception as e:
        messagebox.showerror("Error", str(e))



# Function to execute the defective transmissions query
def execute_defective_transmissions_query():
    try:
        query = """
        SELECT VIN, CustomerID
        FROM sales
        WHERE VIN IN (
            SELECT VIN
            FROM vehicles
            WHERE Transmission IN (
                SELECT OptionValue
                FROM Options
                WHERE OptionType = 'Transmission'
                AND OptionID = (
                    SELECT SupplierID
                    FROM suppliers
                    WHERE SupplierName = 'Getrag'
                )
            )
        )
        """
        cursor.execute(query)
        result=cursor.fetchall()

        # Display the result using a messagebox
        messagebox.showinfo("Defective Transmissions Query Result", result)
    except Exception as e:
        messagebox.showerror("Error", str(e))

# Function to execute the top brands by dollar-amount sold query
def execute_top_brands_by_dollar_query():
    try:
        query = """
        SELECT BrandName, SUM(SaleAmount) AS TotalAmount
        FROM sales
        JOIN vehicles ON sales.VIN = vehicles.VIN
        JOIN brands ON vehicles.BrandID = brands.BrandID
        GROUP BY brands.BrandID
        ORDER BY TotalAmount DESC
        LIMIT 2
        """
        cursor.execute(query)
        result=cursor.fetchall()

        # Display the result using a messagebox
        messagebox.showinfo("Top Brands by Dollar Amount Sold", result)
    except Exception as e:
        messagebox.showerror("Error", str(e))

# Function to execute the top brands by unit sales query
def execute_top_brands_by_unit_sales_query():
    try:
        query = """
        SELECT BrandName, COUNT(*) AS UnitSales
        FROM sales
        JOIN vehicles ON sales.VIN = vehicles.VIN
        JOIN brands ON vehicles.BrandID = brands.BrandID
        GROUP BY brands.BrandID
        ORDER BY UnitSales DESC
        LIMIT 2
        """
        cursor.execute(query)
        result=cursor.fetchall()

        # Display the result using a messagebox
        messagebox.showinfo("Top Brands by Unit Sales", result)
    except Exception as e:
        messagebox.showerror("Error", str(e))

# Function to execute the best-selling month(s) for convertibles query
def execute_best_selling_month_for_convertibles_query():
    try:
        query = """
            SELECT MONTH(SaleDate) AS BestSellingMonth, COUNT(*) AS SalesCount
            FROM Sales
            JOIN Vehicles ON Sales.VIN = Vehicles.VIN
            WHERE Vehicles.BodyStyle = 'Convertible'
            GROUP BY BestSellingMonth
            ORDER BY SalesCount DESC
            LIMIT 1;

        """
        cursor.execute(query)
        result = cursor.fetchone()

        # Format the result as a string
        months=["January","February","March","April","May","June", "July","August","September","October","November","December"]
        result_str = f"Best-Selling Month(s) for Convertibles:\nMonth: {months[result[0]-1]}, Sales Count: {result[1]}"

        # Display the result using a messagebox
        messagebox.showinfo("Best-Selling Month(s) for Convertibles", result_str)
    except Exception as e:
        messagebox.showerror("Error", str(e))

# Function to execute the dealers with the longest average inventory time query
def execute_longest_average_inventory_time_query():
    try:
        query = """
        SELECT DealerName, AVG(DATEDIFF(CURDATE(), SaleDate)) AS AvgInventoryTime
        FROM Inventory
        JOIN Dealers ON Inventory.DealerID = Dealers.DealerID
        JOIN Sales ON Inventory.VIN = Sales.VIN
        GROUP BY Dealers.DealerID
        ORDER BY AvgInventoryTime DESC
        """
        cursor.execute(query)
        result=cursor.fetchall()

        # Display the result using a messagebox
        messagebox.showinfo("Dealers with Longest Average Inventory Time", result)
    except Exception as e:
        messagebox.showerror("Error", str(e))

# Create the main Tkinter window
root = tk.Tk()
root.title("Car Dealership Queries")

# Create buttons for each query
sales_trends_button = tk.Button(root, text="Sales Trends", command=execute_sales_trends_query)
sales_trends_button.pack(pady=10)

defective_transmissions_button = tk.Button(root, text="Defective Transmissions", command=execute_defective_transmissions_query)
defective_transmissions_button.pack(pady=10)

top_brands_dollar_button = tk.Button(root, text="Top Brands by Dollar Amount", command=execute_top_brands_by_dollar_query)
top_brands_dollar_button.pack(pady=10)

top_brands_unit_sales_button = tk.Button(root, text="Top Brands by Unit Sales", command=execute_top_brands_by_unit_sales_query)
top_brands_unit_sales_button.pack(pady=10)

best_selling_month_button = tk.Button(root, text="Best-Selling Month(s) for Convertibles", command=execute_best_selling_month_for_convertibles_query)
best_selling_month_button.pack(pady=10)

longest_average_inventory_button = tk.Button(root, text="Dealers with Longest Average Inventory Time", command=execute_longest_average_inventory_time_query)
longest_average_inventory_button.pack(pady=10)

# Run the Tkinter event loop
root.mainloop()

# Don't forget to close the database connection when the application exits
conn.close()

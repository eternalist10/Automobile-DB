import tkinter as tk
from tkinter import ttk
import mysql.connector


def show_table(mydb, table_name, role):
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="cardb"
    )

    cursor = conn.cursor()
    cursor.execute(f"SELECT * FROM {table_name.lower()}")
    data = cursor.fetchall()
    conn.close()
    display_data(data, table_name, role)


def display_data(data, table_name, role):
    new_window = tk.Toplevel(root)
    new_window.title(f"{role} - {table_name} Table")
    for row_index, row in enumerate(data):
        for col_index, value in enumerate(row):
            tk.Label(new_window, text=value, borderwidth=1, relief="solid").grid(row=row_index, column=col_index)


def main():
    import mysql.connector
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="cardb"
    )

    def create_gradient_background(canvas, color1, color2):
        width = canvas.winfo_reqwidth()
        height = canvas.winfo_reqheight()

        for i in range(height):
            r = int(color1[0] * (1 - i / height) + color2[0] * (i / height))
            g = int(color1[1] * (1 - i / height) + color2[1] * (i / height))
            b = int(color1[2] * (1 - i / height) + color2[2] * (i / height))

            color = f'#{r:02x}{g:02x}{b:02x}'
            canvas.create_rectangle(0, i, width, i + 1, fill=color, outline="")

    global root
    root = tk.Tk()
    root.title("Automobile Company Sales")
    root.geometry("500x300+50+20")

    canvas = tk.Canvas(root, width=500, height=300)
    canvas.pack(expand=tk.YES, fill=tk.BOTH)

    color1 = (255, 127, 127)  # Light red
    color2 = (127, 127, 255)  # Light blue

    create_gradient_background(canvas, color1, color2)

    # Login functionality
    def login():
        role = role_var.get()
        table_name = "Vehicles"  # Default table to display
        if role == "Marketing Manager":
            table_name = "Sales"
        elif role == "Distributor":
            table_name = "Dealers"

        if role:
            show_table(conn, table_name, role)

    role_var = tk.StringVar(root)
    roles = ["Customer", "Marketing Manager", "Distributor"]

    style = ttk.Style()
    style.configure("TButton", font=('Helvetica', 12), background=color2)

    tk.Label(root, text="Automobile Company Sales", font=('Helvetica', 20, 'bold')).place(x=70, y=10)
    tk.Label(root, text="Select Role:", font=('Helvetica', 15)).place(x=70, y=100)

    role_dropdown = ttk.Combobox(root, textvariable=role_var, values=roles, state="readonly", font=('Helvetica', 12))
    role_dropdown.place(x=220, y=100)

    login_button = ttk.Button(root, text="Login", command=login)
    login_button.place(x=220, y=150)

    root.mainloop()


if __name__ == "__main__":
    main()

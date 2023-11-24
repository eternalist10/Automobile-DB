def display_data(data, table_name, role):
    new_window = tk.Toplevel(root)
    new_window.title(f"{role} - {table_name} Table")

    tree = ttk.Treeview(new_window, columns=range(len(data[0])), show="headings", height=10)
    for col_index, col_name in enumerate(data[0]):
        tree.heading(col_index, text=col_name)
        tree.column(col_index, width=100, anchor="center")

    for row_index, row_data in enumerate(data):
        tree.insert("", row_index, values=row_data)

    tree.pack(fill=tk.BOTH, expand=True
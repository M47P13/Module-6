import tkinter as tk
from tkinter import filedialog
from PIL import Image, ImageDraw, ImageTk

def on_click(event):
    global prev_x, prev_y
    prev_x, prev_y = event.x, event.y

def on_drag(event):
    global prev_x, prev_y
    if current_brush == "line":
        canvas.create_line(prev_x, prev_y, event.x, event.y, smooth=True, width=brush_size, fill=current_color)
    elif current_brush == "oval":
        canvas.create_oval(prev_x, prev_y, event.x, event.y, outline=current_color, width=brush_size)
    elif current_brush == "rectangle":
        canvas.create_rectangle(prev_x, prev_y, event.x, event.y, outline=current_color, width=brush_size)
    prev_x, prev_y = event.x, event.y

def change_color(new_color):
    global current_color
    current_color = new_color

def clear_canvas():
    canvas.delete("all")

def save_drawing():
    file_path = filedialog.asksaveasfilename(defaultextension=".png", filetypes=[("PNG files", "*.png")])
    if file_path:
        canvas.postscript(file=file_path + ".eps")
        img = Image.open(file_path + ".eps")
        img.save(file_path, "png")
        canvas.postscript(file=file_path, colormode="color")

def load_drawing():
    file_path = filedialog.askopenfilename(filetypes=[("PNG files", "*.png")])
    if file_path:
        img = Image.open(file_path)
        img = img.resize((600, 400), Image.ANTIALIAS)
        canvas.image = ImageTk.PhotoImage(img)
        canvas.create_image(0, 0, anchor=tk.NW, image=canvas.image)

def get_color(event):
    x, y = event.x, event.y
    # Get the color at the current mouse pointer location
    color = canvas.winfo_rgb(canvas.winfo_rgb(canvas.gettags(canvas.find_closest(x, y))[0]))
    current_color = "#%02x%02x%02x" % color[0:3]
    change_color(current_color)

def set_brush_shape(brush_shape):
    global current_brush
    current_brush = brush_shape

def set_brush_size(size):
    global brush_size
    brush_size = size

# Initialize variables
current_color = "black"
current_brush = "line"  # Default brush shape
brush_size = 3  # Default brush size
prev_x = None
prev_y = None

root = tk.Tk()
root.title("Drawing App")

# Create canvas
canvas = tk.Canvas(root, width=600, height=400, bg="white")
canvas.pack()

# Mouse events
canvas.bind("<Button-1>", on_click)
canvas.bind("<B1-Motion>", on_drag)
canvas.bind("<ButtonRelease-3>", get_color)  # Right-click to use eyedropper

# Create color buttons
colors = ["black", "red", "blue", "green", "orange", "purple"]
color_buttons = []

for color in colors:
    b = tk.Button(root, bg=color, width=2, command=lambda c=color: change_color(c))
    b.pack(side="left", padx=2)
    color_buttons.append(b)

# Brush shape buttons
brush_shapes = ["line", "oval", "rectangle"]
brush_shape_buttons = []

for shape in brush_shapes:
    b = tk.Button(root, text=shape.capitalize(), command=lambda s=shape: set_brush_shape(s))
    b.pack(side="left", padx=2)
    brush_shape_buttons.append(b)

def draw_brush(x, y):
    if prev_x is not None and prev_y is not None:
        canvas.create_line(prev_x, prev_y, x, y, fill=current_color, width=brush_size, capstyle=tk.ROUND, smooth=tk.TRUE)

def spray_paint(x, y):
    for _ in range(brush_size * 10):
        offset_x = random.randint(-brush_size, brush_size)
        offset_y = random.randint(-brush_size, brush_size)
        canvas.create_line(x + offset_x, y + offset_y, x + offset_x + 1, y + offset_y + 1, fill=current_color, width=1)

def erase(x, y):
    canvas.create_rectangle(x - brush_size, y - brush_size, x + brush_size, y + brush_size, fill="white", outline="")


# Brush size buttons
brush_sizes = [1, 3, 5, 7, 9]
brush_size_buttons = []

for size in brush_sizes:
    b = tk.Button(root, text=str(size), command=lambda s=size: set_brush_size(s))
    b.pack(side="left", padx=2)
    brush_size_buttons.append(b)

# Clear button
clear_button = tk.Button(root, text="Clear", command=clear_canvas)
clear_button.pack(side="left", padx=2)

# Save button
save_button = tk.Button(root, text="Save", command=save_drawing)
save_button.pack(side="right", padx=2)

# Load button
load_button = tk.Button(root, text="Load", command=load_drawing)
load_button.pack(side="right", padx=2)

root.mainloop()

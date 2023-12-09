import javafx.application.Application
import javafx.embed.swing.SwingFXUtils
import javafx.scene.canvas.Canvas
import javafx.scene.canvas.GraphicsContext
import javafx.scene.control.Button
import javafx.scene.image.Image
import javafx.scene.layout.HBox
import javafx.scene.layout.VBox
import javafx.stage.FileChooser
import tornadofx.*
import java.io.File
import javax.imageio.ImageIO

class DrawingApp : App(MainView::class)

class MainView : View("Drawing App") {
    private lateinit var canvas: Canvas
    private lateinit var gc: GraphicsContext

    private var prevX: Double = 0.0
    private var prevY: Double = 0.0

    private var currentColor: String = "black"
    private var currentBrush: String = "line"
    private var brushSize: Double = 3.0

    override val root = VBox()

    init {
        canvas = Canvas(600.0, 400.0)
        gc = canvas.graphicsContext2D

        canvas.setOnMousePressed {
            prevX = it.x
            prevY = it.y
        }

        canvas.setOnMouseDragged {
            when (currentBrush) {
                "line" -> {
                    gc.lineWidth = brushSize
                    gc.stroke = c(currentColor)
                    gc.strokeLine(prevX, prevY, it.x, it.y)
                }
                "oval" -> {
                    gc.lineWidth = brushSize
                    gc.stroke = c(currentColor)
                    gc.strokeOval(prevX, prevY, it.x - prevX, it.y - prevY)
                }
                "rectangle" -> {
                    gc.lineWidth = brushSize
                    gc.stroke = c(currentColor)
                    gc.strokeRect(prevX, prevY, it.x - prevX, it.y - prevY)
                }
            }
            prevX = it.x
            prevY = it.y
        }

        root.add(canvas)

        val colorBox = hbox {
            val colors = listOf("black", "red", "blue", "green", "orange", "purple")
            colors.forEach {
                button(it) {
                    action { changeColor(it) }
                }
            }
        }

        val brushShapeBox = hbox {
            val brushShapes = listOf("line", "oval", "rectangle")
            brushShapes.forEach {
                button(it.capitalize()) {
                    action { setBrushShape(it) }
                }
            }
        }

        val brushSizeBox = hbox {
            val brushSizes = listOf(1, 3, 5, 7, 9)
            brushSizes.forEach {
                button(it.toString()) {
                    action { setBrushSize(it.toDouble()) }
                }
            }
        }

        val buttonsBox = hbox {
            button("Clear") {
                action { clearCanvas() }
            }
            button("Save") {
                action { saveDrawing() }
            }
            button("Load") {
                action { loadDrawing() }
            }
        }

        root += colorBox
        root += brushShapeBox
        root += brushSizeBox
        root += buttonsBox
    }

    private fun changeColor(newColor: String) {
        currentColor = newColor
    }

    private fun setBrushShape(shape: String) {
        currentBrush = shape
    }

    private fun setBrushSize(size: Double) {
        brushSize = size
    }

    private fun clearCanvas() {
        gc.clearRect(0.0, 0.0, canvas.width, canvas.height)
    }

    private fun saveDrawing() {
        val writableImage = WritableImage(canvas.width.toInt(), canvas.height.toInt())
        canvas.snapshot(null, writableImage)
        val file = chooseFile(
            "Save Drawing",
            arrayOf(FileChooser.ExtensionFilter("PNG files", "*.png")),
            FileChooserMode.Save
        )
        if (file != null) {
            val bufferedImage = SwingFXUtils.fromFXImage(writableImage, null)
            ImageIO.write(bufferedImage, "png", file)
        }
    }

    private fun loadDrawing() {
        val file = chooseFile(
            "Load Drawing",
            arrayOf(FileChooser.ExtensionFilter("PNG files", "*.png")),
            FileChooserMode.Single
        )
        if (file.isNotEmpty()) {
            val image = Image(file[0].inputStream())
            gc.drawImage(image, 0.0, 0.0, canvas.width, canvas.height)
        }
    }
}

fun main() {
    Application.launch(DrawingApp::class.java)
}

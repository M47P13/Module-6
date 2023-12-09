//
//  Beginner Test.swift
//  Procreate Clone
//
//  Created by Maya Thompson on 12/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var currentColor: Color = .black
    @State private var currentBrush: BrushShape = .line
    @State private var brushSize: CGFloat = 3.0
    @State private var drawing: Drawing = Drawing()

    var body: some View {
        VStack {
            DrawingCanvas(drawing: $drawing, currentColor: $currentColor, currentBrush: $currentBrush, brushSize: $brushSize)

            HStack {
                ColorPalette(currentColor: $currentColor)
                BrushShapeSelector(currentBrush: $currentBrush)
                BrushSizeSelector(brushSize: $brushSize)
                Spacer()
                Button(action: {
                    drawing.clear()
                }) {
                    Text("Clear")
                }
            }
            .padding()
        }
    }
}

struct DrawingCanvas: View {
    @Binding var drawing: Drawing
    @Binding var currentColor: Color
    @Binding var currentBrush: BrushShape
    @Binding var brushSize: CGFloat

    var body: some View {
        GeometryReader { geometry in
            CanvasView(drawing: $drawing, currentColor: $currentColor, currentBrush: $currentBrush, brushSize: $brushSize, canvasSize: geometry.size)
                .border(Color.black, width: 1)
                .background(Color.white)
        }
    }
}

struct CanvasView: UIViewRepresentable {
    @Binding var drawing: Drawing
    @Binding var currentColor: Color
    @Binding var currentBrush: BrushShape
    @Binding var brushSize: CGFloat
    let canvasSize: CGSize

    func makeUIView(context: Context) -> UIView {
        let canvas = DrawingCanvasView(frame: .zero)
        canvas.drawing = drawing
        return canvas
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        guard let canvas = uiView as? DrawingCanvasView else { return }
        canvas.drawing = drawing
        canvas.currentColor = currentColor
        canvas.currentBrush = currentBrush
        canvas.brushSize = brushSize
        canvas.canvasSize = canvasSize
    }
}

class Drawing: ObservableObject {
    // Implement your drawing logic here
}

class DrawingCanvasView: UIView {
    // Implement your drawing canvas view here
}

struct ColorPalette: View {
    // Implement color palette UI here
}

struct BrushShapeSelector: View {
    // Implement brush shape selector UI here
}

struct BrushSizeSelector: View {
    // Implement brush size selector UI here
}

enum BrushShape {
    case line
    case oval
    case rectangle
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

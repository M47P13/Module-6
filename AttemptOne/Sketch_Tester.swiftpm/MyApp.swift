//import SwiftUI
//
//@main
//struct MyApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

import SwiftUI

struct ContentView: View {
    @State private var lines: [Line] = []
    
    var body: some View {
        VStack {
            Text("Simple Drawing App")
                .font(.title)
                .padding()
            
            DrawingCanvasView(lines: $lines)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .border(Color.black, width: 1) // Add border for visualization
                .background(Color.white) // Set canvas background color
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            lines.append(Line(points: [value.location]))
                        }
                        .onChanged { value in
                            guard var lastLine = lines.popLast() else { return }
                            lastLine.points.append(value.location)
                            lines.append(lastLine)
                        }
                )
        }
        .padding()
    }
}

struct DrawingCanvasView: View {
    @Binding var lines: [Line]
    
    var body: some View {
        ZStack {
            ForEach(lines, id: \.id) { line in
                Path { path in
                    for i in 0..<line.points.count {
                        if i == 0 {
                            path.move(to: line.points[i])
                        } else {
                            path.addLine(to: line.points[i])
                        }
                    }
                }
                .stroke(line.color, lineWidth: 3)
            }
        }
    }
}

struct Line: Identifiable {
    let id = UUID()
    var points: [CGPoint]
    var color: Color = .black // You can change the line color here
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

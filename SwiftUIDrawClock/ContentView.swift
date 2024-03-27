//
//  ContentView.swift
//  SwiftUIDrawClock
//
//  Created by Angelos Staboulis on 26/3/24.
//

import SwiftUI
struct MinuteHand:View{
    @State var centerX:Double
    @State var centerY:Double
    @State var center:CGPoint
    @Binding var minuteRadians:Double
    @State var innerRadius:Double
    var body:some View{
        Canvas{context,value in
            var path = Path()
            path.move(to: center)
            let height = innerRadius * 0.45
            let x = centerX + height * cos(minuteRadians)
            let y = centerY + height * sin(minuteRadians)
            path.addLine(to: CGPoint(x: x, y: y))
            context.stroke(path, with: .color(.black), lineWidth: 2.0)
        }
    }
}
struct HourHand:View{
    @State var centerX:Double
    @State var centerY:Double
    @State var center:CGPoint
    @State var innerRadius:Double
    @Binding var hourRadians:Double
    var body:some View{
        Canvas{context,value in
            var path = Path()
            path.move(to: center)
            let height = innerRadius * 0.45
            let x = centerX + height * cos(hourRadians)
            let y = centerY + height * sin(hourRadians)
            path.addLine(to: CGPoint(x: x, y: y))
            context.stroke(path, with: .color(.black), lineWidth: 2.0)
        }
    }
}
struct SecondHand:View{
    @State var centerX:Double
    @State var centerY:Double
    @State var center:CGPoint
    @Binding var secondsRadians:Double
    @State var innerRadius:Double
    var body:some View{
        Canvas{context,value in
            var path = Path()
            path.move(to: center)
            let height = innerRadius * 0.45
            let x = centerX + height * cos(secondsRadians)
            let y = centerY + height * sin(secondsRadians)
            path.addLine(to: CGPoint(x: x, y: y))
            context.stroke(path, with: .color(.black), lineWidth: 2.0)
        }
    }
}
struct ContentView: View {
    @State var hourRadians:Double
    @State var minuteRadians:Double
    @State var secondsRadians:Double
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var hour:Int
    @State var minute:Int
    @State var second:Int
    var body: some View {
        ZStack(alignment: .center, content: {
            HStack{
                Text("SwiftUI Draw Clock")
            }
        })
        GeometryReader{geometry in
             let centerX = geometry.size.width / 2.0
             let centerY = geometry.size.height / 2.0
             let center = CGPoint(x: centerX, y: centerY)
             let innerRadius = (geometry.size.width / 2.0) - 20
            VStack{
                Canvas{context,value in
                    var path = Path()
                    path.addEllipse(in: CGRect(x: centerX - 150, y: centerY-120, width: 300, height: 230))
                    context.stroke(path, with: .color(.black), lineWidth: 2.0)
                }
            }.frame(alignment: .center)
            SecondHand(centerX: centerX, centerY: centerY, center: center, secondsRadians: $secondsRadians, innerRadius: innerRadius)
            MinuteHand(centerX: centerX, centerY: centerY, center: center, minuteRadians: $minuteRadians, innerRadius: innerRadius)
            HourHand(centerX: centerX, centerY: centerY, center: center,innerRadius: innerRadius, hourRadians: $hourRadians)
            
        }.aspectRatio(1, contentMode: .fit)
            .onAppear(perform: {
                hour = Calendar.current.component(.hour, from: Date())
                minute = Calendar.current.component(.minute, from: Date())
                second = Calendar.current.component(.second, from: Date())
                hourRadians = Angle(degrees: Double((360/12)*hour-90)).radians
                minuteRadians = Angle(degrees: Double((360/60)*minute-90)).radians
                secondsRadians = Angle(degrees: Double((360/60)*second-90)).radians
            })
            .onReceive(timer, perform: { value in
                hour = Calendar.current.component(.hour, from: Date())
                minute = Calendar.current.component(.minute, from: Date())
                second = Calendar.current.component(.second, from: Date())
                hourRadians = Angle(degrees: Double((360/12)*hour-90)).radians
                minuteRadians = Angle(degrees: Double((360/60)*minute-90)).radians
                secondsRadians = Angle(degrees: Double((360/60)*second-90)).radians
            })
        
        ZStack(alignment: .center, content: {
            HStack{
                Text(String(describing: hour) + ":" + String(describing:minute)+":"+String(describing: second))
            }
        })
        
        
    }
}

#Preview {
    ContentView(hourRadians: 0.0, minuteRadians: 0.0, secondsRadians: 0.0, hour: 9, minute: 0, second: 0)
}

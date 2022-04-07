//
//  DrawingControls.swift
//  DrawingPadSwiftUI
//
//  Created by Martin Mitrevski on 19.07.19.
//  Copyright © 2019 Mitrevski. All rights reserved.
//

import SwiftUI

struct DrawingControls: View {
    @Binding var color: Color
    @Binding var drawings: [Drawing]
    @Binding var lineWidth: CGFloat
    
    @State private var colorPickerShown = false

    private let spacing: CGFloat = 40
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: spacing) {
                    
                    Button(action: {
                        self.colorPickerShown = true
                    }) { Image(systemName:"eyedropper.halffull")
                            .foregroundColor(.blue)
                            .font(.system(size:30))
                        
                    }
                    
                    Button(action: {
                        if self.drawings.count > 0 {
                        self.drawings.removeLast()
                        }
                
                    }) { Image(systemName:"arrow.uturn.backward")
                            .foregroundColor(.blue)
                            .font(.system(size:30))
                    }
                        
                        Button(action: {
                            self.drawings = [Drawing]()
                            }) { Image(systemName:"xmark")
                                .foregroundColor(.blue)
                                .font(.system(size:30))
                    
                            }
                }
                .padding()
                
                HStack {
                    Image(systemName:"scribble.variable")
                            .foregroundColor(.blue)
                            .font(.system(size:30))
                            .padding(.leading, 16)
                            .padding(.trailing, 16)
                    Slider(value: $lineWidth, in: 1.0...15.0, step: 1.0)
                        .padding(.trailing, 16)
                    }
                }
                        

        }
            
            
        .frame(height: 230)
        .sheet(isPresented: $colorPickerShown, onDismiss: {
            self.colorPickerShown = false
        }, content: { () -> ColorPicker in
            ColorPicker(color: self.$color, colorPickerShown: self.$colorPickerShown)
        })
    }
}
        
    
    

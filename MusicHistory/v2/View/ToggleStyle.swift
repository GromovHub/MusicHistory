//
//  ToggleStyle.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/21/22.
//

import SwiftUI

struct ToggleStyle1: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: configuration.isOn ? "circle.fill" : "circle")
            .foregroundColor(.accentColor)
            .onTapGesture {
                configuration.isOn.toggle()
        }
    }
}



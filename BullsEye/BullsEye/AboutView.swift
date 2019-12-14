//
//  AboutView.swift
//  BullsEye
//
//  Created by Ashish Kumar on 26/11/19.
//  Copyright © 2019 Ashish Kumar. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    struct HeadingStyle: ViewModifier {
        func body(content :Content) -> some View{
             return content
            .font(Font.custom("AvenirNext-DemiBoldItalic" , size: 30))
                .font(.title)
                .foregroundColor(.white)
            .padding(.top,20)
            .padding(.bottom,20)
        }
    }
    
    struct TextStyle: ViewModifier {
        func body(content :Content) -> some View{
             return content
            .font(Font.custom("AvenirNext-DemiBoldItalic" , size: 16))
                .font(.title)
                .foregroundColor(.white)
                .padding(.leading,60)
            .padding(.trailing,60)
            .padding(.bottom,20)
        }
    }

    var body: some View {
        VStack{
            Text("🎯Bullseye🎯").modifier(HeadingStyle())
            Text("This is BullsEye , a game where u can win points and earn fame by dragging a slider.").modifier(TextStyle())
            Text("Your goal is to place the slider as close as possible to the target value. The closer you are the more points you score.").modifier(TextStyle())
            Text("Enjoy!!").modifier(TextStyle())
        }.background(Image("Background"), alignment: .center)
    .navigationBarTitle("About BullsEye")
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}

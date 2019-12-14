//
//  ContentView.swift
//  BullsEye
//
//  Created by Ashish Kumar on 24/11/19.
//  Copyright © 2019 Ashish Kumar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    @State var target: Int = Int(Int.random(in: 1...100))
    @State var score: Int = 0
    @State var round: Int = 1
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content :Content) -> some View{
             return content
            .modifier(Shadow())
            .font(Font.custom("AvenirNext-DemiBoldItalic" , size: 18))
                .font(.title)
                .foregroundColor(.white)
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content :Content) -> some View{
             return content
            .font(Font.custom("AvenirNext-DemiBoldItalic" , size: 24))
                .font(.title)
                .foregroundColor(Color.yellow)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content :Content) -> some View{
             return content
            .font(Font.custom("AvenirNext-DemiBoldItalic" , size: 18))
                .font(.title)
                .foregroundColor(Color.black)
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content :Content) -> some View{
             return content
            .font(Font.custom("AvenirNext-DemiBoldItalic" , size: 12))
                .font(.title)
                .foregroundColor(Color.black)
        }
    }

    
    struct Shadow: ViewModifier {
        func body(content :Content) -> some View{
             return content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }


    
    
    
    
    var body: some View {
        VStack {
            
            Spacer()
            
            //Target Row
            HStack {
                Text("Put the bullseye as close to the target as you can:").modifier(LabelStyle())
                Text("\(self.target)").modifier(ValueStyle())
            }
            Spacer()
            
            //Slider Row
            HStack{
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            
            
            Spacer()
            
            //Button Row
            Button(action: {
                print("Button is pressed")
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit Me!!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
            }.background(Image("Button").modifier(Shadow()))
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                let roundedValue = Int(self.sliderValue.rounded())
                return Alert(title: Text(alertTitle()), message: Text("The Slider Value is \(roundedValue).\n" +
                    "Points Earned By You in this round: \(self.finalScore())" ) ,
                             dismissButton: .default(Text("Awesome!!")){
                                self.score = self.score + self.pointsEarnedInRound()
                                self.target = Int(Int.random(in: 1...100))
                                self.round = self.round + 1
                                })
            }
                

            
            Spacer()
            
            
            //Score and Round Info Row
            
            HStack{
                Button(action: {
                    self.startOver()
                }) {
                    HStack{
                        Image("StartOverIcon")
                    Text("Start Over").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button")).modifier(Shadow())
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack{
                        Image("InfoIcon")
                    Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button")).modifier(Shadow())
                
            }
            .padding(.bottom,20)
            
            
            
        }
        .background(Image("Background"), alignment: .center)
    .accentColor(midnightBlue)
    .navigationBarTitle("BullsEye")
    }
    
    
    
    
    
    func roundedValueOnSlider() -> Int{
        let roundedValue: Int = Int(self.sliderValue.rounded())
        return roundedValue
    }
    
    
    func pointsEarnedInRound() ->Int{
        var difference :Int
        if (self.target>roundedValueOnSlider()) {
            difference  = self.target - roundedValueOnSlider()
        }else if (roundedValueOnSlider()>self.target){
            difference = roundedValueOnSlider() - self.target
        }else{
        difference = 0
        }
        return 100 - difference
    }
    //or just    return 100 - abs(self.target - roundedValueOnSlider())
                    //abs-->absolute value for getting positive difference always as a result
    
    
    func extraPoints() -> Int {
        let bonusPoints: Int
        let awardedPoints = pointsEarnedInRound()
        if(awardedPoints == 100){
            bonusPoints = 100
        }else if (awardedPoints == 99){
            bonusPoints = 50
        }
        else{
            bonusPoints = 0
        }
        return bonusPoints
    }
    
    func finalScore() -> Int{
        return pointsEarnedInRound()+extraPoints()
    }
    
    
    func alertTitle() ->String{
        let points = pointsEarnedInRound()
        var title :String
        if (points>95){
            title = "Excellent"
        }else if (points>=90 && points<95){
            title = "Very Good"
        }else if (points>=80 && points<90){
            title = "Try once More"
        }else{
            title = "Not even Close"
        }
        return title
    }
    
    func startOver() {
         round = 1
         score = 0
        sliderValue = 50.0
        target = (Int.random(in: 1...100))
    }
        
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}

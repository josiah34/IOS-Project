//
//  NoItemsView.swift
//  GoalGetter
//
//  Created by mac on 2023-03-22.
//

import SwiftUI

struct NoItemsView: View {
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    var body: some View {
        ScrollView{
            VStack(spacing: 10 ){
                Text("No Items")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Start chasing goals today!!")
                    .padding(.bottom, 20)
                NavigationLink(
                               destination:AddView() ,
                               label:{
                                   Text("Launch your goals🚀")
                                       .foregroundColor(.white)
                                       .font(.headline)
                                       .frame(height: 55)
                                       .background(animate ? secondaryAccentColor : Color.accentColor)
                                       .cornerRadius(210)
                                       
                               } )
                                .padding(.horizontal, animate ? 30 : 50)
                                .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                                        radius: animate ? 30 : 10,
                                        x: 0.0,
                                        y: animate ? 50 : 30)
                                .scaleEffect(animate ? 1.1: 1.0)
                                .offset(y: animate ? -7 : 0)
            }
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear( perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    func addAnimation() {
        guard !animate else {return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemsView()
                .navigationTitle("Goal Getter")
        }
        
    }
        
}

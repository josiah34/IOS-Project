//
//  NoItemsView.swift
//  GoalGetter
//
//  Created by mac on 2023-03-22.
// Josiah Galloway 101296257
// Ravkeerat Singh - 101344680

import SwiftUI

// Define a SwiftUI view named `NoItemsView` that is displayed when there are no items in the to-do list.
struct NoItemsView: View {
    
    // Use `@State` to keep track of whether to animate the button.
    @State var animate: Bool = false
    
    // Define a secondary accent color to use in the button animation.
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    var body: some View {
        ScrollView{
            VStack(spacing: 10 ){
                // Display a message indicating that there are no items in the list.
                Text("Start chasing goals today!!")
                    .padding(.bottom, 50)
                    .padding(.top,50)
                    .bold()
                
                // Use a `NavigationLink` to allow the user to launch the `AddView`.
                NavigationLink(
                    destination:AddView() ,
                    label:{
                        // Display a button with text that says "Launch your goals🚀".
                        Text("Launch your goals🚀")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height:100)
                            // Use the accent color for the button background if the animation is not active,
                            // and use the secondary accent color if the animation is active.
                            .background(animate ? secondaryAccentColor : Color.accentColor)
                            .cornerRadius(350)
                    } )
                    // Add some padding to the button.
                    .padding(.horizontal, animate ? 30 : 50)
                    // Add a shadow to the button that is more intense if the animation is active.
                    .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                            radius: animate ? 30 : 10,
                            x: 0.0,
                            y: animate ? 50 : 30)
                    // Make the button larger if the animation is active.
                    .scaleEffect(animate ? 1.1: 1.0)
                    // Move the button up if the animation is active.
                    .offset(y: animate ? -7 : 0)
            }
            .multilineTextAlignment(.center)
            .padding(40)
            // Use an `onAppear` modifier to start the animation when the view appears.
            .onAppear( perform: addAnimation)
        }
        // Make the view take up the entire screen.
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // This function adds an animation to the button.
    func addAnimation() {
        // Only start the animation if it hasn't already started.
        guard !animate else {return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            // Use a repeating animation that lasts 2 seconds and eases in and out.
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                // Toggle the `animate` state to start the animation.
                animate.toggle()
            }
        }
    }
}

// Define a preview for the `NoItemsView` to see how it looks in Xcode's canvas.
struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemsView()
                .navigationTitle("Goal Getter")
                
        }
    }
}

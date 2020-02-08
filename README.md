## 100DaysOfSwiftUI Project 4: BetterRest

Reference from [Hacking with Swift](https://www.hackingwithswift.com/100/swiftui/26)

The actual app we’re build is called BetterRest, and it’s designed to help coffee drinkers get a good night’s sleep by asking them three questions:

- When do they want to wake up?
- Roughly how many hours of sleep do they want?
- How many cups of coffee do they drink per day?

Once we have those three values, we’ll feed them into Core ML to get a result telling us when they ought to go to bed. If you think about it, there are billions of possible answers – all the various wake times multiplied by all the number of sleep hours, multiplied again by the full range of coffee amounts.

###### Challenge
- Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!
- Replace the “Number of cups” stepper with a Picker showing the same range of values.
- Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.

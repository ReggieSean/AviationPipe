//import SwiftUI


//For iPhone to record
import SwiftUI

struct ContentView: View{
    var body: some View{
//        NavigationStack{
//            NavigationLink{} label: { Text("Recording")}
//        }.navigationTitle("Audio Recording + Inferencing")
        RecordingView()
    }
            
        
        
        
    

    

}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
        ContentView().preferredColorScheme(.light)
    }
}

//
//  RecordingView.swift
//  AviationPipe
//
//  Created by SeanHuang on 10/10/23.
//
import SwiftUI
import Foundation
import AVFoundation

//
class RecorderHandler: NSObject, AVAudioRecorderDelegate{
    override init(){
        super.init()
    }
   
}
struct RecordingView: View{
    @State var recording = false
    @State var session : AVAudioSession!
    @State var recorder : AVAudioRecorder!
    @State var alert = false
    @State var sessionID  = 0
    @State var recordDelegate = RecorderHandler()
    @State var textField = "Tap To Record"
    let url :URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let colors : [Color] = [.blue]
    var body: some View {
        NavigationStack{
            Button(action:{
                if !self.recording {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "ddMMyyy-HHmmss"
                    let name = formatter.string(from: NSDate() as Date) + ".wav"
                    let fileName = url.appendingPathComponent(name)
                    let settings: [String: Any] = [
                            AVFormatIDKey: kAudioFormatLinearPCM,
                            AVSampleRateKey: 44100.0,
                            AVNumberOfChannelsKey: 2,
                            AVLinearPCMBitDepthKey: 16,
                            AVLinearPCMIsFloatKey: false,
                            AVLinearPCMIsBigEndianKey: false
                        ]
                    do{
                        recorder = try AVAudioRecorder(url: self.url, settings: settings)
                        recorder.delegate = recordDelegate
                        //not sure what's the reason behind using the delegate
                        recorder.record()
                        self.textField = "Tap To Stop"
                    }catch{
                        print("recording failed to start!",error.localizedDescription)
                    }
                    
                } else{
                    recorder.stop()
                    textField = "Tap To Record"
                }
                recording.toggle()
            }){
                ZStack{
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)).padding(.vertical)
                        .foregroundColor(.gray)
                    ZStack(alignment: .center, content: {
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .foregroundColor(.black)
                    })
                    .frame(maxWidth: 200, maxHeight: 200)
                    VStack{
                        Text(textField)
                        ZStack{
                            Circle()
                                .fill(Color.red)
                                .frame(width: 70, height: 70)
                            if self.recording{
                                Circle()
                                    .stroke(Color.white, lineWidth: 6)
                                    .frame(width: 85, height: 85)
                            }
                        }
                    }.padding(/*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/).padding(.vertical, 20.0)
                }
            }.padding(.vertical, 25)
        }.onAppear{
            do{
                self.session = AVAudioSession.sharedInstance()
                try self.session.setCategory(.playAndRecord)
                
                //notify the user that recording permission is needed, prompts the user for only once.
                AVAudioApplication.requestRecordPermission { access in
                    if !access{
                        //change later to popup window
                       print("Enable microphone permission for correct functionality")
                    }
                }
            } catch{
                //has to catch error because onAppear does not throw
                print("Recroding init failed: \(error.localizedDescription)")
            }
            
        }
        .preferredColorScheme(.dark)
            
    }
}
struct RecordingView_Previews : PreviewProvider {
    static var previews: some View {
        RecordingView()
    }
}

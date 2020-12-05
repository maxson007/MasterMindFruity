//
//  SoundPlayer.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 05/12/2020.
//

import AVFoundation

class SoundPlayer {
    var audioPlayer: AVAudioPlayer?
    
    
    public func play(soundFile: String, type: String){
        
        let path = Bundle.main.path(forResource: soundFile, ofType:type)!
        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer=try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Lecteur audio: Probleme de lecture du fichier audio: \(soundFile)")
        }
    }
    
}

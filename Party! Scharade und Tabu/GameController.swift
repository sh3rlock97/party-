//
//  ViewController.swift
//  Party! Scharade und Tabu
//
//  Created by Marino Schmid on 15.06.19.
//  Copyright © 2019 Marino Schmid. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation
import AudioToolbox

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

class GameController: UIViewController {

    let manager = CMMotionManager()
    @IBOutlet weak var timer: UILabel!
    var time : Int = 60
    @IBOutlet weak var degree: UILabel!
    var status = 0;
    
    var words : [String] = [];
    var start : Bool = false;
    
    func play() {
        time = 60;
        words = ["Geburtstagsgeschenke öffnen", "den Tisch decken", "Kleider anprobieren beim Einkaufen", "einem Tornado nachjagen", "ein Bücherregal einrichten", "Fußball spielen", "eine Fliege schlagen", "Zähne putzen", "mit Spielteig spielen", "ein Bild hängen", "die Enten füttern", "Hüpfkästchen spielen", "jemandem die Haare schneiden", "einen platten Reifen wechseln", "Dekorieren für eine Party", "Nadel einfädeln", "mit Delphinen schwimmen", "spielt vier gewinnt", "sich früh aus einer Vorstellung herausschleichen", "eine Schlange aufheben", "dein Zimmer aufräumen", "in der Dusche singen", "eine afrikanische Safari machen", "Kontaktlinsen einsetzen", "ein Taxi rufen", "einen Garten gießen", "einen Rasen mähen", "Wandern im Wald", "ein Kleid nähen", "Drachen steigen lassen", "eine Spinne töten", "Karate üben", "ein Haustier füttern", "ein Auto waschen", "ein Flugzeug landen", "stinkenden Müll riechen", "Flughafensicherheit durchlaufen", "einen Kuchen backen", "um ein Autogramm bitten", "Musik hören", "Suche nach einem Platz in einem überfüllten Raum", "Spaghetti essen", "Wäsche sortieren", "Schminken", "im Fitnessstudio trainieren", "Walbeobachtung", "Jemandem das Schwimmen beibringen", "Essen in einem Restaurant bestellen", "in einem Sessellift fahren", "Ballett tanzen", "Achterbahn fahren", "durch ein Spukhaus gehen", "ein Zelt aufbauen", "einen Fahrertest machen", "zum ersten Mal mit Stäbchen essen", "Süßes oder Saures", "Karussell fahren", "ein Bild malen", "in einer Arztpraxis warten", "Gerätetauchen", "ein Flugbegleiter zu sein", "Körpersurfen am Strand", "mit Krücken gehen", "Zustellung von Post", "eine Kuh melken", "Autoscooter fahren", "Paddeln in einem Kanu", "Felsklettern", "ein Auto mit Benzin tanken", "ein Motorrad fahren", "eine Gruppe von Hunden spazieren gehen", "Besuch beim Zahnarzt", "auf einen lego treten", "einen Film drehen", "Fahrrad fahren lernen", "bei einem Klavierabend spielen", "im Unterricht eine Note geben", "Besuch des Zoos", "Äpfel von einem Baum pflücken", "einen Schrank putzen", "eine Pizza machen", "Vorsprechen für ein Stück", "einen Essenskampf haben", "Knopf annähen", "Blumen arrangieren", "Brot backen", "Sammeln von Eiern aus einem Hühnerstall", "Auftritt bei einem Rockkonzert", "Navigieren Sie durch einen mit Spielzeug übersäten Raum", "einen traurigen Film gucken", "Besteigung des Mount Everest", "Baseball spielen", "Sumoringen", "Schnee Skifahren einen Hügel hinunter", "einen Kühlschrank bewegen", "Blätter harken", "versuchen, ein Baby zum Schlafen zu bringen", "versuchen, in einer langweiligen Klasse wach zu bleiben", "Schreiben und Versenden eines Briefes", "ein Loch graben", "ein Instrument spielen", "Lagerfeuer machen", "Pfannkuchen umdrehen", "einen Hügel besteigen", "im Einkaufszentrum einkaufen", "Malen Sie Ihre Nägel", "Bowling gehen", "einen gruseligen Film gucken", "die Wände in einem Raum streichen", "Schach spielen", "einen außer Kontrolle geratenen Hund jagen", "einen Presslufthammer bedienen", "tanzen, wenn niemand zuschaut", "Haare stylen", "einen neuen Tanzschritt lernen", "Suche nach verlorenen Autoschlüsseln", "eine Sandburg bauen", "im theater einen film schauen", "Drachenfliegen", "ein Erdnussbutter-Gelee-Sandwich machen", "einen Test machen", "Möbel neu ordnen", "Waschen von Fenstern an einem Gebäude", "ein Hemd bügeln", "einen Elefanten waschen", "Fingermalen", "für die Ehe vorschlagen", "einen Hund waschen", "Zusammenstellen eines Puzzles", "einen nassen Badeanzug anziehen"];
        
        if manager.isAccelerometerAvailable {
            manager.accelerometerUpdateInterval = 0.01
            manager.startAccelerometerUpdates(to: .main) {
                [weak self] (data, error) in
                guard let data = data, error == nil else {
                    return
                }
                if let s = self {

                let rotation = data.acceleration.z - .pi
                
                if(rotation < -3.9) {
                    s.view.backgroundColor = .green;
                    if(s.status != 1) {
                        // create a sound ID, in this case its the tweet sound.
                        let systemSoundID: SystemSoundID = 1103
                        
                        // to play sound
                        AudioServicesPlaySystemSound (systemSoundID)
                    }
                    s.status = 1;
                } else if(rotation > -2.5) {
                    s.view.backgroundColor = .red;
                    if(s.status != -1) {
                        // create a sound ID, in this case its the tweet sound.
                        let systemSoundID: SystemSoundID = 1103
                        
                        // to play sound
                        AudioServicesPlaySystemSound (systemSoundID)
                    }
                    s.status = -1;
                } else if(rotation < -2.9 && rotation > -3.4) {
                    s.view.backgroundColor = .white;
                    if(s.status != 0) {
                        // create a sound ID, in this case its the tweet sound.
                        let systemSoundID: SystemSoundID = 1104
                        if let w = s.words.randomItem() {
                            s.degree.text = w;
                        }
                        // to play sound
                        AudioServicesPlaySystemSound (systemSoundID)
                    }
                    
                    if(!s.start) {
                        if let w = s.words.randomItem() {
                            s.degree.text = w;
                            s.start = true
                            s.view.backgroundColor = .white
                        }
                    }
                    s.status = 0;
                }
            }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.degree.text = "Gerade halten um zu beginnen!";
        self.view.backgroundColor = .gray
        play();
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        
    }

    @objc func fire()
    {
        if(self.start) {
            time -= 1
            timer.text = "\(time) Sekunden";
        } else {
            timer.text = "60 Sekunden";
        }
    }
    

}


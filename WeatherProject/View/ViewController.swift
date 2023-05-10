//
//  ViewController.swift
//  WeatherProject
//
//  Created by Eyüphan Akkaya on 8.05.2023.
//

import UIKit
import Alamofire
import UIKit
import CoreLocation

class ViewController: UIViewController {

    var locationManager:CLLocationManager = CLLocationManager()
    @IBOutlet weak var tarihLabel: UILabel!
    @IBOutlet weak var iconİmageView: UIImageView!
    @IBOutlet weak var havaDurumuLabel: UILabel!
    @IBOutlet weak var sehiLabel: UILabel!
    @IBOutlet weak var nemLabel: UILabel!
    @IBOutlet weak var uvIndeksLabel: UILabel!
    @IBOutlet weak var ruzgarHizLabel: UILabel!
    @IBOutlet weak var ruzgarYonLabel: UILabel!
    @IBOutlet weak var minSicaklikLabel: UILabel!
    @IBOutlet weak var maxSicaklikLabel: UILabel!
    @IBOutlet weak var dereceLabel: UILabel!
    var enlem:Double?
    var boylam:Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
       
        
       
    }
    
    
    func tumGetir(enlem:Double,boylam:Double){
        let apiKey = "3f95bd844fb336a3a0ba035d5bc08cf3"
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(enlem)&lon=\(boylam)&appid=\(apiKey)&lang=tr")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil || data == nil  {
                print("Hata")
                return
            }
            do {
             let welcome = try JSONDecoder().decode(ListModel.self, from: data!)
                DispatchQueue.main.async {
                    self.sehiLabel.text = welcome.city.name
                    for x in welcome.list! {
                        self.dereceLabel.text = String("\(Int(x.main.temp-273.15))°")
                        self.maxSicaklikLabel.text = String("\(Int(x.main.tempMax-273.15))°" )
                        self.minSicaklikLabel.text = String("\(Int(x.main.tempMin-273.15))°" )
                        self.ruzgarHizLabel.text = String(x.wind.speed)
                        self.ruzgarYonLabel.text = (String(x.wind.deg))
                        self.nemLabel.text = String(x.main.humidity)
                        for i in x.weather {
                            self.havaDurumuLabel.text = String(i.description)

                        }
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd MMMM EEE"
                        let date = Date()
                        let dateInWords = dateFormatter.string(from: date)
                        self.tarihLabel.text = dateInWords
                        let iconName = x.weather[0].icon // icon adı
                        let iconUrl = URL(string: "http://openweathermap.org/img/w/\(iconName).png")! // ikon URL'si
                        URLSession.shared.dataTask(with: iconUrl) { (data, response, error) in
                            guard let data = data, error == nil else { return } // veri kontrolü
                            DispatchQueue.main.async { // arayüz işlemleri ana iş parçacığı üzerinde yapılmalı
                                let downloadedImage = UIImage(data: data) // UIImage olarak dönüştür
                                self.iconİmageView.image = downloadedImage // atama işlemi
                            }
                        }.resume()

                    }
                }
                

            }catch {
                print(error)
            }
            
   
        }.resume()
    }
}
extension ViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let sonKonum:CLLocation = locations[locations.count - 1]
        enlem = sonKonum.coordinate.latitude
        boylam = sonKonum.coordinate.longitude
    
        tumGetir(enlem: enlem!, boylam: boylam!)
         
    }
    
    
}


    
    





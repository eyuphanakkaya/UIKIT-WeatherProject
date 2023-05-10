//
//  DetayViewController.swift
//  WeatherProject
//
//  Created by Eyüphan Akkaya on 8.05.2023.
//

import UIKit
import CoreLocation

class DetayViewController: UIViewController {
    
    var locationManager:CLLocationManager = CLLocationManager()
    var myListe = [List]()
    var enlem:Double?
    var boylam:Double?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        tableView.dataSource = self
        tableView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    func degerList(enlem:Double,boylam:Double){
        let apiKey = "3f95bd844fb336a3a0ba035d5bc08cf3"
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(enlem)&lon=\(boylam)&appid=\(apiKey)&lang=tr")
        self.myListe.removeAll()
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil || data == nil  {
                print("Hata")
                return
            }
            do {
                let result = try JSONDecoder().decode(ListModel.self, from: data!)
                if let gelenDeger  = result.list {
                    self.myListe = gelenDeger
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            } catch {
                print(error)
            }

            

        }.resume()
    }
    
}

extension DetayViewController:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myListe.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var gelenDeger = myListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetayCell", for: indexPath) as? DetayTableViewCell
        cell?.minSicaklikLabel.text = String("\(Int(gelenDeger.main.tempMin-273.15))°" )
        cell?.maxSicaklikLabel.text = String("\(Int(gelenDeger.main.tempMax-273.15))°" )
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: gelenDeger.dt_txt)
        dateFormatter.dateFormat = "HH:mm/dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date!)
        cell?.gunLabel.text = dateString
        let iconName = gelenDeger.weather[0].icon // icon adı
        let iconUrl = URL(string: "http://openweathermap.org/img/w/\(iconName).png")! // ikon URL'si
        URLSession.shared.dataTask(with: iconUrl) { (data, response, error) in
            guard let data = data, error == nil else { return } // veri kontrolü
            DispatchQueue.main.async { // arayüz işlemleri ana iş parçacığı üzerinde yapılmalı
                let downloadedImage = UIImage(data: data) // UIImage olarak dönüştür
                cell?.durumImageView.image = downloadedImage // atama işlemi
            }
        }.resume()




        return cell!
    }
    
}
extension DetayViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let sonKonum:CLLocation = locations[locations.count - 1]
        enlem = sonKonum.coordinate.latitude
        boylam = sonKonum.coordinate.longitude
    
         degerList(enlem: enlem!, boylam: boylam!)
    }
    
    
}

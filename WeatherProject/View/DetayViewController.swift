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
    var myListe = [ListModel]()
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
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil || data == nil  {
                print("Hata")
                return
            }
            do {
                let result = try JSONDecoder().decode(ListModel.self, from: data!)
                
                self.myListe = [result]
                
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
        for x in gelenDeger.list {
            cell?.maxSicaklikLabel.text = String(x.main.tempMax)
            cell?.minSicaklikLabel.text = String(x.main.tempMin)
            cell?.gunLabel.text = x.dt_txt

        }

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

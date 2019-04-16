//
//  ViewController.swift
//  Parks Explorer
//
//  Created by Guled Ali on 4/9/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import UIKit

class ParkListViewController: UIViewController {
    @IBOutlet weak var statePickerView: UIPickerView!
    @IBOutlet weak var parkPickerView: UIPickerView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var statePicker: StatePicker?
    var parkPicker: ParkPicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statePicker = StatePicker(states: States.stateNames)
        statePickerView.dataSource = statePicker
        statePickerView.delegate = statePicker
        
        parkPicker = ParkPicker()
        parkPickerView.dataSource = parkPicker
        parkPickerView.delegate = parkPicker
    }

    @IBAction func showParkButtonTapped(_ sender: UIButton) {
        
        let row = statePickerView.selectedRow(inComponent: 0)
        let stateName = statePicker!.stateFor(row: row)
        let statAbbr = States.stateAbbreviation(for: stateName)
        getParks(for: statAbbr!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "explorePark" {
            let selectedRow = parkPickerView.selectedRow(inComponent: 0)
            let park = parkPicker?.parkFor(row: selectedRow)
            
            let imageViewController = segue.destination as! ImageCollectionViewController
            imageViewController.park = park
        }
    }
    
    func getParks(for state: String) {
        let service = NationalParksService()
        loadingIndicator.startAnimating()
        
        service.fetchParks(for: state) { (parks: [NationalPark]?, error: Error?) -> Void in
            
            if let parks = parks {
                self.parkPicker!.parks = parks
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    
                    if let error = error {
                        print(error)
                        
                        self.present(ErrorAlertController.alert(message: "Unable to fetch parks"), animated: true)
                    }
                    self.parkPickerView.reloadAllComponents()
                    self.parkPickerView.selectRow(0, inComponent: 0, animated: true)
                }
                
            }
        }
    }
    
}


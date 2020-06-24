//
//  AppointmentsViewController.swift
//  FIlaMed
//
//  Created by Danilo Araújo on 22/06/20.
//  Copyright © 2020 FilaMed. All rights reserved.
//

import UIKit



class AppointmentsViewController: UIViewController {
    
    let imageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
    let appointmentsView = AppointmentsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.appointmentsView

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        
        self.appointmentsView.appointmentsTable.dataSource = self
        self.appointmentsView.appointmentsTable.delegate = self
        
        self.setupProfilePicture()
    }
}

extension AppointmentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 104 : 122
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath) as! AppointmentCell<TodayAppointmentContent>
            
            cell.content.clinicName.text = "Dra.Judith da Matta"
            cell.content.specialty.text = "Ortodontista"
            cell.content.time.text = "10:30"
            cell.content.statusLabel.text = "Você ainda não entrou na fila"
            
            return cell
        }
        else if(indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "futureAppointmentCell", for: indexPath) as! AppointmentCell<FutureAppointmentContent>
            
            cell.content.clinicName.text = "Dr.Marcio Danilo"
            cell.content.specialty.text = "Ortodontista"
            cell.content.time.text = "10:30"
            cell.content.dateLabel.text = "26/06/2020"
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:"appointmentsHeader") as! AppointmentsHeader
        view.title.text = section == 0 ? "Hoje" : "Próximas"
        
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}


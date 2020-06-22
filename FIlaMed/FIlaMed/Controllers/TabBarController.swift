//
//  TabBarController.swift
//  FIlaMed
//
//  Created by Wilton Ramos on 22/06/20.
//  Copyright © 2020 FilaMed. All rights reserved.
//

import UIKit

class TabBarController: UIViewController {
    let tabBarViewController = UITabBarController()
    let appointmentsViewController = AppointmentsViewController()
    let lineViewController = LineViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarViewController.viewControllers = [appointmentsViewController, lineViewController]
        setupAppointmentsTabBarItem()
        setupLineTabBarItem()
        self.view.addSubview(tabBarViewController.view)
    }
    
    func setupAppointmentsTabBarItem() {
        appointmentsViewController.title = "Consultas"
        let appointmentsItemImage = UIImage(systemName: "heart.circle.fill")
        appointmentsViewController.tabBarItem.image = appointmentsItemImage
    }
    
    func setupLineTabBarItem() {
        lineViewController.title = "Fila"
        let lineItemImage = UIImage(systemName: "person.2")
        lineViewController.tabBarItem.image = lineItemImage
    }
}

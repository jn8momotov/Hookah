//
//  FeedbackViewController.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 09.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit
import MessageUI

final class FeedbackViewController: MFMailComposeViewController {
    static let canSendMail = MFMailComposeViewController.canSendMail()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureEmail()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureEmail() {
        mailComposeDelegate = self
        setToRecipients(["hookah.places.app@gmail.com"])
        setSubject("Обратная связь")
    }
}

extension FeedbackViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}

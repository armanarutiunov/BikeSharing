//
//  ViewController.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 20/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import UIKit
import RxSwift
import ModelLayer

public class ViewController: UIViewController {
    
    var disposeBag = DisposeBag()

    public convenience init() {
        self.init(nibName: nil, bundle: Bundle(for: ViewController.self))
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var alertIsShowing = false
    public func showError(_ error: ErrorWithRecovery) {
        if alertIsShowing { return }
        else { alertIsShowing = true }
        
        let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
        
        if error.retryAction != nil {
            alert.addAction(
                UIAlertAction(title: "Try again",style: .default, handler: { _ in
                    self.alertIsShowing = false
                    error.retryAction?()}))
        }
        
        if error.cancelAction != nil {
            alert.addAction(
                UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                    self.alertIsShowing = false
                    error.cancelAction?()}))
        }
        
        if alert.actions.count == 0 {
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                self.alertIsShowing = false}))
        }
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    /// Indicate loading progress
    private let _activityQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    private let _activityIndicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(activityIndicatorStyle: .white)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.hidesWhenStopped = true
        v.color = UIColor.white
        return v
    }()
    public func show(loading: Bool, target: UIView) {
        let operation = BlockOperation()
        operation.addExecutionBlock { [weak operation] in
            usleep(useconds_t(300_000)) // 300 ms
            guard let op = operation else { return }
            if op.isCancelled { return }
            
            DispatchQueue.main.async {
                if loading {
                    target.addSubview(self._activityIndicator)
                    self._activityIndicator.centerXAnchor.constraint(equalTo: target.centerXAnchor).isActive = true
                    self._activityIndicator.centerYAnchor.constraint(equalTo: target.centerYAnchor).isActive = true
                    self._activityIndicator.startAnimating()
                    
                    (target as? UIButton)?.accessibilityLabel = (target as? UIButton)?.title(for: .normal)
                    (target as? UIButton)?.setTitle(nil, for: .normal)
                }
                else {
                    self._activityIndicator.stopAnimating()
                    
                    if let restoredTitle = (target as? UIButton)?.accessibilityLabel {
                        (target as? UIButton)?.setTitle(restoredTitle, for: .normal)
                    }
                }
                UIView.animate(withDuration: 0.25) { self.view.alpha = loading ? 0.75 : 1 }
                self.view.isUserInteractionEnabled = !loading
            }
        }
        _activityQueue.cancelAllOperations()
        _activityQueue.addOperation(operation)
    }
    
    /// Adjust elements to top safeArea / superview layout guide
    private func fixTopConstraints() {
        if #available(iOS 11.0, *) { return }
        else {
            for c in view.constraints {
                guard let secondItem = c.secondItem as? UIView else { continue }
                if secondItem == view, c.secondAttribute == .top {
                    c.constant += 20
                }
            }
        }
    }
    
    public typealias AlertAction = ((UIAlertAction) -> Void)
    
    func showAlert(title: String, message: String, alertAction: AlertAction? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = alertAction != nil ?
            UIAlertAction(title: "OK", style: .default, handler: alertAction!) :
            UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}


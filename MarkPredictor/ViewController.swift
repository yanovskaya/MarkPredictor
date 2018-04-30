//
//  ViewController.swift
//  MarkPredictor
//
//  Created by Елена Яновская on 28.04.2018.
//  Copyright © 2018 Elena Yanovskaya. All rights reserved.
//

import fluid_slider
import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let title = "Оценка за экзамен"
        static let visitLabel = "Процент посещений занятий"
        static let testLabel = "Оценка за контрольную работу"
        static let homeworkLabel = "Оценка за домашнюю работу"
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private var visitLabel: UILabel!
    @IBOutlet private var homeworkLabel: UILabel!
    @IBOutlet private var testLabel: UILabel!
    
    @IBOutlet private var visitSlider: Slider!
    @IBOutlet private var homeworkSlider: Slider!
    @IBOutlet private var testSlider: Slider!
    
    @IBOutlet private var examLabel: UILabel!
    
    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureLabels()
        configureVisitSlider()
        configureTestSlider()
        configureHomeworkSlider()
    }
    
    // MARK: - Private Methods
    
    private func configureNavigationBar() {
        title = Constants.title
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    private func configureLabels() {
        visitLabel.textColor = UIColor.darkText
        visitLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        visitLabel.text = Constants.visitLabel
        
        homeworkLabel.textColor = UIColor.darkText
        homeworkLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        homeworkLabel.text = Constants.homeworkLabel
        
        testLabel.textColor = UIColor.darkText
        testLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        testLabel.text = Constants.testLabel
        
        examLabel.textColor = UIColor.darkText
        examLabel.font = UIFont.systemFont(ofSize: 100, weight: .regular)
        examLabel.text = "0"
    }
    
    private func configureVisitSlider() {
        visitSlider.backgroundColor = .clear
        let labelTextAttributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        visitSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 100) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.black])
        }
        visitSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0%", attributes: labelTextAttributes))
        visitSlider.setMaximumLabelAttributedText(NSAttributedString(string: "100%", attributes: labelTextAttributes))
        visitSlider.fraction = 0.5
        visitSlider.shadowOffset = CGSize(width: 0, height: 3)
        visitSlider.shadowBlur = 5
        visitSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        visitSlider.contentViewColor = UIColor.purple
        visitSlider.valueViewColor = .white
        visitSlider.didBeginTracking = { [weak self] _ in
            self!.setLabelHidden(true, label: self!.visitLabel, animated: true)
        }
        visitSlider.didEndTracking = { [weak self] _ in
            self!.setLabelHidden(false, label: self!.visitLabel, animated: true)
        }
    }
    
    private func configureHomeworkSlider() {
        homeworkSlider.backgroundColor = .clear
        let labelTextAttributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        homeworkSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 2
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 10) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.black])
        }
        homeworkSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        homeworkSlider.setMaximumLabelAttributedText(NSAttributedString(string: "10", attributes: labelTextAttributes))
        homeworkSlider.fraction = 0.5
        homeworkSlider.shadowOffset = CGSize(width: 0, height: 3)
        homeworkSlider.shadowBlur = 5
        homeworkSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        homeworkSlider.contentViewColor = UIColor.green
        homeworkSlider.valueViewColor = .white
        homeworkSlider.didBeginTracking = { [weak self] _ in
            self!.setLabelHidden(true, label: self!.homeworkLabel, animated: true)
        }
        homeworkSlider.didEndTracking = { [weak self] _ in
            self!.setLabelHidden(false, label: self!.homeworkLabel, animated: true)
        }
    }
    
    private func configureTestSlider() {
        testSlider.backgroundColor = .clear
        let labelTextAttributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        testSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 2
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 10) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.black])
        }
        testSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        testSlider.setMaximumLabelAttributedText(NSAttributedString(string: "10", attributes: labelTextAttributes))
        testSlider.fraction = 0.5
        testSlider.shadowOffset = CGSize(width: 0, height: 3)
        testSlider.shadowBlur = 5
        testSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        testSlider.contentViewColor = UIColor.blue
        testSlider.valueViewColor = .white
        testSlider.didBeginTracking = { [weak self] _ in
            self!.setLabelHidden(true, label: self!.testLabel, animated: true)
        }
        testSlider.didEndTracking = { [weak self] _ in
            self!.setLabelHidden(false, label: self!.testLabel, animated: true)
        }
    }
    
    private func setLabelHidden(_ hidden: Bool, label: UILabel, animated: Bool) {
        let animations = {
            label.alpha = hidden ? 0 : 1
        }
        if animated {
            UIView.animate(withDuration: 0.11, animations: animations)
        } else {
            animations()
        }
    }
    
}

//
//  ViewController.swift
//  MarkPredictor
//
//  Created by Елена Яновская on 28.04.2018.
//  Copyright © 2018 Elena Yanovskaya. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let title = "Оценка за экзамен"
        static let visitLabel = "Процент посещенных занятий"
        static let testLabel = "Оценка за контрольную работу"
        static let homeworkLabel = "Оценка за домашнюю работу"
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private var visitLabel: UILabel!
    @IBOutlet private var homeworkLabel: UILabel!
    @IBOutlet private var testLabel: UILabel!
    
    @IBOutlet private var visitSlider: CustomSlider!
    @IBOutlet private var homeworkSlider: CustomSlider!
    @IBOutlet private var testSlider: CustomSlider!
    
    @IBOutlet private var examLabel: UILabel!
    
    // MARK: - Private Properties
    
    private let modelWrapper = MarkModelWrapper()
    
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
        examLabel.text = String(modelWrapper.predictMark(visits: 50, homework: 5, test: 5))
    }
    
    private func configureVisitSlider() {
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
        visitSlider.initialConfigure()
        visitSlider.contentViewColor = PaletteColors.blue
        visitSlider.valueViewColor = .white
        visitSlider.observeTracking(label: visitLabel)
        visitSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    private func configureHomeworkSlider() {
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
        homeworkSlider.initialConfigure()
        homeworkSlider.contentViewColor = PaletteColors.green
        homeworkSlider.valueViewColor = .white
        homeworkSlider.observeTracking(label: homeworkLabel)
        homeworkSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    private func configureTestSlider() {
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
        testSlider.initialConfigure()
        testSlider.contentViewColor = PaletteColors.teal
        testSlider.valueViewColor = .white
        testSlider.observeTracking(label: testLabel)
        testSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    @objc private func sliderValueChanged() {
        examLabel.text = String(modelWrapper.predictMark(visits: Int(visitSlider.fraction * 100),
                                                         homework: Int(homeworkSlider.fraction * 10),
                                                         test: Int(testSlider.fraction * 10)))
    }
    
}

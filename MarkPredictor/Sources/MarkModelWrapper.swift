//
//  MarkModelWrapper.swift
//  MarkPredictor
//
//  Created by Елена Яновская on 01.05.2018.
//  Copyright © 2018 Elena Yanovskaya. All rights reserved.
//

import CoreML
import Foundation

final class MarkModelWrapper {
    
    private let model = MarkModel()
    
    func predictMark(visits: Int, homework: Int, test: Int) -> Int {
        do {
            let mlMultiArrayInput = try? MLMultiArray(shape: [3], dataType: MLMultiArrayDataType.double)
            mlMultiArrayInput![0] = NSNumber(value: Double(visits))
            mlMultiArrayInput![1] = NSNumber(value: Double(homework))
            mlMultiArrayInput![2] = NSNumber(value: Double(test))
            let markModelOutput = try model.prediction(input: MarkModelInput(matrixVisitsHomeworkTest: mlMultiArrayInput!))
            return Int(markModelOutput.examMark[0].doubleValue + 0.5)
        } catch {
            return 0
        }
    }
}

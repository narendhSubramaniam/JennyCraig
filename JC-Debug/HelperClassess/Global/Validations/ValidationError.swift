//
//  TextFieldValidations.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 6/23/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation
import UIKit

/**
 The `ValidationError` class is used for representing errors of a failed validation. It contains the field, error label, and error message of a failed validation.
 */
public class ValidationError {
    /// the Validatable field of the field
    public let field: ValidatableField
    /// the error label of the field
    public var errorLabel: UILabel?
    /// the error message of the field
    public let errorMessage: String

    /**
     Initializes `ValidationError` object with a field, errorLabel, and errorMessage.

     - parameter field: Validatable field that holds field.
     - parameter errorLabel: UILabel that holds error label.
     - parameter errorMessage: String that holds error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(field: ValidatableField, errorLabel: UILabel?, error: String) {
        self.field = field
        self.errorLabel = errorLabel
        self.errorMessage = error
    }
}

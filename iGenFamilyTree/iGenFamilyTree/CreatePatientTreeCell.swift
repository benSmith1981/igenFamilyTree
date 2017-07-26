//
//  CustomFormTableViewCell.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 25-07-17.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit
import Eureka

/*
public class CustomCell: Cell<Bool>, CellType{
    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var label: UILabel!
    
    public override func setup() {
        super.setup()
        switchControl.addTarget(self, action: #selector(CustomCell.switchValueChanged), forControlEvents: .ValueChanged)
    }
    
    func switchValueChanged(){
        row.value = switchControl.on
        row.updateCell() // Re-draws the cell which calls 'update' bellow
    }
    
    public override func update() {
        super.update()
        backgroundColor = (row.value ?? false) ? .whiteColor() : .blackColor()
    }
}

// The custom Row also has value: Bool, and cell: CustomCell
public final class CustomRow: Row<Bool, CustomCell>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        // We set the cellProvider to load the .xib corresponding to our cell
        cellProvider = CellProvider<CustomCell>(nibName: "CustomCell")
    }
}
*/

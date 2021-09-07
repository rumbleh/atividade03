//
//  ProblemTableViewCell.swift
//  Problemas
//
//  Created by user203358 on 9/4/21.
//

import UIKit

class ProblemTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewProblema: UIImageView!
    @IBOutlet weak var labelNomeProblema: UILabel!
    @IBOutlet weak var labelLocalProblema: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(_ problem: Problem){
        labelNomeProblema.text = problem.nome
        labelLocalProblema.text = problem.localizacao
        if let image = problem.foto {
            imageViewProblema.image = UIImage(data: image)
        }
    }
    

}

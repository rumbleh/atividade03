//
//  ViewController.swift
//  Problemas
//
//  Created by Thiago de Queiroz on 04/09/21.
//

import UIKit

class ProblemViewController: UIViewController {

    
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelLocalizacao: UILabel!
    @IBOutlet weak var labelDescricao: UILabel!
    @IBOutlet weak var imageViewProblema: UIImageView!
    var problem : Problem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let problemFormViewController =  segue.destination as? ProblemFormViewController {
            problemFormViewController.problem = problem
        }		
    }
    
    func prepareScreen(){
        if let problem = problem {
            labelNome.text = problem.nome!
            labelLocalizacao.text = problem.localizacao!
            labelDescricao.text = problem.descricao!
            imageViewProblema.image = UIImage(data: problem.foto!)
            
            
        }
    }

}


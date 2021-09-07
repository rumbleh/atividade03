//
//  CarFormViewController.swift
//  Problemas
//
//  Created by Thiago de Queiroz on 04/09/21.
//

import UIKit

class ProblemFormViewController: UIViewController {
    
    var problem: Problem?
    
	
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldDescricao: UITextField!
    @IBOutlet weak var textFieldLocalizacao: UITextField!
    @IBOutlet weak var imageViewFoto: UIImageView!
    @IBOutlet weak var btnAdicionar: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let problem = problem {
            title = "Edição"
            textFieldNome.text = problem.nome
            textFieldLocalizacao.text = problem.localizacao
            textFieldDescricao.text = problem.descricao
            imageViewFoto.image = UIImage(data: problem.foto!)
            btnAdicionar.setTitle("Alterar", for: .normal)
        }
        self.hideKeyboardWhenTappedAround()

        
    }
    	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let problemFormViewController = segue.destination as? ProblemFormViewController {
            problemFormViewController.problem = problem
        }
    }
    @IBAction func selectFoto(_ sender: UIButton) {
        let alert = UIAlertController(title: "Foto do problema", message: "Escolha o local da imagem", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Câmera", style: .default){ _ in
                self.selectFoto(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { _ in
            self.selectFoto(sourceType: .photoLibrary)
        }
        
        alert.addAction(libraryAction)
        
        let albumAction = UIAlertAction(title: "Album de fotos", style: .default) { _ in
            self.selectFoto(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(albumAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func selectFoto(sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        if (problem == nil) {
            problem = Problem(context: context)
        }
        
        problem?.nome = textFieldNome.text
        problem?.localizacao = textFieldLocalizacao.text
        problem?.descricao = textFieldDescricao.text
        problem?.foto = imageViewFoto.image?.jpegData(compressionQuality: 0.9)
        
        try? context.save()
        
        navigationController?.popViewController(animated: true)
    }
}

extension ProblemFormViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageViewFoto.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
                                 

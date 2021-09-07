//
//  ProblemasTableViewController.swift
//  Problemas
//
//

import UIKit
import CoreData

class ProblemasTableViewController: UITableViewController {
	
    var fetchedResultsController : NSFetchedResultsController<Problem>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProblems()
    }
    
    func loadProblems(){
        let fetchRequest: NSFetchRequest<Problem> = Problem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context	, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, 	sender: Any?) {
        if let problemViewController = segue.destination as? ProblemViewController,
           let indexPath = tableView.indexPathForSelectedRow	 {
            problemViewController.problem =	fetchedResultsController.object(at: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    	
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?
                ProblemTableViewCell else {
            return UITableViewCell()
        }
        
        
            
        let problem = fetchedResultsController.object(at: indexPath)
        cell.configureWith(problem)
        
        return cell
        
    }
    
    override func tableView(_ tableVIew: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            let problem = fetchedResultsController.object(at: indexPath)
            context.delete(problem)
            try? context.save()
        }
    }

}

extension ProblemasTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?){
        tableView.reloadData()
    }
}

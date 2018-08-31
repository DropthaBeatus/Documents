//
//  DocumentsTableVC.swift
//  Documents
//
//  Created by Liam Flaherty on 8/29/18.
//  Copyright © 2018 Liam Flaherty. All rights reserved.
//

import UIKit

class DocumentsTableVC: UITableViewController {
    
    @IBAction func ToTextView(_ sender: Any) {
          performSegue(withIdentifier: "ToTextView", sender: self)
    }
    
    
    @IBOutlet var DocumentCell: UITableView!
//should of recreate a struct here 
    var dataFile = [URL]?.self
    var fileSize = [Int]?.self
    var dateMod = [Date]?.self


    
    override func viewDidLoad() {
        super.viewDidLoad();
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func loadList(){
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let dataFile: [URL] = GetAllFileURLs()!
        return dataFile.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DocumentsTableViewCell
        
        //need to figure out how to refresh structs without doing this all the time
        //this practice can make load time dramatic due to constant search time being used
        
        var dataFile: [URL] = GetAllFileURLs()!
        var fileSize: [Int] = GetAllFileSizes(urls: dataFile)
        var dateMod: [Date] = GetAllFileDates(urls: dataFile)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy h:mm"
        
        let s = dateFormatter.string(from:dateMod[indexPath.row])
        cell.DateLabel.text = String(s)
        //could create a func that returns int at string to specifiy the size of the folder
        cell.SizeLabel.text = (String(fileSize[indexPath.row])) + " bytes"
        cell.DocumentLabel.text = ((dataFile[indexPath.row].absoluteString) as NSString).lastPathComponent
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var dataFile: [URL] = GetAllFileURLs()!
            DeleteFile(url: dataFile[indexPath.row])
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        //I know this is not an economic way to do this I can fix it but will take a bit
        loadList()
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TextViewController,
            let row = DocumentCell.indexPathForSelectedRow?.row {
            let dataFile: [URL] = GetAllFileURLs()!

            destination.URLcontents = dataFile[row]
        }
        
    }

}

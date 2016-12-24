//
//  ConnectoBoardView.swift
//  junctio
//
//  Created by Mike Swierenga on 12/23/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//


import UIKit

class ConnnectoBoardViewController: UICollectionViewController {
    
    private var rows: CGFloat = 0;
    private var cols: CGFloat = 0;
    
    public func setRows(rows: Int, andCols cols: Int) {
        self.rows = CGFloat(rows)
        self.cols = CGFloat(cols)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setRows(rows: 6, andCols: 4)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        // Setting the space between cells
        layout.minimumInteritemSpacing = 0 // space between cols
        layout.minimumLineSpacing = 0 // space between rows
        
        self.collectionView?.setCollectionViewLayout(layout, animated: true)
        //self.collectionView?.backgroundColor = UIColor(patternImage:#imageLiteral(resourceName: "bramble"))
        //self.collectionView?.backgroundView = UIImageView(image:#imageLiteral(resourceName: "bramble"))
        self.collectionView?.backgroundView = UIImageView(image:#imageLiteral(resourceName: "chandra"))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    private func createBoard() {
        // iterate through the board and populate each piece
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // Compute the dimension of a cell for an NxN layout with space S between
        // cells.  Take the collection view's width, subtract (N-1)*S points for
        // the spaces between the cells, and then divide by N to find the final
        // dimension for the cell's width and height.
        
        // TODO : check the math, I don't think this is quite right
        let spaceBetweenCells: CGFloat = 0
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = collectionView.bounds.height
        var w:CGFloat = (width - (self.cols - 1) * spaceBetweenCells) / self.cols
        //if ((w * self.rows) + (spaceBetweenCells * (self.rows-1)) > height) {
            //w = (height - (self.rows - 1) * spaceBetweenCells) / self.rows
            //print(w)
        //}
        print(w)
        return CGSize(width:w, height:w)
    }
    
    let reuseIdentifier = "connectoCell" // also enter this string as the cell identifier in the storyboard
    var items = [
        #imageLiteral(resourceName: "term_spectro"), #imageLiteral(resourceName: "cross_spectro"), #imageLiteral(resourceName: "cross_spectro"),
        #imageLiteral(resourceName: "turn_spectro"), #imageLiteral(resourceName: "cross_spectro"), #imageLiteral(resourceName: "cross_spectro"),
        #imageLiteral(resourceName: "fork_spectro"), #imageLiteral(resourceName: "cross_spectro"), #imageLiteral(resourceName: "cross_spectro"),
        #imageLiteral(resourceName: "fork_spectro"), #imageLiteral(resourceName: "cross_spectro"), #imageLiteral(resourceName: "cross_spectro"),
        #imageLiteral(resourceName: "strat_spectro"), #imageLiteral(resourceName: "cross_spectro"), #imageLiteral(resourceName: "cross_spectro"),
        #imageLiteral(resourceName: "fork_spectro"), #imageLiteral(resourceName: "cross_spectro"), #imageLiteral(resourceName: "cross_spectro"),
        #imageLiteral(resourceName: "strat_spectro"), #imageLiteral(resourceName: "cross_spectro"), #imageLiteral(resourceName: "cross_spectro"),
        #imageLiteral(resourceName: "fork_spectro"), #imageLiteral(resourceName: "cross_spectro"), #imageLiteral(resourceName: "cross_spectro"),
        #imageLiteral(resourceName: "strat_spectro"), #imageLiteral(resourceName: "cross_spectro"), #imageLiteral(resourceName: "cross_spectro"),
        #imageLiteral(resourceName: "fork_spectro"), #imageLiteral(resourceName: "cross_spectro"), #imageLiteral(resourceName: "cross_spectro"),
        #imageLiteral(resourceName: "strat_spectro"), #imageLiteral(resourceName: "cross_spectro"), #imageLiteral(resourceName: "cross_spectro"),
        #imageLiteral(resourceName: "fork_spectro"), #imageLiteral(resourceName: "cross_spectro"), #imageLiteral(resourceName: "cross_spectro"),
        #imageLiteral(resourceName: "strat_spectro"), #imageLiteral(resourceName: "cross_spectro"), #imageLiteral(resourceName: "cross_spectro")
    ]
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ConnectoViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.image.image = self.items[indexPath.item]
        //cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        let cell = collectionView.cellForItem(at: indexPath) as! ConnectoViewCell
        cell.rotate()
    }
    
}

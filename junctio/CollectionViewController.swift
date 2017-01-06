//
//  CollectionViewController.swift
//  junctio
//
//  Created by Mike Swierenga on 12/25/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import UIKit
import AudioToolbox

class CollectionViewController: UICollectionViewController {
    
    //private var board: ConnectoBoard?
    //private var difficulty: ConnectoDifficulty = SimpleDifficulty()
    //private var skin: ConnectoSkin = SpectroSkin()
    private var game: ConnectoGame = ConnectoGame(skin: SpectroSkin(), difficulty: SimpleDifficulty())
    private var complete = false
    private var snap: UIImage?
    
    @IBOutlet weak var difficultyButton: UIBarButtonItem!
    @IBOutlet weak var skinButton: UIBarButtonItem!
    @IBOutlet weak var newGameButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        difficultyButton.title = game.difficulty.getTitle()
        skinButton.title = game.skin.getTitle()
        startNewGame()
        print("###### BEFORE: ", navigationController?.navigationBar.isHidden.description as String!)
        navigationController?.setNavigationBarHidden(true, animated: false)
        print("###### AFTER:  ", navigationController?.navigationBar.isHidden.description as String!)
        navigationController?.navigationBar.bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        navigationController?.navigationBar.topItem?.title = "Connecto"
    }
    
    
    @IBAction func newGamePressed(_ sender: UIBarButtonItem) {
        startNewGame()
    }
    
    @IBAction func skinButtonPressed(_ sender: UIBarButtonItem) {
        startNewGame(skin: game.skin.getNextSkin())
        sender.title = game.skin.getTitle()
    }
    @IBAction func difficultyButtonPressed(_ sender: UIBarButtonItem) {
        startNewGame(difficulty: game.difficulty.getNextDifficulty())
        sender.title = game.difficulty.getTitle()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func startNewGame() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            /*
            print("animation start")
            var frame = self.view!.frame
            frame.origin.y += frame.size.height
            self.collectionView!.frame = frame
 */
        }, completion: { finished in
            print("animation complete")
        })
        
        startNewGame(skin: self.game.skin, difficulty: self.game.difficulty)
    }
    
    private func startNewGame(difficulty: ConnectoDifficulty) {
        startNewGame(skin: self.game.skin, difficulty: difficulty)
    }
    
    private func startNewGame(skin: ConnectoSkin) {
        startNewGame(skin: skin, difficulty: self.game.difficulty)
    }
    
    private func startNewGame(skin: ConnectoSkin, difficulty: ConnectoDifficulty) {
        self.complete = false
        self.game = ConnectoGame(skin: skin, difficulty: difficulty)
        setBackground()
        self.collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let skin = UIBarButtonItem(image: cross, landscapeImagePhone: <#T##UIImage?#>, style: <#T##UIBarButtonItemStyle#>, target: <#T##Any?#>, action: <#T##Selector?#>)
        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(playTapped))
        
        navigationItem.rightBarButtonItems = [add, play]
        */
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        // Setting the space between cells
        layout.minimumInteritemSpacing = 0 // space between cols
        layout.minimumLineSpacing = 0 // space between rows
        
        self.collectionView?.setCollectionViewLayout(layout, animated: true)
    }
    
    private func setBackground() {
        let bg = game.skin.getBackground()
        if let imageView = bg as? UIImageView {
            self.collectionView?.backgroundView = imageView
        } else if let color = bg as? UIColor {
            self.collectionView?.backgroundView = nil
            self.collectionView?.backgroundColor = color
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // Compute the dimension of a cell for an NxN layout with space S between
        // cells.  Take the collection view's width, subtract (N-1)*S points for
        // the spaces between the cells, and then divide by N to find the final
        // dimension for the cell's width and height.
        if !complete {
        
            let spaceBetweenCells: CGFloat = 0
            let width: CGFloat = collectionView.bounds.width
            let cols = CGFloat(game.board.cols())
            let rows = CGFloat(game.board.rows())
        
            let w: CGFloat = (width - (rows - 1) * spaceBetweenCells) / cols
            return CGSize(width:w, height:w)
        } else {
            let frame = self.collectionView!.frame
            return CGSize(width: frame.width, height: frame.height)
        }
        
    }
    
    let reuseIdentifier = "connectoCell" // also enter this string as the cell identifier in the storyboard
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !complete {
            var count: Int = 0
            count = game.board.cols() * game.board.rows()
            return count
        } else {
            return 1
        }
        
    }
    
    // make a cell for each cell index path
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ConnectoViewCell
        
        if !complete {
        
            //let v = self.view
            //v?.backgroundColor = UIColor.red
            
            // get a reference to our storyboard cell
            print(indexPath.row.description, terminator:":")
            
            let row = indexPath.row / game.board.cols()
            let col = indexPath.row % game.board.cols()
            cell.setToModel(square: game.board.grid[row][col], jumble: true)
            
            return cell
        } else {
            if let img = self.snap {
                cell.setImage(img: img)
                
            }
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !complete {
            print("You selected cell #\(indexPath.item)!")
            let cell = collectionView.cellForItem(at: indexPath) as! ConnectoViewCell
            cell.rotate()
            if game.board.checkIfSolved() {
                print("solved")
                self.complete = true
                
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                
                self.snap = UIImage(view: self.collectionView!)
                self.collectionView?.reloadData()
                self.collectionView?.layoutIfNeeded()
                let cell = self.collectionView?.visibleCells[0]
                
                UIView.animate(withDuration: 0.0, animations: {
                    //cell?.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                    
                }, completion: { finished in
                    UIView.animate(withDuration: 0.5, animations: {
                        cell?.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
                        
                    }, completion: { finished in
                        UIView.animate(withDuration: 0.00, animations: {
                            cell?.transform = CGAffineTransform(scaleX: 50, y: 50)
                            //cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
                        }, completion: { finished in
                            UIView.animate(withDuration: 0.5, animations: {
                                cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
                            })
                        })
                    })
                })
            }
        } else {
            
        }
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

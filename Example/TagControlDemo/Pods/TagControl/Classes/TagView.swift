//
//  TagView.swift
//  AKTagControl
//
//  Created by prema janoti on 1/31/17.
//  Copyright © 2017 Altimertik. All rights reserved.
//

import UIKit

/** Protocol for Tag view. */
 public protocol TagViewDelegate {

/** called on Tag view delegate whenever Done button is tapped from Tag View.
  - parameter selectedTags : selectedTags reference which are currently selected.
     
 */
    func didTapDoneButton(selectedTags: [String])

/** called on Tag view delegate whenever Cancel button is tapped from Tag View.

 */

    func didTapCancelButton()
}

/**
 Custom Tag View.
 */

open class TagView: UIView {

    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak open var lblSubTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txtTag: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var flowLayout: FlowLayout!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCancel: UIButton!

    /** Array containg Tag name. */
    var stringTags: [String]?

    /** Array containg Tag object. */
    var tags = [Tag]()

    /** Delegate to recive events from Tag view */
    open var delegate: TagViewDelegate?

    /** custom cell for Tag view */
    var sizingCell: TagViewCell?

    var mainView: UIView?
    var bottomConst: NSLayoutConstraint?

    override open func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.backgroundColor = UIColor.clear
        let bun = Bundle(for: self.classForCoder)
        let cellNib = UINib(nibName: "TagViewCell", bundle: bun)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "TagViewCell")
        self.collectionView.backgroundColor = UIColor.clear
        self.sizingCell = ((cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as? TagViewCell?)!
        self.flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        self.btnSend.isEnabled = false
    }

/** Initializes and returns a newly allocated tag view object with the specified delegate, and contents. Content is used as datasource for the Tag View.
 - parameter contents : Array of string contents for datasource.
 - parameter delegate : delegate for the tag view.
 
 */

    open class func initTagView(_ contents: [String]?, delegate: TagViewDelegate ) -> TagView {
        let bun = Bundle(for: self.classForCoder())
        let tagView = bun.loadNibNamed("TagView", owner: self, options: nil)?.last as? TagView
        if tagView != nil {
            if contents != nil && (contents?.count)! > 0 {
                tagView?.stringTags = contents
                tagView?.createTag()
            }

            tagView?.delegate = delegate
        }
        return tagView!

    }

/** Use this method to Add tag over a view.
 - parameter view: UIView over which tag view is required.
 
 */

    open func setupInitialConstraintWRTView(_ view: UIView) {
        self.mainView = view
        self.translatesAutoresizingMaskIntoConstraints = false
        var topConst: NSLayoutConstraint?
        var leadingConst: NSLayoutConstraint?
        var trailingConst: NSLayoutConstraint?

        topConst = NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: self.mainView, attribute: .top, multiplier: 1.0, constant: 64.0)
        self.bottomConst = NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.mainView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        leadingConst = NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: self.mainView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        trailingConst = NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.mainView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        view.addConstraints([topConst!, bottomConst!, leadingConst!, trailingConst!])
    }

    func createTag() {
        for name in stringTags! {
            let tag = Tag()
            tag.name = name
            self.tags.append(tag)
        }
    }

    @IBAction func btnSendTapped(_ sender: Any) {
        let string = self.txtTag.text
        let newString = string?.trimmingCharacters(in: .whitespaces)
        self.addNewTag(newString!)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.delegate != nil {
            let selectedTags = self.getSelectedTags()
            if selectedTags != nil && (selectedTags?.count)! > 0 {
                 self.delegate?.didTapDoneButton(selectedTags: selectedTags!)
            }
        }
    }

    @IBAction func btnCancelTapped(_ sender: Any) {
        if self.delegate != nil {
           self.delegate?.didTapCancelButton()
        }
    }

    func getSelectedTags() -> [String]? {
       var currectSelectedTags = [String]()
        for tag in self.tags {
            if tag.selected == true {
                let tagName = tag.name
                currectSelectedTags.append(tagName!)
            }
        }
        return currectSelectedTags
    }

    // MARK: addNewTag

    func addNewTag(_ newTagString: String) {
        if (newTagString.characters.count) > 0 {
            let newTag = Tag()
            newTag.name = newTagString
            self.tags.append(newTag)
            self.collectionView.reloadData()
            let item = self.collectionView(self.collectionView!, numberOfItemsInSection: 0) - 1
            let lastItemIndex = IndexPath(item: item, section: 0)
            self.collectionView?.scrollToItem(at: lastItemIndex, at: UICollectionViewScrollPosition.top, animated: false)
            self.txtTag.resignFirstResponder()
            self.txtTag.text = ""
            self.btnSend.isEnabled = false
        }
    }

    // MARK: UIView

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }

    @IBAction func editingChanged(_ sender: UITextField) {
        let statusText = sender.text?.trimmingCharacters(in: .whitespaces)

        if (statusText?.characters.count)! < 0 || statusText == "" {
            self.btnSend.isEnabled = false
        } else {
            self.btnSend.isEnabled = true
        }
    }

}

extension TagView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TagViewCellDelegate {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tags.count > 0 {
            return tags.count
        }
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagViewCell", for: indexPath) as? TagViewCell
        cell?.delegate = self
        cell?.indexPath = indexPath
        self.configureCell(cell!, forIndexPath: indexPath)
        return cell!
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.configureCell(self.sizingCell!, forIndexPath: indexPath)
        return self.sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        tags[indexPath.row].selected = !tags[indexPath.row].selected
        self.collectionView.reloadData()
    }

    func configureCell(_ cell: TagViewCell, forIndexPath indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        cell.tagName.text = tag.name
        cell.tagName.textColor = tag.selected ? UIColor.white : UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        cell.backgroundColor = tag.selected ? UIColor.blue : UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }

     func btnCrossTapped(sender: UIButton) {
        let row = sender.tag
        self.tags.remove(at: row)
        self.collectionView.reloadData()
    }

    // MARK: TagViewCellDelegate

      public func didSelectCross(_ forCell: TagViewCell) {
        let row = forCell.indexPath?.row
        self.tags.remove(at: row!)
        self.collectionView.reloadData()
    }

}

extension TagView: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.bottomConstraint.constant = 280
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.bottomConstraint.constant = 8
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let string = textField.text
        let updatedString = string?.trimmingCharacters(in: .whitespaces)
        if (updatedString?.characters.count)! > 0 {
            self.btnSend.isEnabled = true
        } else {
            self.btnSend.isEnabled = false
        }
        return true
    }

}

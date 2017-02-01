//
//  ViewController.swift
//  TagControlDemo
//
//  Created by prema janoti on 1/31/17.
//  Copyright © 2017 prema janoti. All rights reserved.
//

import UIKit
import TagControl

class ViewController: UIViewController, TagViewDelegate {
    var tagView: TagView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnShowTagTapped(_ sender: Any) {
        self.addTagView()

    }

    func addTagView() {
        if self.tagView != nil {
            self.tagView?.removeFromSuperview()
            self.tagView = nil
        }
        let contents = self.tagViewContents()
        self.tagView = TagView.initTagView(contents, delegate: self)
        self.view.addSubview(self.tagView!)
        self.tagView?.setupInitialConstraintWRTView(self.view)
    }

    func tagViewContents() -> [String]? {
        var tags = [String]()
        tags = ["Prema", "Photography", "Design", "Humor", "Love Traveling", "Music", "Writing", "Easy Life", "Education", "Engineer", "Startup", "Funny", "Women In Tech", "Female", "Business", "Songs", "Love", "Food", "Sports"]
        return tags

    }

    func removeTagView() {
        if self.tagView != nil {
            self.tagView?.removeFromSuperview()
            self.tagView = nil
        }
    }

    // MARK: TagView Delegates

    func didTapDoneButton(selectedTags: [String]) {
        print(selectedTags)
        self.removeTagView()
    }

    func didTapCancelButton() {
        self.removeTagView()
    }

}

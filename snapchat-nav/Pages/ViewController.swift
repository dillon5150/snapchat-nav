//
//  ViewController.swift
//  snapchat-nav
//
//  Created by Tom Rochat on 31/12/2019.
//  Copyright © 2019 Tom Rochat. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    private var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let homePage = HomeViewController()
        let rightPage = RightViewController()
        let leftPage = LeftViewController()

        scrollView = UIScrollView.makeHorizontal(with: [leftPage, homePage, rightPage], in: self)
        view.addSubview(scrollView)
        scrollView.fit(to: view)
    }
}

extension UIScrollView {
    public static func makeHorizontal(with controllers: [UIViewController], in parent: UIViewController) -> UIScrollView {
        let scrollView = makeCustom()
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height

        func add(_ child: UIViewController, withOffset offset: CGFloat) {
            parent.addChild(child)
            scrollView.addSubview(child.view)

            child.didMove(toParent: parent)
            child.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                child.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                child.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
                child.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: offset),
            ])
        }

        for (i, controller) in controllers.enumerated() {
            add(controller, withOffset: CGFloat(i) * width)
        }

        scrollView.contentSize = CGSize(width: width * CGFloat(controllers.count), height: height)
        scrollView.setContentOffset(CGPoint(x: width, y: 0), animated: false)

        return scrollView
    }

    private static func makeCustom() -> UIScrollView {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.isPagingEnabled = true
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false

        return view
    }
}

extension UIView {
    public func fit(to container: UIView) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            self.topAnchor.constraint(equalTo: container.topAnchor),
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ])
    }
}

//
//  CustomViewPager.swift
//  BasicCustomView
//
//  Created by taehy.k on 2022/05/05.
//

/*
 Pager는 ContainerView와 PageViewController를 이용해서 구현했습니다.
 */

import UIKit

class CustomViewPager: UIViewController {

    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var barBackgroundView: UIView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var barLeading: NSLayoutConstraint!
    @IBOutlet weak var barWidth: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    // 페이지 뷰 컨트롤러
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    // 컨텐츠로 들어갈 뷰 컨트롤러 배열 -> 여기에 컨텐츠로 들어갈 뷰 컨트롤러를 넣어주면 됩니다.
    private let contents: [UIViewController] = [
        FirstViewController(),
        SecondViewController(),
        ThirdViewController()
    ]
    
    // 현재 몇 번째 페이지를 보고 있는지 체크 위한 인덱스 변수
    private var currentIndex: Int = 0
    // 탭이 클릭된 건지 판단하기 위한 변수(스와이프랑 구분하기 위함)
    private var tappedButton: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPageViewController()
    }
    
    private func setupUI() {
        guard let button = buttonStackView.arrangedSubviews.first as? UIButton else { return }
        barWidth.constant = button.contentSize
        barLeading.constant = button.margin
        pageViewController.view.backgroundColor = .black
    }
    
    private func setupPageViewController() {
        self.addChild(pageViewController)
        containerView.frame = pageViewController.view.frame
        self.containerView.addSubview(pageViewController.view)
        
        pageViewController.didMove(toParent: self)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        if let firstVC = contents.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        
        for subview in pageViewController.view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.delegate = self
            }
        }
    }
    
    @IBAction func tabButtonTapped(_ sender: UIButton) {
        
        guard let index = buttonStackView.arrangedSubviews.firstIndex(where: { $0 == sender }),
              index != currentIndex,
              let button = buttonStackView.arrangedSubviews[index] as? UIButton else {
                  // index를 정확히 가져오지 못하거나
                  // 현재 선택되어 있는 페이지의 탭과 같다면(이동할 필요가 없음)
                  return
              }
        
        // 버튼이 선택되었다는 것을 나타냄(true)
        tappedButton = true
        
        var leadingConstant: CGFloat = 0
        for i in 0..<index {
            leadingConstant += self.buttonStackView.arrangedSubviews[i].frame.width
        }
        leadingConstant += button.margin
        
        UIView.animate(withDuration: 0.3) {
            self.barWidth.constant = button.contentSize
            // 인디케이터(바)를 좌우로 이동시키기 위해 constraint 값 조정
            self.barLeading.constant = leadingConstant
            self.barBackgroundView.layoutIfNeeded()
        }
                
        // 현재 인덱스에 맞는 뷰 컨트롤러
        let content = contents[index]
        
        pageViewController.setViewControllers(
            [content],
            direction: currentIndex < index ? .forward : .reverse, // 현재 보고 있는 페이지가 인덱스(선택한 탭)보다 작아? 그럼 다음 페이지로 가, 아니면 이전 페이지로 가!
            animated: true
        ) { _ in
                self.currentIndex = index
                self.tappedButton = false
        }
    }
}

extension CustomViewPager: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    // Paging 애니메이션이 끝났을 때 처리
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?.first,
              let index = contents.firstIndex(where: { $0 == viewController }) else {
                  return
              }
        currentIndex = index
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = contents.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return contents[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = contents.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == contents.count {
            return nil
        }
        return contents[nextIndex]
    }
}

extension CustomViewPager: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !tappedButton else { return }
        
        let scrollOffsetX = scrollView.contentOffset.x
        let contentSizeWidth = view.frame.size.width
        
        // -1.0 ~ 1.0 (좌우 이동)
        let movement = (scrollOffsetX - contentSizeWidth) / contentSizeWidth

        // 0.0 ~ 2.0
        let currentIdx: CGFloat = movement + CGFloat(currentIndex)
        print(currentIdx)
        let percent: CGFloat = currentIdx - CGFloat(Int(currentIdx))
        
        var leftWidth: CGFloat = 0, rightWidth: CGFloat = 0
        var leftX: CGFloat = 0, rightX: CGFloat = 0
        var leftMargin: CGFloat = 0, rightMargin: CGFloat = 0

        if let leftButton = buttonStackView.arrangedSubviews[Int(currentIdx)] as? UIButton {
            leftWidth = leftButton.contentSize
            leftX = leftButton.frame.origin.x
            leftMargin = leftButton.margin
        }
        
        if Int(currentIdx) + 1 < contents.count,
           let rightButton = buttonStackView.arrangedSubviews[Int(currentIdx) + 1] as? UIButton {
            rightWidth = rightButton.contentSize
            rightX = rightButton.frame.origin.x
            rightMargin = rightButton.margin
        }
        
        let indicatorX = (rightX - leftX) * percent + leftX
        let indicatorWidth = (rightWidth - leftWidth) * percent + leftWidth
        let buttonMargin = (rightMargin - leftMargin) * percent + leftMargin
        
        // Constraints update
        barLeading.constant = indicatorX + buttonMargin
        barWidth.constant = indicatorWidth
    }
}

extension UIButton {
    
    var contentSize: CGFloat {
        return intrinsicContentSize.width
    }
    
    var margin: CGFloat {
        return (frame.width - contentSize) / 2
    }
}

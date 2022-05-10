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
        barWidth.constant = view.bounds.width / CGFloat(buttonStackView.arrangedSubviews.count)
        pageViewController.view.backgroundColor = .black
    }
    
    private func setupPageViewController() {
        
                
        self.addChild(pageViewController)
                
        // containerView와 pageViewController의 frame은 다를 수 밖에 없다.
        // 높이는 당연히 다르고, containerView의 frame은 스토리보드에서 작업한 기기 크기에 따라서 달라진다.
        print("전", containerView.frame, pageViewController.view.frame)
        containerView.frame = pageViewController.view.frame
        print("후", containerView.frame, pageViewController.view.frame)
        
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
              index != currentIndex else {
                  // index를 정확히 가져오지 못하거나
                  // 현재 선택되어 있는 페이지의 탭과 같다면(이동할 필요가 없음)
                  return
              }
        
        // 버튼이 선택되었다는 것을 나타냄(true)
        tappedButton = true
        
        UIView.animate(withDuration: 0.3) {
            // 인디케이터(바)를 좌우로 이동시키기 위해 constraint 값 조정
            self.barLeading.constant = CGFloat(index) * self.barView.frame.width
            self.barBackgroundView.layoutIfNeeded()
        }
        
        // 현재 인덱스에 맞는 뷰 컨트롤러
        let content = contents[index]
        
        pageViewController.setViewControllers(
            [content],
            direction: currentIndex < index ? .forward : .reverse, // 현재 보고 있는 페이지가 인덱스(선택한 탭)보다 작아? 그럼 다음 페이지로 가, 아니면 이전 페이지로 가!
            animated: true) { _ in
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 스와이프랑 탭 클릭이랑 구분하기 위한 코드
        guard !tappedButton else { return }
        
        let offsetX = scrollView.contentOffset.x
        let contentWidth = pageViewController.view.frame.width
        
        // 0 ~ 1 (좌우로 얼마나 움직였는지 체크하기 위한 퍼센티지)
        let percent = (offsetX - contentWidth) / contentWidth
        
        let constant = (CGFloat(currentIndex) + percent) * barView.frame.width
        barView.frame.origin.x = constant
    }
}

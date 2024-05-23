
import UIKit

// Inspired by non-swift3 version of https://github.com/AliSoftware/Reusable

// MARK: Code-based Reusable

/// Protocol for `UITableViewCell` and `UICollectionViewCell` subclasses when they are code-based
public protocol ActualReusable: AnyObject {
    
  static var reuseIdentifier: String { get }
    
}

public extension ActualReusable {
    
  static var reuseIdentifier: String {
    String(describing: self)
  }
    
}

// MARK: - NIB-based Reusable

/// Protocol for `UITableViewCell` and `UICollectionViewCell` subclasses when they are NIB-based
public protocol ActualNibReusable: ActualReusable, ActualNibLoadable {}

public protocol ActualNibLoadable: AnyObject {
    
  static var nib: UINib { get }
    
}

public extension ActualNibLoadable {
    
  static var nib: UINib {
    UINib(nibName: String(describing: self), bundle: Bundle(for: self))
  }
    
}

typealias ActualReusable_one = UITableView

public extension ActualReusable_one {
//public extension UITableView {
  // MARK: UITableViewCell
  /** Register a NIB-Based `UITableViewCell` subclass (conforming to `NibReusable`) */
  final func actualRegisterReusable_Cell<T: UITableViewCell>(cellType: T.Type) where T: ActualNibReusable {
    register(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
  }
  
  /** Register a Class-Based `UITableViewCell` subclass (conforming to `Reusable`) */
  final func actualRegisterReusable_Cell<T: UITableViewCell>(cellType: T.Type) where T: ActualReusable {
    register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
  }
  
  /** Returns a reusable `UITableViewCell` object for the class inferred by the return-type */
  final func actualВequeueReusableCell<T: UITableViewCell>(_ indexPath: IndexPath, cellType: T.Type = T.self) -> T
    where T: ActualReusable {

      guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
        fatalError(
          "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) "
            + "matching type \(cellType.self). "
            + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
            + "and that you registered the cell beforehand"
        )
      }
      
      return cell
  }
  
  // MARK: UITableViewHeaderFooterView
  
  /** Register a NIB-Based `UITableViewHeaderFooterView` subclass (conforming to `NibReusable`) */
  final func actualRegisterReusableHeaderFooterView<T: UITableViewHeaderFooterView>(viewType: T.Type) where T: ActualNibReusable {
    register(viewType.nib, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
  }
  
  /** Register a Class-Based `UITableViewHeaderFooterView` subclass (conforming to `Reusable`) */
  final func actualRegisterReusableHeaderFooterView<T: UITableViewHeaderFooterView>(viewType: T.Type) where T: ActualReusable {
      
    register(viewType.self, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
      
  }
  
  /** Returns a reusable `UITableViewHeaderFooterView` object for the class inferred by the return-type */
  final func actualDequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(viewType: T.Type = T.self) -> T?
    where T: ActualReusable {
        
    guard let view = dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T? else {
     
      fatalError(
        "Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) "
          + "matching type \(viewType.self). "
          + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
          + "and that you registered the header/footer beforehand"
      )
    }
    return view
  }
    
}

open class ActualNiblessView: UIView {

    func actualOneCheck() -> Int{
    var checkOne = 93 + 3 * 2
    var checkTwo = checkOne - 22
    checkTwo += 11
    return checkTwo
    }
    
  public init() {
    super.init(frame: .zero)
  }
    
  @available(*, unavailable)
  required public init?(coder aDecoder: NSCoder) {
    fatalError("Init is not implemented")
  }
}


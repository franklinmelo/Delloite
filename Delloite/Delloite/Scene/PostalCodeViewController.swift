import Foundation
import UIKit

final class PostalCodeViewController: UIViewController {
    private lazy var initLable: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Init Test"
        return $0
    }(UILabel())
    
    private var viewModel: PostalCodeViewModelProtocol?
    
    init(viewModel: PostalCodeViewModelProtocol = PostalCodeViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        setupView()
        setupConstraints()
        configureViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getContacts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.addSubview(initLable)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            initLable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            initLable.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func configureViews() {
        initLable.text = viewModel?.postalCodes.first?.desigPostal
    }
}

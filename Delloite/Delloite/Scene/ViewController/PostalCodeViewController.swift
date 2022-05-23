import Foundation
import UIKit

final class PostalCodeViewController: UIViewController {
    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(PostalCodeCell.self, forCellReuseIdentifier: "PostalCodeCell")
        return $0
    }(UITableView(frame: .zero))
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIActivityIndicatorView())
    
    private lazy var searchController: UISearchController = {
        $0.hidesNavigationBarDuringPresentation = false
        return $0
    }(UISearchController(searchResultsController: nil))
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    private var viewModel: PostalCodeViewModelProtocol?
    
    private var tablewViewBottonConstraint: NSLayoutConstraint = .init()
    
    init(viewModel: PostalCodeViewModelProtocol = PostalCodeViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        configureViews()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        tablewViewBottonConstraint = NSLayoutConstraint(item: view.safeAreaLayoutGuide,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: tableView,
                                                        attribute: .bottom,
                                                        multiplier: 1,
                                                        constant: 0)
        self.view.addConstraint(tablewViewBottonConstraint)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func configureViews() {
        activityIndicator.startAnimating()
        title = "Postal code list"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        viewModel?.getContacts { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            tablewViewBottonConstraint.constant = keyboardHeight
            view.layoutIfNeeded()
        }
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        tablewViewBottonConstraint.constant = 0
        view.layoutIfNeeded()
    }
}

extension PostalCodeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel?.filterContacts(with: searchText, completion: { [weak self] in
            self?.tableView.reloadData()
        })
    }
}

extension PostalCodeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostalCodeCell", for: indexPath) as? PostalCodeCell else {
            return UITableViewCell()
        }
        guard let postalCodeValue = isFiltering
                ? viewModel?.filteredPostalCodes[indexPath.row].formatedPostalCode
                : viewModel?.postalCodes[indexPath.row].formatedPostalCode else {
            return UITableViewCell()
        }
        cell.setLabel(with: postalCodeValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return viewModel?.filteredPostalCodes.count ?? 0
        }
        return viewModel?.postalCodes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

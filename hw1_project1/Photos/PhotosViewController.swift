import UIKit

final class PhotosViewController: UICollectionViewController {
    private let networkService = NetworkService()
    private var photos: [Photo] = []
    private var themeView = ThemeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Фотографии"
        themeView.delegate = self
        setupCollectionView()
        loadPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAppearance()
    }
    
    private func setupAppearance() {
        view.backgroundColor = Theme.currentTheme.backgroundColor

        collectionView.backgroundColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.barTintColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.tintColor = Theme.currentTheme.textColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.currentTheme.textColor]
    }

    
    private func setupCollectionView() {
        collectionView.backgroundColor = Theme.currentTheme.backgroundColor
        collectionView.register(CustomPhotoViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
        }
    }
    
    private func loadPhotos() {
        networkService.getPhotos { [weak self] photos in
            self?.photos = photos
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        guard let cell = cell as? CustomPhotoViewCell else { return UICollectionViewCell() }

        let photo = photos[indexPath.item]
        cell.configure(with: photo)

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CustomPhotoViewCell,
           let image = cell.imageView.image {
            let detailVC = ImageViewController(image: image)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, ThemeViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let collectionViewSize = collectionView.frame.width - padding * 3
        let width = collectionViewSize / 2
        return CGSize(width: width, height: width)
    }
    
    func updateColor() {
        setupAppearance()
        collectionView.reloadData()
    }
}

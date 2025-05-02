import UIKit

final class PhotosViewController: UICollectionViewController {
    private let networkService = NetworkService()
    private var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Фотографии"
        setupCollectionView()
        loadPhotos()
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .lightGray
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

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let collectionViewSize = collectionView.frame.width - padding * 3
        let width = collectionViewSize / 2
        return CGSize(width: width, height: width)
    }
}

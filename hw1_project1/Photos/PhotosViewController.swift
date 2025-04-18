import UIKit

final class PhotosViewController: UICollectionViewController {
    private let imageNames = ["photo1", "photo2", "photo3", "photo4", "photo5", "photo6"]
    private var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .lightGray
        collectionView.register(CustomPhotoViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
        }
        
        networkService.getPhotos()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { imageNames.count }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        guard let cell = cell as? CustomPhotoViewCell else { return UICollectionViewCell() }
        let imageName = imageNames[indexPath.item]
        if let image = UIImage(named: imageName) {
            cell.configure(with: image)
        }
        
        cell.tap = { [weak self] image in
            self?.navigationController?.pushViewController(ImageViewController(image: image), animated: true)
        }
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let collectionViewSize = collectionView.frame.size.width - padding * 3
        let width = collectionViewSize / 2
        return CGSize(width: width, height: width)
    }
}
